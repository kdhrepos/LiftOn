const Sequelize = require("sequelize");

const sequelize = require("../util/database");

const User = sequelize.define("user", {
  id: {
    type: Sequelize.INTEGER,
    autoIncrement: true,
    allowNull: false,
    primaryKey: true,
  },
  name: {
    type: Sequelize.STRING,
    allowNull: false,
  },
  email: {
    type: Sequelize.STRING,
    allowNull: false,
  },
  password: {
    type: Sequelize.STRING,
    allowNull: false,
  },
  userType: {
    type: Sequelize.INTEGER,
    allowNULL: false,
  },
  gender: {
    type: Sequelize.INTEGER,
  },
  weight: { type: Sequelize.DOUBLE },
  bmi: { type: Sequelize.DOUBLE },
  fatMass: { type: Sequelize.DOUBLE },
  muscleMass: { type: Sequelize.DOUBLE },
});
module.exports = User;
