class GoalModel {
  final String id, weight, bmi, fatMass, muscleMass, filePath;

  GoalModel.fromDB(Map<String, dynamic> db)
      : id = db['id'],
        weight = db['weight'],
        fatMass = db['fatMass'],
        bmi = db['bmi'],
        muscleMass = db['muscleMass'],
        filePath = db['filePath'];
}
