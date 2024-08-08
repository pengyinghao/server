import { CallHandler, ExecutionContext, HttpStatus, Injectable, NestInterceptor } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { RedisService } from 'src/modules/redis/redis.service';
import { PERMISSION } from '../decorator';
import { Observable } from 'rxjs';
import { Request } from 'express';
import { ApiCode, RedisCache } from '../enums';
import { SysMenu } from 'src/modules/system/menu/entities/menu';
import { ApiException } from '../common';

@Injectable()
export class PermissionInterceptor implements NestInterceptor {
  constructor(private redisService: RedisService, private readonly reflector: Reflector) {}
  async intercept(context: ExecutionContext, next: CallHandler): Promise<Observable<any>> {
    const handler = this.reflector.getAllAndOverride(PERMISSION, [context.getHandler()]);
    if (!handler) {
      return next.handle();
    }

    const request = context.switchToHttp().getRequest<Request>();
    const buttonCacheKey = `${RedisCache.ROLE_BUTTON_PERMISSION}${request.user.id}`;
    // 方法设置的按钮code
    let values = handler[0];

    const buttonPermission = await this.redisService.get<SysMenu[]>(buttonCacheKey);
    if (buttonPermission && buttonPermission.length > 0) {
      // 如果是字符串 转换为数组
      if (typeof values === 'string') {
        values = [values];
      }
      const flag = buttonPermission.map((item) => item.code).some((item) => values.includes(item));
      if (flag) {
        return next.handle();
      } else {
        throw new ApiException('未授权', ApiCode.FORBIDDEN, HttpStatus.FORBIDDEN);
      }
    } else {
      throw new ApiException('会话已过期，请重新登录', ApiCode.SESSION_EXPIRED, HttpStatus.GATEWAY_TIMEOUT);
    }
  }
}
