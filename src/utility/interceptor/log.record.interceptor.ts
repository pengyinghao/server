import { CallHandler, ExecutionContext, Injectable, Logger, NestInterceptor } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { Observable, tap } from 'rxjs';
import { LOG_RECORD_ACTION, LOG_RECORD_CONTROLLER } from '../decorator';
import { Request } from 'express';
import { HttpService } from 'src/modules/http/http.service';
import useragent = require('useragent');
import { ActionLogService } from 'src/modules/log/action-log/action-log.service';
import { ActionStatus } from 'src/modules/log/action-log/enums/action.status.enum';

@Injectable()
export class LogRecordInterceptor implements NestInterceptor {
  private readonly logger = new Logger(LogRecordInterceptor.name);
  constructor(private httpService: HttpService, private readonly reflector: Reflector, private logService: ActionLogService) {}

  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    const request = context.switchToHttp().getRequest<Request>();
    const start = Date.now(); // 请求开始时间

    const recordModule = this.reflector.get<string>(LOG_RECORD_CONTROLLER, context.getClass());
    if (!recordModule) return next.handle();

    const recordACtion = this.reflector.get<string[]>(LOG_RECORD_ACTION, context.getHandler());
    if (!recordACtion) {
      return next.handle();
    }

    const { method } = request;
    const userAgent = useragent.parse(request.headers['user-agent']);
    return next.handle().pipe(
      tap(async (res) => {
        this.logger.log(`Response: ${JSON.stringify(res)}`);

        const { addr, ip } = await this.httpService.ipToCity(request);
        const obj = {
          moduleName: recordModule,
          actionMessage: recordACtion[0],
          actionType: recordACtion[1],
          actionName: request.user.name,
          actionIp: ip,
          actionAddress: addr,
          actionFunction: `${context.getClass().name}.${context.getHandler().name}`,
          createTime: new Date(),
          requestMethod: method,
          requestUrl: request.url,
          requestParams: JSON.stringify(request.body),
          costTime: Date.now() - start,
          os: userAgent.os.toString(),
          browser: userAgent.toAgent(),
          status: ActionStatus.SUCCESS
        };
        this.logService.create(obj);
      })
    );
  }
}
