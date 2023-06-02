class UserModel {
  final String name, email;
  final int id;
  final dynamic? weight, bmi, fatMass, muscleMass;
  final String? profilePath;
  final int isTrainer;
  final int gender;
  void showInfo() {
    print("$id, $name, $email $weight $bmi $fatMass $muscleMass");
  }

  UserModel.fromDB(Map<String, dynamic> db)
      : id = db['id'],
        email = db['email'],
        name = db['name'],
        weight = db['weight'],
        bmi = db['bmi'],
        fatMass = db['fatMass'],
        muscleMass = db['muscleMass'],
        isTrainer = db['userType'],
        gender = db['gender'],
        profilePath = db['profilePath'];
}
