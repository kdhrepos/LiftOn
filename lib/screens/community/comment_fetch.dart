import 'package:lifton/global/util.dart';
import 'package:lifton/models/comment.dart';

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
          comment.showInfo();
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
}
