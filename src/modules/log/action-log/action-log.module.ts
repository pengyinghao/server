import { Module } from '@nestjs/common';
import { ActionLogService } from './action-log.service';
import { ActionLogController } from './action-log.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { SysLog } from './entities/log';

@Module({
  imports: [TypeOrmModule.forFeature([SysLog])],
  controllers: [ActionLogController],
  providers: [ActionLogService],
  exports: [ActionLogService]
})
export class ActionLogModule {}
