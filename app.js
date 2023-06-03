const express = require("express");
const app = express();

const bcrypt = require("bcryptjs");
const bodyParser = require("body-parser");
const sequelize = require("./util/database");
const path = require("path");
const multer = require("multer");

const port = 8080;

app.set("views", "views");

app.use(function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header(
    "Access-Control-Allow-Headers",
    "Origin, X-Requested-With, Content-Type, Accept"
  );
  next();
});

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

const fileStorage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "files");
  },
  filename: (req, file, cb) => {
    cb(null, `${Date.now() + file.originalname}`);
  },
});

app.use(multer({ storage: fileStorage }).single("file"));

const loginRoutes = require("./routes/login");
const postRoutes = require("./routes/post");
const commentRoutes = require("./routes/comment");
const goalRoutes = require("./routes/goal");
const planRoutes = require("./routes/plan");

// sequelize model
const User = require("./models/users");
const Post = require("./models/post");
const Comment = require("./models/comment");
const Goal = require("./models/goal");
const Plan = require("./models/plan");
// sequelize associations
User.hasMany(Post);
User.hasMany(Comment);
User.hasMany(Goal);
User.hasMany(Plan);
Post.belongsTo(User);
Post.hasMany(Comment);
Comment.belongsTo(Post);
Comment.belongsTo(User);
Goal.belongsTo(User);
Plan.belongsTo(User);

//routes
app.use(commentRoutes);
app.use(loginRoutes);
app.use(postRoutes);
app.use(goalRoutes);
app.use(planRoutes);
// Synchronize models with the database
sequelize
  // .sync()
  .sync({ alter: true })
  .then(() => {
    console.log("Database synchronized");
  })
  .catch((error) => {
    console.error("Error synchronizing database:", error);
  });

app.listen(port);
