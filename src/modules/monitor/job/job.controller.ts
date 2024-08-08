import { Controller, Get, Post, Body, Param, Delete, Put, Query } from '@nestjs/common';
import { JobService } from './job.service';
import { CreateJobDto } from './dto/create-job.dto';
import { UpdateJobDto } from './dto/update-job.dto';
import { SearchJobDto } from './dto/search-job.dto';
import { DataResult, UpdateStateDto } from 'src/utility/common';
import { LogRecordAction, Permission } from 'src/utility/decorator';

@Controller('monitor/job')
export class JobController {
  constructor(private readonly jobService: JobService) {}

  @Post()
  @Permission('monitor_job_add')
  @LogRecordAction('创建定时任务', 'create')
  async create(@Body() createJobDto: CreateJobDto) {
    await this.jobService.create(createJobDto);
    return DataResult.ok();
  }

  @Post('once/:id')
  @Permission('monitor_job_execute')
  @LogRecordAction('立即执行定时任务', 'other')
  async once(@Param('id') id: string) {
    await this.jobService.once(+id);
    return DataResult.ok('执行成功');
  }

  /** 分页查询定时表达式 */
  @Get('list')
  async list(@Query() query: SearchJobDto) {
    const res = await this.jobService.list(query);
    return DataResult.ok(res);
  }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    const res = await this.jobService.findOne(+id);
    return DataResult.ok(res);
  }

  @Put()
  @Permission('monitor_job_edit')
  @LogRecordAction('更新定时任务', 'update')
  async update(@Body() updateJobDto: UpdateJobDto) {
    const res = await this.jobService.update(updateJobDto);
    return DataResult.ok(res);
  }

  @Delete(':id')
  @Permission('monitor_job_delete')
  @LogRecordAction('删除定时任务', 'delete')
  remove(@Param('id') id: string) {
    return this.jobService.remove(+id);
  }

  @Post('status')
  @Permission('monitor_job_status')
  @LogRecordAction('启动、停止 定时任务', 'update')
  async status(@Body() updateStateDto: UpdateStateDto) {
    await this.jobService.updateStatus(updateStateDto);
    return DataResult.ok();
  }
}
