import 'package:lifton/global/util.dart';
import 'package:lifton/models/post.dart';

class Fetcher {
  static Future<List<PostModel>> getAllPosts() async {
    try {
      final response = await dio.get("$server/posts");

      if (response.statusCode == 200) {
        List<PostModel> postList = <PostModel>[];

        for (int i = 0; i < response.data.length; i++) {
          PostModel post = PostModel.fromDB(response.data[i]);
          post.showInfo();
          postList.add(post);
        }

        return postList;
      } else {
        print('API request failed with status code: ${response.statusCode}');
        throw Exception('Failed to fetch posts');
      }
    } catch (error) {
      print('API request failed: $error');
      throw Exception('Failed to fetch posts');
    }
  }
}
