import { ClassSerializerInterceptor, Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { APP_FILTER, APP_GUARD, APP_INTERCEPTOR, APP_PIPE } from '@nestjs/core';
import { ResponseInterceptor } from './utility/interceptor/response.interceptor';
import { AuthorizationGuard } from './utility/guard/authorization.guard';
import { HttpExceptionFilter } from './utility/filter/http.exception.filter';
import { ValidationPipe } from './utility/pipe/validation.pipe';
import { ConfigModule, ConfigService } from '@nestjs/config';
import config from './config';
import { TypeOrmModule, TypeOrmModuleOptions } from '@nestjs/typeorm';
import { JwtModule } from '@nestjs/jwt';
import { DatabaseExceptionFilter } from './utility/filter/data.base.exception.filter';
import { LogRecordInterceptor } from './utility/interceptor/log.record.interceptor';

import { CommonModule } from './modules/common/common.module';
import { RedisModule } from './modules/redis/redis.module';
import { HttpModule } from './modules/http/http.module';

import { UserModule } from './modules/system/user/user.module';
import { MenuModule } from './modules/system/menu/menu.module';
import { RoleModule } from './modules/system/role/role.module';
import { DictModule } from './modules/system/dict/dict.module';
import { DictTypeModule } from './modules/system/dict-type/dict-type.module';
import { UploadModule } from './modules/system/upload/upload.module';
import { ParamModule } from './modules/system/param/param.module';
import { OnlineModule } from './modules/monitor/online/online.module';
import { JobModule } from './modules/monitor/job/job.module';
import { TaskModule } from './task/task.module';
import { JobLogModule } from './modules/monitor/job-log/job-log.module';
import { AuthModule } from './modules/auth/auth.module';
import { WebsocketModule } from './modules/websocket/websocket.module';

import { ActionLogModule } from './modules/log/action-log/action-log.module';
import { LoginLogModule } from './modules/log/login-log/login-log.module';
import { PermissionInterceptor } from './utility/interceptor/permission.interceptor';

import { EventEmitterModule } from '@nestjs/event-emitter';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      load: [config]
    }),

    // default
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      inject: [ConfigService],
      async useFactory(configService: ConfigService) {
        return {
          type: 'mysql',
          entities: [`${__dirname}/**/*.entity{.ts,.js}`],
          autoLoadEntities: true,
          keepConnectionAlive: true,
          ...configService.get('db.mysql')
        } as TypeOrmModuleOptions;
      }
    }),

    JwtModule.registerAsync({
      global: true,
      imports: [ConfigModule],
      inject: [ConfigService],
      useFactory(configService: ConfigService) {
        return {
          secret: configService.get('jwt.secret'),
          signOptions: {
            expiresIn: configService.get('jwt.expiresIn')
          }
        };
      }
    }),

    CommonModule,
    RedisModule,
    HttpModule,
    UserModule,
    MenuModule,
    RoleModule,
    DictModule,
    DictTypeModule,
    UploadModule,
    ParamModule,
    JobModule,
    LoginLogModule,
    OnlineModule,
    JobLogModule,
    TaskModule.forRoot(),
    EventEmitterModule.forRoot(),
    AuthModule,
    WebsocketModule,
    ActionLogModule,
    LoginLogModule
  ],
  controllers: [AppController],
  providers: [
    AppService,
    {
      provide: APP_INTERCEPTOR,
      useClass: PermissionInterceptor
    },
    {
      provide: APP_INTERCEPTOR,
      useClass: LogRecordInterceptor
    },
    {
      provide: APP_INTERCEPTOR,
      useClass: ResponseInterceptor
    },
    {
      provide: APP_INTERCEPTOR,
      useClass: ClassSerializerInterceptor
    },
    {
      provide: APP_GUARD,
      useClass: AuthorizationGuard
    },
    {
      provide: APP_FILTER,
      useClass: DatabaseExceptionFilter
    },
    {
      provide: APP_FILTER,
      useClass: HttpExceptionFilter
    },
    {
      provide: APP_PIPE,
      useClass: ValidationPipe
    }
  ]
})
export class AppModule {}
