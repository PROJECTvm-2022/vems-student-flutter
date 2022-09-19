import 'package:vems/api_services/base_api.dart';
import 'package:vems/config/api_routes.dart';
import 'package:vems/data_models/asssignment.dart';
import 'package:vems/utils/shared_preference_helper.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 07/07/21 at 10:02 pm
///

Future<List<StudentAssignment>> getAssignments({List<int> status}) async {
  Map<String, dynamic> query = {
    if (status != null && status.isNotEmpty) "status[\$in]": status,
    "student": SharedPreferenceHelper.user.id,
    // "\$populate": ["assignment", "assignment.subject"],
    // "student": SharedPreferenceHelper.user.id,
    "\$sort": {
      "createdAt": -1,
    }
  };

  print("$query");
  final result = await ApiCall.get(ApiRoutes.studentAssignment, query: query);
  return List<StudentAssignment>.from(
      result.data.map((x) => StudentAssignment.fromJson(x)));
}

Future<StudentAssignment> getAssignmentDetails(String id) async {
  Map<String, dynamic> query = {
    "\$populate": ["assignment"],
    "student": SharedPreferenceHelper.user.id,
  };

  print("$query");
  final result =
      await ApiCall.get(ApiRoutes.studentAssignment, query: query, id: id);
  print("${result.data}");
  return StudentAssignment.fromJson(result.data);
}

Future<StudentAssignment> submitAssignment(
    String id, Map<String, dynamic> body) async {
  final result =
      await ApiCall.patch(ApiRoutes.studentAssignment, id: id, body: body);
  print("${result.data}");
  return StudentAssignment.fromJson(result.data);
}
