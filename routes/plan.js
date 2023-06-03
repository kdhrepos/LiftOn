const express = require("express");
const router = express.Router();
const planController = require("../controllers/plan");

router.get("/get-plan", planController.getPlan);
router.post("/post-plan", planController.postPlan);
router.post("/check-plan", planController.checkPlan);

module.exports = router;
