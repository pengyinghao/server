import { Module } from '@nestjs/common';
import { RoleService } from './role.service';
import { RoleController } from './role.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { SysRole } from './entities/role';
import { SysRoleMenu } from './entities/role-menu';
import { CacheMenuListener } from './listeners/cache-menu.listener';

@Module({
  imports: [TypeOrmModule.forFeature([SysRoleMenu, SysRole])],
  controllers: [RoleController],
  providers: [RoleService, CacheMenuListener],
  exports: [RoleService]
})
export class RoleModule {}
