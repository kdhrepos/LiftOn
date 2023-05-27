const Sequelize = require("sequelize");

const sequelize = new Sequelize("lifton", "root", "qwe123", {
  dialect: "mysql",
  host: "localhost",
});

module.exports = sequelize;
