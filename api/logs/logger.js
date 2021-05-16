var log4js = require('log4js');

log4js.configure({
  appenders: {
      newUsers: {type: 'file', filename: '../logs/users.log'},
      errors: {type: 'file', filename: '../logs/errors.log'},
      console: {type: 'console'}
  },
  categories: {
      userLogger: {appenders: ['newUsers'], level: 'info'},
      errorLogger: {appenders: ['errors'], level: 'error'},
      default: {appenders: ['console'], level: 'warn'}
  }
});
module.exports.log4js