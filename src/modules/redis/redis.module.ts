import { Global, Module } from '@nestjs/common';
import { RedisService } from './redis.service';
import { RedisModule as NestRedisModule } from '@nestjs-modules/ioredis';
import { ConfigModule, ConfigService } from '@nestjs/config';

@Global()
@Module({
  imports: [
    NestRedisModule.forRootAsync({
      imports: [ConfigModule],
      inject: [ConfigService],
      useFactory: (configService: ConfigService) => {
        return {
          type: 'single',
          url: `redis://${configService.get('redis.host')}:${configService.get('redis.port')}`,
          options: {
            password: configService.get('redis.password')
          }
        };
      }
    })
  ],
  providers: [RedisService],
  exports: [RedisService]
})
export class RedisModule {}
