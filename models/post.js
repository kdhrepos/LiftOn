const Sequelize = require("sequelize");

const sequelize = require("../util/database");

const Post = sequelize.define("post", {
  id: {
    type: Sequelize.INTEGER,
    autoIncrement: true,
    allowNull: false,
    primaryKey: true,
  },
  title: { type: Sequelize.STRING, allowNull: false },
  content: { type: Sequelize.TEXT, allowNull: false },
  author: { type: Sequelize.STRING, allowNull: false },
  userId: { type: Sequelize.INTEGER, allowNull: false },
  file_path: { type: Sequelize.STRING, allowNull: true },
});

module.exports = Post;
