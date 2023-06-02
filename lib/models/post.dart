class PostModel {
  final String title, content, author, createdAt;
  final String? filePath;
  final int id, userId;
  void showInfo() {
    print("$id, $title, $content, $author, $filePath,  $userId, $createdAt");
  }

  PostModel.fromDB(Map<String, dynamic> db)
      : id = db['id'],
        title = db['title'],
        content = db['content'],
        author = db['author'],
        filePath = db['file_path'],
        userId = db['userId'],
        createdAt = db['createdAt'].toString();
}
