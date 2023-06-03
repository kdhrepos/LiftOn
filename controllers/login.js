const bcrypt = require("bcryptjs");
const User = require("../models/users");

exports.loginProcess = async (req, res, next) => {
  const loginEmail = req.body.email;
  const loginPassword = req.body.password;

  await User.findOne({ where: { email: loginEmail } })
    .then((user) => {
      if (!user) {
        return res.json({ success: false, message: "Something Wrong!" });
      } else {
        bcrypt
          .compare(loginPassword, user.password)
          .then((isMatched) => {
            if (isMatched) {
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
  const weight = req.body.weight;
  const bmi = req.body.bmi;
  const muscleMass = req.body.muscleMass;
  const fatMass = req.body.fatMass;
  const isTrainer = req.body.isTrainer;
  const gender = req.body.gender;

  await User.findOne({ where: { email: signUpEmail } })
    .then(async (user) => {
      if (user) {
        console.log("Sign Up Error");
        return res.json({ success: false, message: "Email Already Exists" });
      } else {
        const existingUser = await User.findOne({
          where: { name: signUpName },
        });
        if (existingUser) {
          return res.json({ success: false, message: "Pick another name" });
        }

        try {
          const hashedPassword = await bcrypt.hash(signUpPassword, 12);
          const user = await User.create({
            name: signUpName,
            email: signUpEmail,
            password: hashedPassword,
            weight: weight,
            bmi: bmi,
            muscleMass: muscleMass,
            fatMass: fatMass,
            userType: isTrainer,
            gender: gender,
          });
          console.log("New User Signed Up!", user);
          return res.json({
            success: true,
            message: "Welcome",
            userData: user.dataValues,
          }); // send the token in the response
        } catch (err) {
          console.log(err);
          return res.json({ success: false, message: "Sign-up failed" }); // send a failure message in the response
        }
      }
    })
    .catch((err) => {
      console.log(err);
      return res.json({ success: false, message: "An error occurred" });
    });
};
exports.changePWProcess = async (req, res, next) => {
  console.log("Change PW", req.body);
  const userId = req.body.userId;
  const changedPW = req.body.password;

  try {
    const user = await User.findByPk(userId);

    if (!user) {
      return res.json({ success: false });
    }

    const hashedPW = await bcrypt.hash(changedPW, 12);

    user.password = hashedPW;
    await user.save();

    res.json({ success: true });
  } catch (error) {
    console.error("Error changing password:", error);
    return res.json({ success: false });
  }
};
exports.leaveProcess = async (req, res, next) => {
  console.log(req.body);
  const email = req.body.email;
  const password = req.body.password;
  const userId = req.body.userId;
  await User.findByPk(userId)
    .then((user) => {
      if (user.email != email)
        return res.json({ success: false, message: "Wrong Email" });
      if (!user) {
        return res.json({ success: false, message: "Failed" });
      } else {
        bcrypt
          .compare(password, user.password)
          .then((isMatched) => {
            if (isMatched) {
              console.log("Leave Successful");
              console.log(user.dataValues);
              return res.json({ success: true, message: "Bye Bye" });
            }
            return res.json({ success: false, message: "Wrong Password" });
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
