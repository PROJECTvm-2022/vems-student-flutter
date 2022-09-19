import 'package:vems/api_services/base_api.dart';
import 'package:vems/config/api_routes.dart';
import 'package:vems/data_models/institute_data.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 7/1/21 at 12:23 PM
///

Future<List<InstituteDatum>> getInstitutes({
  String instituteName = '',
  int skip = 0,
  int limit = 30,
}) async {
  Map<String, dynamic> query = {
    if (instituteName.isNotEmpty)
      'name': {'\$regex': '.*$instituteName.*', '\$options': 'i'},
    "\$skip": skip,
    "\$limit": limit,
  };

  final result = await ApiCall.get(ApiRoutes.institute, query: query);
  return List<InstituteDatum>.from(
      result.data['data'].map((x) => InstituteDatum.fromJson(x)));
}
