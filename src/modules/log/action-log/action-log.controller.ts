import { Controller, Get, Query } from '@nestjs/common';
import { ActionLogService } from './action-log.service';
import { SearchLogDto } from './dto/search-log.dto';
import { DataResult } from 'src/utility/common/data.result';

@Controller('log/action')
export class ActionLogController {
  constructor(private readonly logService: ActionLogService) {}

  @Get('list')
  async pagination(@Query() query: SearchLogDto) {
    const res = await this.logService.pagination(query);
    return DataResult.ok(res);
  }
}
