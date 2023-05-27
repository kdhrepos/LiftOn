const express = require("express");
const app = express();
const session = require("express-session");
const csrf = require("csurf");
const flash = require("connect-flash");

const bodyParser = require("body-parser");
const multer = require("multer");
const sequelize = require("./util/database");
const path = require("path");

const port = 8080;

// const csrfProtection = csrf();
const imgStorage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "files");
  },
  filename: (req, file, cb) => {
    cb(null, `${Date.now()}_${file.originalname}`);
  },
});

const fileFilter = (req, file, cb) => {
  if (
    file.mimetype === "files/jpg" ||
    file.mimetype === "files/png" ||
    file.mimetype === "files/jpeg"
  ) {
    cb(null, true);
  } else {
    cb(null, false);
  }
};

app.set("views", "views");

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(
  multer({ storage: imgStorage, fileFilter: fileFilter }).single("postFile")
);
app.use(express.static(path.join(__dirname, "public")));
app.use("/files", express.static(path.join(__dirname, "files")));
app.use(
  session({
    secret: "my secret",
    resave: false,
    saveUninitialized: false,
  })
);
// app.use(csrfProtection);
app.use(flash());
// app.use((req, res, next) => {
//   res.locals.isAuthenticated = req.session.isLoggedIn;
//   res.locals.csrfToken = req.csrfToken();
//   next();
// });

app.use(function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header(
    "Access-Control-Allow-Headers",
    "Origin, X-Requested-With, Content-Type, Accept"
  );
  next();
});

app.use("/flutter", function (req, res, next) {
  console.log(req);
  next();
});
const errorController = require("./controllers/errorPage");
const loginRoutes = require("./routes/login");
const postRoutes = require("./routes/post");
const commentRoutes = require("./routes/comment");

// sequelize model
const User = require("./models/users");
const Post = require("./models/post");
const Comment = require("./models/comment");
const Goal = require("./models/goal");
// sequelize associations
User.hasMany(Post);
User.hasMany(Comment);
User.hasMany(Goal);
Post.belongsTo(User);
Post.hasMany(Comment);
Comment.belongsTo(Post);
Comment.belongsTo(User);
Goal.belongsTo(User);

// user login process
// if (sessionStorage.getItem("isLogined") == true) {
//   app.use(loginRoutes);
// }
//
// else {
// }
app.use(postRoutes);
app.use(commentRoutes);
app.use(loginRoutes);
app.use(errorController.get404);
// browsing all models we made sync knows every models and relationships
sequelize
  .sync()
  .then((result) => {})
  .catch();

app.listen(port);
