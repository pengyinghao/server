import { Injectable } from '@nestjs/common';
import { OnEvent } from '@nestjs/event-emitter';
import { RoleService } from '../role.service';
import { RedisService } from 'src/modules/redis/redis.service';
import { RedisCache } from 'src/utility/enums';

@Injectable()
export class CacheMenuListener {
  constructor(private roleService: RoleService, private redisService: RedisService) {}
  @OnEvent('reload.cache.menu')
  async handleReloadCacheMenuEvent() {
    // 获取以RedisCache.ROLE_MENU为前缀的所有键
    const menuKeys = await this.redisService.getKeysByPrefix(`${RedisCache.ROLE_MENU}*`);

    // 遍历所有键
    menuKeys.forEach((item) => {
      // 将键按照RedisCache.ROLE_MENU进行分割
      const arr = item.split(RedisCache.ROLE_MENU);
      // 根据分割后的值获取用户菜单
      this.roleService.getMenusForUser(arr[1] as unknown as number);
    });
  }
}
