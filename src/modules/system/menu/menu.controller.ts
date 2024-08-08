import { Controller, Get, Post, Body, Param, Delete, Query, Put } from '@nestjs/common';
import { MenuService } from './menu.service';
import { CreateMenuDto } from './dto/create-menu.dto';
import { UpdateMenuDto } from './dto/update-menu.dto';
import { SearchMenuDto } from './dto/search-menu.dt';
import { DataResult } from 'src/utility/common/data.result';
import { LogRecordAction, LogRecordController, Permission } from 'src/utility/decorator';
import { EventEmitter2 } from '@nestjs/event-emitter';
@Controller('system/menu')
@LogRecordController('菜单管理')
export class MenuController {
  constructor(private readonly menuService: MenuService, private eventEmitter: EventEmitter2) {}

  private cacheMenu() {
    this.eventEmitter.emit('reload.cache.menu');
  }

  @Post()
  @Permission('system_menu_add')
  @LogRecordAction('创建菜单')
  async create(@Body() createMenuDto: CreateMenuDto) {
    await this.menuService.create(createMenuDto);
    this.cacheMenu();
    return DataResult.ok('创建成功');
  }

  @Get('all')
  async findAll() {
    const res = await this.menuService.findAll();
    return DataResult.ok(res);
  }

  /** 获取树形菜单 */
  @Get('tree_menu')
  async treeMenu() {
    const result = await this.menuService.treeMenu();
    return DataResult.ok(result);
  }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    const res = await this.menuService.findOne(+id);
    return DataResult.ok(res);
  }

  @Put()
  @Permission('system_menu_edit')
  @LogRecordAction('修改菜单', 'update')
  async update(@Body() updateMenuDto: UpdateMenuDto) {
    const res = await this.menuService.update(updateMenuDto);
    if (res.affected) {
      this.cacheMenu();
      return DataResult.ok('操作成功');
    }
    return DataResult.fail('操作失败');
  }

  @Delete(':id')
  @Permission('system_menu_delete')
  @LogRecordAction('删除菜单', 'delete')
  async remove(@Param('id') id: string) {
    const res = await this.menuService.remove(+id);
    if (res.affected) {
      this.cacheMenu();
      return DataResult.ok('删除成功');
    }
    return DataResult.fail('删除失败');
  }

  @Get()
  async page(@Query() query: SearchMenuDto) {
    const result = await this.menuService.page(query);
    return DataResult.ok(result);
  }
}
