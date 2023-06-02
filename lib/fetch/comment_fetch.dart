import 'package:lifton/global/util.dart';
import 'package:lifton/models/comment.dart';
import 'package:lifton/models/post.dart';

class CommentFetch {
  static Future<List<CommentModel>> getAllComments(int postId) async {
    try {
      final response = await dio.get(
        "$server/get-comment-process",
        data: {"postId": postId},
      );
      if (response.statusCode == 200) {
        List<CommentModel> commentList = <CommentModel>[];
        for (int i = 0; i < response.data.length; i++) {
          CommentModel comment = CommentModel.fromDB(response.data[i]);
          commentList.add(comment);
        }
        return (commentList);
      } else {
        print('API request failed with status code: ${response.statusCode}');
        throw Exception('Failed to fetch comments');
      }
    } catch (error) {
      print('API request failed: $error');
      throw Exception('Failed to fetch comments');
    }
  }

  static Future<List<Map<CommentModel, PostModel>>> getUserComments(
      int userId) async {
    try {
      final response = await dio.get(
        "$server/get-user-comment",
        data: {
          "userId": userId,
        },
      );
      if (response.statusCode == 200) {
        List<Map<CommentModel, PostModel>> commentList = [];

        for (var data in response.data) {
          CommentModel comment = CommentModel.fromDB(data['comment']);
          PostModel post = PostModel.fromDB(data['post']);
          Map<CommentModel, PostModel> map = {comment: post};

          commentList.add(map);
        }

        return commentList;
      } else {
        print('API request failed with status code: ${response.statusCode}');
        throw Exception('Failed to fetch comments');
      }
    } catch (error) {
      print('API request failed: $error');
      throw Exception('Failed to fetch comments');
    }
  }
}
