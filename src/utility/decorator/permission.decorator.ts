import { SetMetadata } from '@nestjs/common';

export const PERMISSION = 'permission';
export const Permission = (code: string | string[]): MethodDecorator => {
  return SetMetadata(PERMISSION, [code]);
};
