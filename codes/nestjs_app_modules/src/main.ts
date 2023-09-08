import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import * as fs from 'fs';
import configurations from './config/configurations';
import { ValidationPipe } from '@nestjs/common';

async function bootstrap() {
  const certificates = configurations().certificates;
  const key = fs.readFileSync(certificates.keyPath);
  const cert = fs.readFileSync(certificates.certPath);

  const httpsOptions = { key, cert };

  const app = await NestFactory.create(AppModule, {
    httpsOptions,
  });

  /**
   * Adding validation pipe to validate requests
   * whitelist: passed only whitelisted parameters from request
   * forbidNonWhitelisted: forbidding non whitelisted params returning 4xx
   */
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      forbidNonWhitelisted: true,
    }),
  );

  await app.listen(3000);
}
bootstrap();
