const Sequelize = require("sequelize");

const sequelize = require("../util/database");

const Goal = sequelize.define("goal", {
  id: {
    type: Sequelize.INTEGER,
    autoIncrement: true,
    allowNull: false,
    primaryKey: true,
  },
  data: { type: Sequelize.JSON },
  userId: { type: Sequelize.INTEGER, allowNull: false },
});
module.exports = Goal;
