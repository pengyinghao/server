import { Module } from '@nestjs/common';
import { UserService } from './user.service';
import { UserController } from './user.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { SysUser } from './entities/user';
import { RoleService } from '../role/role.service';
import { SysRole } from '../role/entities/role';
import { SysRoleMenu } from '../role/entities/role-menu';
import { LoginLogService } from 'src/modules/log/login-log/login-log.service';
import { SysLoginLog } from 'src/modules/log/login-log/entities/login-log';
@Module({
  imports: [TypeOrmModule.forFeature([SysUser, SysRole, SysRoleMenu, SysLoginLog])],
  controllers: [UserController],
  providers: [UserService, RoleService, LoginLogService],
  exports: [UserService]
})
export class UserModule {}
