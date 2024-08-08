import { RedisService } from 'src/modules/redis/redis.service';
import { Controller, Get, Post, Body, Param, Delete, Put, Query } from '@nestjs/common';
import { RoleService } from './role.service';
import { CreateRoleDto } from './dto/create-role.dto';
import { UpdateRoleDto } from './dto/update-role.dto';
import { DataResult } from 'src/utility/common/data.result';
import { SearchRoleDto } from './dto/search-role.dto';
import { RoleMenuAuthorizeDto } from './dto/role-menu-authorize.dto';
import { LogRecordController, LogRecordAction, Permission } from 'src/utility/decorator';
import { RedisCache } from 'src/utility/enums';

@Controller('system/role')
@LogRecordController('角色管理')
export class RoleController {
  constructor(private readonly roleService: RoleService, private redisService: RedisService) {}

  @Post()
  @LogRecordAction('创建角色')
  @Permission('system_role_add')
  async create(@Body() createRoleDto: CreateRoleDto) {
    await this.roleService.create(createRoleDto);
    return DataResult.ok();
  }

  @Get()
  async list(@Query() query: SearchRoleDto) {
    const res = await this.roleService.list(query);
    return DataResult.ok(res);
  }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    const res = await this.roleService.findOne(+id);
    if (res) return DataResult.ok(res);
  }

  @Put()
  @LogRecordAction('修改角色', 'update')
  @Permission('system_role_edit')
  async update(@Body() updateRoleDto: UpdateRoleDto) {
    await this.roleService.update(updateRoleDto);
    return DataResult.ok();
  }

  @Delete(':id')
  @Permission('system_role_delete')
  @LogRecordAction('删除角色', 'delete')
  async remove(@Param('id') id: string) {
    await this.roleService.remove(+id);
    return DataResult.ok();
  }

  @Post('authorize')
  @LogRecordAction('通过角色菜单授权')
  @Permission('system_role_accredit')
  async authorize(@Body() roleMenuAuthorizeDto: RoleMenuAuthorizeDto) {
    await this.roleService.authorize(roleMenuAuthorizeDto);
    const menuCacheKey = `${RedisCache.ROLE_MENU}${roleMenuAuthorizeDto.roleId}`;
    const buttonCacheKey = `${RedisCache.ROLE_BUTTON_PERMISSION}${roleMenuAuthorizeDto.roleId}`;
    this.redisService.delete(menuCacheKey);
    this.redisService.delete(buttonCacheKey);
    return DataResult.ok();
  }

  /** 获取授权的菜单信息 */
  @Get(':id/authorize')
  async getAuthorizeMenuIds(@Param('id') id: string) {
    const res = await this.roleService.getAuthorizeMenuIds(+id);
    return DataResult.ok(res.map((item) => item.menuId));
  }
}
