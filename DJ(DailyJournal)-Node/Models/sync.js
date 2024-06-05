const { sequelize } = require('./index.js');

const sync = () => {
  sequelize
    .sync({ force: false, alter: true })
    .then(() => console.log('데이터베이스 생성완료'))
    .catch((error) => {
      console.log(error);
    });
};

module.exports = sync;
