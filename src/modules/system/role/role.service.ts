import { Injectable } from '@nestjs/common';
import { InjectEntityManager, InjectRepository } from '@nestjs/typeorm';
import { Repository, Not, FindOptionsWhere, Like, In, EntityManager } from 'typeorm';
import { CreateRoleDto } from './dto/create-role.dto';
import { UpdateRoleDto } from './dto/update-role.dto';
import { ApiException } from 'src/utility/common/api.exception';
import { ApiCode, RedisCache } from 'src/utility/enums';
import { SearchRoleDto } from './dto/search-role.dto';
import { RoleMenuAuthorizeDto } from './dto/role-menu-authorize.dto';
import { RoleEnum } from './enums/role.enum';
import { SysRole } from './entities/role';
import { SysRoleMenu } from './entities/role-menu';
import { SysMenu } from '../menu/entities/menu';
import { RedisService } from 'src/modules/redis/redis.service';
import ms = require('ms');

@Injectable()
export class RoleService {
  @InjectRepository(SysRole)
  private readonly roleRepository: Repository<SysRole>;

  @InjectRepository(SysRoleMenu)
  private readonly roleMenuRepository: Repository<SysRoleMenu>;

  @InjectEntityManager()
  private readonly entityManager: EntityManager;

  constructor(private redisService: RedisService) {}

  /** 授权 */
  async authorize(roleMenuAuthorizeDto: RoleMenuAuthorizeDto) {
    const { roleId, menuIds, defaultNavigate } = roleMenuAuthorizeDto;

    // 查询当前角色所有菜单
    const currentRoleMenus = await this.roleMenuRepository.find({
      where: { roleId: roleMenuAuthorizeDto.roleId }
    });

    const currentMenuIds = currentRoleMenus.map((item) => item.menuId);

    // 找出需要删除的菜单id
    const menuIdsToDelete = currentMenuIds.filter((menuId) => !menuIds.includes(menuId));

    // 找出需要添加的菜单id
    const menuIdsToAdd = menuIds.filter((menuId) => !currentMenuIds.includes(menuId));

    await this.entityManager.transaction(async () => {
      await this.roleRepository.update(roleId, {
        defaultNavigate
      });
      // 批量删除需要删除的关联
      if (menuIdsToDelete.length > 0) {
        await this.roleMenuRepository.delete({
          roleId,
          menuId: In(menuIdsToDelete)
        });
      }

      // 批量插入需要添加的关联
      if (menuIdsToAdd.length > 0) {
        const newRoleMenus = menuIdsToAdd.map((menuId) => {
          const roleMenu = new SysRoleMenu();
          roleMenu.roleId = roleId;
          roleMenu.menuId = menuId;
          return roleMenu;
        });
        await this.roleMenuRepository.save(newRoleMenus);
      }
    });
  }

  /** 通过角色id获取授权的菜单集合 */
  async getAuthorizeMenuIds(roleId: number) {
    return this.roleMenuRepository.find({ where: { roleId } });
  }

  async create(createRoleDto: CreateRoleDto) {
    const role = await this.roleRepository.findOneBy({
      name: createRoleDto.name
    });
    if (role) throw new ApiException('角色名称已存在', ApiCode.DATA_INVALID);

    return await this.roleRepository.save(createRoleDto);
  }

  async list(query: SearchRoleDto) {
    const where: FindOptionsWhere<SysRole> = {};
    if (query.name) {
      where.name = Like(`%${query.name}%`);
    }
    return await this.roleRepository.find({ where });
  }

  async findOne(id: number) {
    const role = await this.roleRepository.findOne({
      where: { id },
      select: ['id', 'name', 'remark', 'defaultNavigate', 'code']
    });
    if (!role) throw new ApiException('角色未找到', ApiCode.DATA_NOT_FOUND);
    return role;
  }

  async update(updateRoleDto: UpdateRoleDto) {
    const res = await this.findOne(updateRoleDto.id);
    if (!res) throw new ApiException('数据不存在', ApiCode.DATA_NOT_FOUND);
    if (res.type === RoleEnum.system) throw new ApiException('内置角色不能修改', ApiCode.ERROR);

    const role = await this.roleRepository.findOne({
      where: {
        name: updateRoleDto.name,
        id: Not(updateRoleDto.id)
      }
    });
    if (role) throw new ApiException('角色名称已存在', ApiCode.ERROR);

    const updateResult = await this.roleRepository.update(updateRoleDto.id, updateRoleDto);
    if (updateResult.affected === 0) {
      throw new ApiException('更新失败', ApiCode.DATA_NOT_FOUND);
    }
    return updateResult;
  }

  async remove(id: number) {
    const role = await this.findOne(id);
    if (role.type === RoleEnum.system) throw new ApiException('内置角色不能删除', ApiCode.ERROR);

    await this.entityManager.transaction(async () => {
      await this.roleRepository.delete(id);
      await this.roleMenuRepository.delete({ roleId: id });
    });
    return true;
  }

  private async cacheMenu(menu: SysMenu[], roleId: number) {
    const menuCacheKey = `${RedisCache.ROLE_MENU}${roleId}`;
    const buttonCacheKey = `${RedisCache.ROLE_BUTTON_PERMISSION}${roleId}`;
    const cacheDay = ms('7d');
    this.redisService.set(
      menuCacheKey,
      menu.filter((item) => item.type !== 2),
      cacheDay
    );

    this.redisService.set(
      buttonCacheKey,
      menu.filter((item) => item.type === 2),
      cacheDay
    );
  }

  /** 通过用户角色查询启用的菜单 */
  async getMenusForUser(roleId: number): Promise<SysMenu[]> {
    const authorizedMenuInfos = await this.roleMenuRepository
      .createQueryBuilder('role_menu')
      .innerJoin('sys_role', 'role', 'role.id=role_menu.roleId')
      .leftJoin('sys_user', 'user', 'user.roleId=role.id')
      .where(`role.id=:id`, { id: roleId })
      .getMany();

    const menuIds = authorizedMenuInfos.map((menu) => menu.menuId);

    if (menuIds.length === 0) {
      return [];
    }

    const query = `
    WITH RECURSIVE menu_tree AS (
      SELECT 
        id, 
        sort, 
        component, 
        display, 
        icon,
        status,
        open_type AS openType, 
        parent_id AS parentId, 
        url, 
        params, 
        name, 
        type, 
        code,
        delete_time,
        fixed
      FROM sys_menu
      WHERE id IN (${menuIds.join(',')})
      AND status = 1
      UNION
      SELECT 
        m.id, 
        m.sort, 
        m.component, 
        m.display, 
        m.icon, 
        m.status,
        m.open_type AS openType, 
        m.parent_id AS parentId, 
        m.url, 
        m.params, 
        m.name, 
        m.type, 
        m.code,
        m.delete_time,
        m.fixed
      FROM sys_menu m
      INNER JOIN menu_tree mt ON mt.parentId = m.id
      AND m.status=1
    )
    SELECT * FROM menu_tree
         where delete_time is null
     ORDER BY sort ASC;
  `;
    const res = await this.roleMenuRepository.query(query);
    this.cacheMenu(res, roleId);
    return res;
  }
}
