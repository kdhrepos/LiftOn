const Plan = require("../models/plan");

exports.getPlan = async (req, res, next) => {
  console.log(req.body);
  const userId = req.body.userId;
  const selectedDate = req.body.date.substring(0, 10);
  console.log(selectedDate);
  let planList = await Plan.findAll({
    where: {
      userId: userId,
    },
  }).catch((err) => {
    console.log(err);
    return json.status(500).json({ success: false });
  });
  planList = planList.filter((plan) => {
    return selectedDate === plan.dataValues.createdAt.substring(0, 10);
  });
  planList = planList.map((plan) => {
    return plan.dataValues;
  });
  console.log("Send Plan", planList);
  return res.status(200).json(planList);
};
exports.postPlan = async (req, res, next) => {
  console.log("Plan arrived", req.body);
  await Plan.create({
    userId: req.body.userId,
    name: req.body.name,
    set: req.body.set,
    reps: req.body.reps,
    weight: req.body.weight,
    isConducted: req.body.isConducted,
    createdAt: req.body.date,
  })
    .then(() => {
      return res.status(200).json({ success: true });
    })
    .catch((err) => {
      console.log(err);
      return res.status(500).json({ success: false });
    });
};
exports.checkPlan = async (req, res, next) => {
  console.log("Checker Arrived", req.body);
  const checkList = req.body.checkList;

  await checkList.map(async (id) => {
    const plan = await Plan.findByPk(id);
    await plan.set({ isConducted: true }).save();
  });
  return res.status(200).json({ success: true });
};
