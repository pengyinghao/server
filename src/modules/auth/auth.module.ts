import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { LocalStrategy } from './strategys/local.strategy';
import { TypeOrmModule } from '@nestjs/typeorm';
import { SysUser } from '../system/user/entities/user';
import { JwtStrategy } from './strategys/jwt.strategy';
import { UserService } from '../system/user/user.service';
import { LoginLogService } from '../log/login-log/login-log.service';
import { SysLoginLog } from '../log/login-log/entities/login-log';

@Module({
  imports: [TypeOrmModule.forFeature([SysUser, SysLoginLog])],
  providers: [LocalStrategy, JwtStrategy, AuthService, UserService, LoginLogService]
})
export class AuthModule {}
