import 'package:vems/api_services/base_api.dart';
import 'package:vems/config/api_routes.dart';
import 'package:vems/data_models/faq_datum.dart';
import 'package:vems/utils/shared_preference_helper.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 22/4/21 at 9:09 PM
///

Future<List<FaqDatum>> getFAQs({
  int skip = 0,
  int limit = 10,
}) async {
  Map<String, dynamic> query = {
    "\$skip": skip,
    "\$limit": limit,
    "student": SharedPreferenceHelper.user.id,
  };

  final result = await ApiCall.get(ApiRoutes.faq, query: query);
  return List<FaqDatum>.from(
      result.data['data'].map((x) => FaqDatum.fromJson(x)));
}

Future<String> requestForContact(Map<String, dynamic> body) async {
  final result = await ApiCall.post(ApiRoutes.contactUs, body: body);
  return result.data['_id'] ?? '';
}
