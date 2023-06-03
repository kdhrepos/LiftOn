class PlanModel {
  int id, userId;
  String date;
  String name;
  dynamic set, reps, weight;
  bool isConducted;

  PlanModel.fromDB(Map<String, dynamic> db)
      : id = db['id'],
        userId = db['userId'],
        date = db['createdAt'].toString(),
        name = db['name'],
        set = db['set'],
        reps = db['reps'],
        weight = db['weight'],
        isConducted = db['isConducted'];
}
