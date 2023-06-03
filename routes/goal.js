const express = require("express");
const router = express.Router();
const goalController = require("../controllers/goal");

router.get("/get-user-goal", goalController.getUserGoal);
router.post("/post-goal", goalController.postGoal);

module.exports = router;
