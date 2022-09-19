import 'package:vems/api_services/base_api.dart';
import 'package:vems/config/api_routes.dart';
import 'package:vems/data_models/specialization_data.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 8/1/21 at 4:17 PM
///

Future<List<SpecializationDatum>> getSpecializations({
  String specializationName = '',
  String instituteId = '',
  String courseId = '',
  int skip = 0,
  int limit = 30,
}) async {
  Map<String, dynamic> query = {
    if (specializationName.isNotEmpty)
      'name': {'\$regex': '.*$specializationName.*', '\$options': 'i'},
    if (courseId.isNotEmpty) "course": courseId,
    "\$skip": skip,
    "\$limit": limit
  };
  final result = await ApiCall.get(ApiRoutes.specialization, query: query);
  return List<SpecializationDatum>.from(
      result.data['data'].map((x) => SpecializationDatum.fromJson(x)));
}
