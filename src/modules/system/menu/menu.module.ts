import { Module } from '@nestjs/common';
import { MenuService } from './menu.service';
import { MenuController } from './menu.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { SysRoleMenu } from '../role/entities/role-menu';
import { SysMenu } from './entities/menu';
import { RoleService } from '../role/role.service';
import { SysRole } from '../role/entities/role';

@Module({
  imports: [TypeOrmModule.forFeature([SysMenu, SysRoleMenu, SysRole])],
  controllers: [MenuController],
  providers: [MenuService, RoleService],
  exports: [MenuService]
})
export class MenuModule {}
