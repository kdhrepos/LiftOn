const express = require("express");
const { check, body } = require("express-validator/check");

const router = express.Router();

const loginController = require("../controllers/login");
const isAuthed = require("../middleware/isAuthed");
const User = require("../models/users");

router.get("/logout", isAuthed, loginController.logoutProcess);

router.post(
  "/post-login",
  // body(
  //   "password",
  //   "Please enter a password with only numbers and at least 5 characters"
  // )
  //   .isLength({ min: 5 })
  //   .isAlphanumeric()
  //   .trim(),
  loginController.loginProcess
);

router.post(
  "/post-sign-up",
  // check("email")
  //   .isEmail()
  //   .withMessage("Please Enter a valid Email")
  //   .custom((value, { req }) => {
  //     return User.findOne({ email: value }).then((userData) => {
  //       if (userData.length > 0) {
  //         return Promise.reject("E-Mail Exists Already");
  //       }
  //     });
  //   }),
  // body(
  //   "password",
  //   "Please enter a password with only numbers and at least 5 characters"
  // )
  //   .isLength({ min: 5 })
  //   .isAlphanumeric()
  //   .trim(),
  loginController.signUpProcess
);

module.exports = router;
