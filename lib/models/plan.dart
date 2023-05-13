class PlanModel {
  final String id, title, content, author, filePath, userId, date;
  final List<String> exerciseList;

  PlanModel.fromDB(Map<String, dynamic> db)
      : id = db['id'],
        title = db['title'],
        content = db['content'],
        author = db['author'],
        filePath = db['filePath'],
        userId = db['userId'],
        date = db['date'],
        exerciseList = db['exerciseList'];
}
