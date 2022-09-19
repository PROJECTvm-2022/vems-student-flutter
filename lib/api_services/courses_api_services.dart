import 'package:vems/api_services/base_api.dart';
import 'package:vems/config/api_routes.dart';
import 'package:vems/data_models/course_data.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 7/1/21 at 2:11 PM
///

Future<List<CourseDatum>> getCourses({
  String courseName = '',
  String instituteId = '',
  int skip = 0,
  int limit = 30,
}) async {
  Map<String, dynamic> query = {
    if (courseName.isNotEmpty)
      'name': {'\$regex': '.*$courseName.*', '\$options': 'i'},
    if (instituteId.isNotEmpty) "institute": instituteId,
    "\$skip": skip,
    "\$limit": limit
  };

  final result = await ApiCall.get(ApiRoutes.instituteCourse, query: query);
  return List<CourseDatum>.from(
      result.data['data'].map((x) => CourseDatum.fromJson(x)));
}
