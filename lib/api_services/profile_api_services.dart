import 'package:vems/api_services/base_api.dart';
import 'package:vems/config/api_routes.dart';
import 'package:vems/data_models/profile_stats_datum.dart';
import 'package:vems/data_models/user.dart';
import 'package:vems/utils/shared_preference_helper.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 8/1/21 at 6:49 PM
///

Future<UserDatum> getMyProfile() async {
  final response = await ApiCall.get(ApiRoutes.user,
      id: SharedPreferenceHelper.user.id, query: {"\$populate": "institute"});
  print(response.data.toString());
  return UserDatum.fromJson(response.data);
}

Future<ProfileStatsDatum> getProfileStats() async {
  final response = await ApiCall.get(ApiRoutes.studentProfile, query: {
    "student": SharedPreferenceHelper.user.id,
  });
  return ProfileStatsDatum.fromJson(response.data);
}
