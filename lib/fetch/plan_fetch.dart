import 'package:lifton/global/state.dart';
import 'package:lifton/global/util.dart';
import 'package:lifton/models/plan.dart';

class PlanFetch {
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
}
