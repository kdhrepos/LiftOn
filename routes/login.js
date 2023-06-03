const express = require("express");
const router = express.Router();
const loginController = require("../controllers/login");

router.post("/post-login", loginController.loginProcess);
router.post("/post-sign-up", loginController.signUpProcess);
router.post("/put-password", loginController.changePWProcess);
router.post("/leave", loginController.leaveProcess);

module.exports = router;
