const Sequelize = require("sequelize");

const sequelize = require("../util/database");

const Goal = sequelize.define("goal", {
  id: {
    type: Sequelize.INTEGER,
    autoIncrement: true,
    allowNull: false,
    primaryKey: true,
  },
  weight: { type: Sequelize.DOUBLE },
  bmi: { type: Sequelize.DOUBLE },
  fatMass: { type: Sequelize.DOUBLE },
  muscleMass: { type: Sequelize.DOUBLE },
  userId: { type: Sequelize.INTEGER, allowNull: false },
});
module.exports = Goal;
