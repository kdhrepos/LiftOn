const Sequelize = require("sequelize");

const sequelize = new Sequelize("lifton", "root", "qwe123", {
  dialect: "mysql",
  host: "localhost",
  timezone: "Asia/Seoul",
  dialectOptions: {
    charset: "utf8mb4",
    dateStrings: true,
    typeCast: true,
  },
});

module.exports = sequelize;
