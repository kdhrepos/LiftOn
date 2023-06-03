const Sequelize = require("sequelize");

const sequelize = require("../util/database");

const Plan = sequelize.define("plan", {
  id: {
    type: Sequelize.INTEGER,
    autoIncrement: true,
    allowNull: false,
    primaryKey: true,
  },
  userId: { type: Sequelize.INTEGER, allowNull: false },
  name: { type: Sequelize.STRING },
  set: { type: Sequelize.INTEGER },
  reps: { type: Sequelize.INTEGER },
  weight: { type: Sequelize.DOUBLE },
  isConducted: { type: Sequelize.BOOLEAN },
});
module.exports = Plan;
