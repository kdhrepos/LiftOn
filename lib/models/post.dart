class PostModel {
  final String id, title, content, author, userId, createdAt;
  final String? filePath;

  void showInfo() {
    print("$id, $title, $content, $author, $filePath,  $userId, $createdAt");
  }

  PostModel.fromDB(Map<String, dynamic> db)
      : id = db['id'].toString(),
        title = db['title'],
        content = db['content'],
        author = db['author'],
        filePath = db['filePath'],
        userId = db['userId'].toString(),
        createdAt = db['createdAt'].toString();
}
