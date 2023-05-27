class CommentModel {
  final String content, author, createdAt;
  final int id, userId, postId;
  void showInfo() {
    print("$id, $content, , $author,  $userId, $createdAt");
  }

  CommentModel.fromDB(Map<String, dynamic> db)
      : id = db['id'],
        content = db['content'],
        author = db['author'],
        userId = db['userId'],
        postId = db['postId'],
        createdAt = db['createdAt'];
}
