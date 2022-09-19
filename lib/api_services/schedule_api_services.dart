import 'package:vems/api_services/base_api.dart';
import 'package:vems/config/api_routes.dart';
import 'package:vems/data_models/schedule_cell_datum.dart';
import 'package:vems/utils/shared_preference_helper.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 4/2/21 at 5:00 PM
///

/// Get all schedule cell of a video
Future<List<TimeTableDatum>> getSchedule() async {
  Map<String, dynamic> query = {
    "\$populate": ["teacher", "subject", "teacherSlot"],
    "student": SharedPreferenceHelper.user.id,
    "\$sort[day]": 1,
    "\$sort[startTime]": 1,
    "status": 2,
  };

  final result = await ApiCall.get(ApiRoutes.timeTable, query: query);

  return List<TimeTableDatum>.from(
      result.data.map((x) => TimeTableDatum.fromJson(x)));
}
