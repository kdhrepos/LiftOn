class CommentModel {
  final String id, content, author, userId, postId;

  CommentModel.fromDB(Map<String, dynamic> db)
      : id = db['id'],
        content = db['content'],
        author = db['author'],
        userId = db['userId'],
        postId = db['postId'];
}
