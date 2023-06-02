class PlanModel {
  int id, userId;
  DateTime date;
  String name;
  int set;
  int reps;
  double weight;

  PlanModel.fromDB(Map<String, dynamic> db)
      : id = db['id'],
        userId = db['userId'],
        date = DateTime.parse(db['createdAt']),
        name = db['name'],
        set = db['set'],
        reps = db['reps'],
        weight = db['weight'];
}
