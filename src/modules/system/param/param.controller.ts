import { Controller, Get, Post, Body, Param, Delete, Put, Query } from '@nestjs/common';
import { ParamService } from './param.service';
import { CreateParamDto } from './dto/create-param.dto';
import { UpdateParamDto } from './dto/update-param.dto';
import { SearchParamsPageDto } from './dto/search-param-page.dto';
import { PagingResponse } from 'src/utility/common/api.paging.response';
import { DataResult } from 'src/utility/common/data.result';
import { LogRecordAction, Permission } from 'src/utility/decorator';

@Controller('/system/param')
export class ParamController {
  constructor(private readonly paramsService: ParamService) {}

  @Post()
  @Permission('system_param_add')
  @LogRecordAction('添加参数', 'update')
  async create(@Body() createParamDto: CreateParamDto) {
    await this.paramsService.create(createParamDto);
    return DataResult.ok();
  }

  @Get()
  async pageUser(@Query() query: SearchParamsPageDto): Promise<DataResult<PagingResponse>> {
    const result = await this.paramsService.page(query);
    return DataResult.ok(result);
  }

  @Get('/label/:label')
  async findOne(@Param('label') label: string) {
    const res = await this.paramsService.findOne(label);
    return DataResult.ok(res);
  }

  @Get(':id')
  async findDetail(@Param('id') id: string) {
    const res = await this.paramsService.findDetail(+id);
    return DataResult.ok(res);
  }

  @Put()
  @Permission('system_param_edit')
  @LogRecordAction('更新参数', 'update')
  async update(@Body() updateParamDto: UpdateParamDto) {
    await this.paramsService.update(updateParamDto);
    return DataResult.ok();
  }

  @Delete(':id')
  @Permission('system_param_delete')
  @LogRecordAction('删除参数', 'update')
  async remove(@Param('id') id: string) {
    await this.paramsService.remove(+id);
    return DataResult.ok();
  }
}
