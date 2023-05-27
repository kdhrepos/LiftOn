const brcypt = require("bcryptjs");
const User = require("../models/users");

exports.loginProcess = async (req, res, next) => {
  const loginEmail = req.body.email;
  const loginPassword = req.body.password;

  // const errors = validationResult(req);

  await User.findOne({ where: { email: loginEmail } })
    .then((user) => {
      if (!user) {
        return res.json({ success: false, message: "Something Wrong!" });
      } else {
        brcypt
          .compare(loginPassword, user.password)
          .then((isMatched) => {
            if (isMatched) {
              // req.session.isLoggedIn = true;
              // req.session.userId = user.id;
              // req.session.userName = user.name;
              console.log("Login Successed!");
              console.log(user.dataValues);
              return res.json({ success: true, userData: user.dataValues });
            }
            return res.json({ success: false, message: "Something Wrong!" });
          })
          .catch((err) => {
            console.log(err);
          });
      }
    })
    .catch((err) => {
      console.log(err);
    });
};
exports.signUpProcess = async (req, res, next) => {
  const signUpName = req.body.name;
  const signUpEmail = req.body.email;
  const signUpPassword = req.body.password;

  await User.findOne({ where: { email: signUpEmail } })
    .then((user) => {
      if (user) {
        console.log("Sign Up Error");
        return res.json({ success: false, message: "Email Already Exists" }); // message could be more clean, not just a message.
      } else {
        brcypt
          .hash(signUpPassword, 12)
          .then((hashedPassword) => {
            User.create({
              name: signUpName,
              email: signUpEmail,
              password: hashedPassword,
            });
          })
          .then(() => {
            console.log("New User Signed Up!");
            res.json({ success: true }); // send the token in the response
          })
          .catch((err) => {
            console.log(err);
            res.json({ success: false, message: "Sign-up failed" }); // send a failure message in the response
          });
      }
    })
    .catch((err) => {
      console.log(err);
    });
};
exports.logoutProcess = (req, res, next) => {
  // req.session.destroy();
  // res.redirect("back");
};
