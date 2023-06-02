class GoalModel {
  final String? filePath;
  final int id;
  final dynamic weight, bmi, fatMass, muscleMass;
  void showInfo() {
    print("$id $weight $fatMass");
  }

  GoalModel.fromDB(Map<String, dynamic> db)
      : id = db['id'],
        weight = db['weight'],
        fatMass = db['fatMass'],
        bmi = db['bmi'],
        muscleMass = db['muscleMass'],
        filePath = db['filePath'];
}
