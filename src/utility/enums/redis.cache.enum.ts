export enum RedisCache {
  /** 验证码 */
  CAPTCHA_CODE = 'captcha_code:',
  /** 系统参数管理 */
  SYS_PARAMS = 'sys_params:list',
  /** 用户登录 */
  USER_LOGIN = 'user_login:',
  /** 通过ip获取城市 */
  IP_TO_CITY = 'ip_to_city:',
  /** 存储socket 的唯一标识 */
  SOCKET_ROOM = 'socket_room:',
  /** 菜单缓存 */
  ROLE_MENU = 'role_menu:',
  /** 用户权限缓存 */
  ROLE_BUTTON_PERMISSION = 'role_permission:'
}
