import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ConfigService } from '@nestjs/config';
import { join } from 'path';
import { NestExpressApplication } from '@nestjs/platform-express';
import { Logger } from '@nestjs/common';

async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule);
  const logger = new Logger(bootstrap.name);

  const config = app.get(ConfigService);

  app.setGlobalPrefix(config.get<string>('application.prefix'));

  const isDev = process.env.NODE_ENV === 'development';

  if (isDev) {
    app.enableCors(); // 允许跨域
  }

  app.useStaticAssets(join(__dirname, isDev ? '..' : '.', 'public'), { prefix: '/' });
  app.useStaticAssets(join(__dirname, isDev ? '..' : '.', 'uploads'), {
    prefix: '/uploads/'
  });

  const port = config.get<number>('application.port', 3000);

  await app.listen(port, '0.0.0.0', () => {
    logger.log(`server runing on http://localhost:${port}`);
  });
}
bootstrap();
