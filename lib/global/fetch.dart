import 'package:lifton/global/state.dart';
import 'package:lifton/global/util.dart';
import 'package:lifton/models/comment.dart';
import 'package:lifton/models/goal.dart';
import 'package:lifton/models/plan.dart';
import 'package:lifton/models/post.dart';

class Fetcher {
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

  static Future<GoalModel?> getUserGoal(int userId) async {
    try {
      final response = await dio.get(
        "$server/get-user-goal",
        data: {
          "userId": userId,
        },
      );
      final data = response.data;
      if (response.statusCode == 200) {
        if (response.data == null) {
          return null;
        }
        GoalModel userGoal = GoalModel.fromDB(response.data);
        return userGoal;
      } else {
        print('API request failed with status code: ${response.statusCode}');
        throw Exception('Failed to fetch goal');
      }
    } catch (error) {
      print('API request failed: $error');
      throw Exception('Failed to fetch goal');
    }
  }

  static Future<List<PlanModel>> getPlans(DateTime selectedDay) async {
    try {
      final response = await dio.get("$server/get-plan", data: {
        "userId": currentUser.id,
        "date": selectedDay.toString(),
      });

      if (response.statusCode == 200) {
        List<PlanModel> planList = <PlanModel>[];

        for (int i = 0; i < response.data.length; i++) {
          PlanModel plan = PlanModel.fromDB(response.data[i]);
          planList.add(plan);
        }

        return planList;
      } else {
        print('API request failed with status code: ${response.statusCode}');
        throw Exception('Failed to fetch posts');
      }
    } catch (error) {
      print('API request failed: $error');
      throw Exception('Failed to fetch posts');
    }
  }

  static Future<List<PostModel>> getAllPosts() async {
    try {
      final response = await dio.get("$server/posts");

      if (response.statusCode == 200) {
        List<PostModel> postList = <PostModel>[];

        for (int i = 0; i < response.data.length; i++) {
          PostModel post = PostModel.fromDB(response.data[i]);
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

  static Future<List<PostModel>> getUserPosts() async {
    try {
      final response = await dio.get("$server/get-user-posts", data: {
        "userId": currentUser.id,
      });

      if (response.statusCode == 200) {
        List<PostModel> postList = <PostModel>[];

        for (int i = 0; i < response.data.length; i++) {
          PostModel post = PostModel.fromDB(response.data[i]);
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
