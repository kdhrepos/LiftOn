const Goal = require("../models/goal");

exports.getUserGoal = async (req, res, next) => {
  const userId = req.body.userId;

  const goal = await Goal.findOne({ where: { userId: userId } });

  if (goal == null) {
    return res.json({ success: false });
  } else {
    console.log("get-goal : Success!");
    console.log(goal.dataValues);
    return res.json(goal.dataValues);
  }
};
exports.postGoal = async (req, res, next) => {
  const userId = req.body.userId;
  const weight = req.body.weight;
  const bmi = req.body.bmi;
  const fatMass = req.body.fatMass;
  const muscleMass = req.body.muscleMass;

  // Check if a goal already exists for the user
  const existingGoal = await Goal.findOne({ where: { userId: userId } });

  if (existingGoal) {
    // Update the existing goal

    await existingGoal.set({
      weight: weight,
      bmi: bmi,
      fatMass: fatMass,
      muscleMass: muscleMass,
    });
    await existingGoal
      .save()
      .then(() => {
        res.json({ success: true });
      })
      .catch((error) => {
        console.error("Failed to update goal:", error);
        res
          .status(500)
          .json({ success: false, error: "Failed to update goal" });
      });
  } else {
    // Create a new goal
    await Goal.create({
      userId: userId,
      weight: weight,
      bmi: bmi,
      fatMass: fatMass,
      muscleMass: muscleMass,
    })
      .then(() => {
        res.json({ success: true });
      })
      .catch((error) => {
        console.error("Failed to create goal:", error);
        res
          .status(500)
          .json({ success: false, error: "Failed to create goal" });
      });
  }
};
