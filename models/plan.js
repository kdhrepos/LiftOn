const Sequelize = require("sequelize");

const sequelize = require("../util/database");

const Plan = sequelize.define("plan", {
  id: {
    type: Sequelize.INTEGER,
    autoIncrement: true,
    allowNull: false,
    primaryKey: true,
  },
  data: { type: Sequelize.JSON },
  userId: { type: Sequelize.INTEGER, allowNull: false },
});
module.exports = Plan;
