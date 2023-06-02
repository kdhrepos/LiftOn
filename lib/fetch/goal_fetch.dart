import 'package:lifton/global/util.dart';
import 'package:lifton/models/goal.dart';

class GoalFetch {
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
}
