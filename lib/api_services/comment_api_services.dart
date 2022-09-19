import 'package:vems/api_services/base_api.dart';
import 'package:vems/config/api_routes.dart';
import 'package:vems/data_models/comment_data.dart';
import 'package:vems/utils/shared_preference_helper.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 11/1/21 at 11:43 PM
///

/// Get all comments of a video
Future<List<CommentDatum>> getComments(
  String videoId, {
  int skip = 0,
  int limit = 40,
}) async {
  Map<String, dynamic> query = {
    "entityId": videoId,
    r"$populate": "createdBy",
    "\$skip": skip,
    "\$limit": limit,
    r'$sort[createdAt]': -1,
    "\$or[0][type]": 1,
    "\$or[1][type]": 2,
    "\$or[1][createdBy]": SharedPreferenceHelper.user.id,
  };

  final result = await ApiCall.get(ApiRoutes.comment, query: query);
  return List<CommentDatum>.from(
      result.data['data'].map((x) => CommentDatum.fromJson(x)));
}

/// Give a comment or reply
Future<CommentDatum> addComment(Map<String, dynamic> body) async {
  var resultMap = await ApiCall.post(ApiRoutes.comment, body: body, query: {
    r"$populate": "createdBy",
  });

  return CommentDatum.fromJson(resultMap.data);
}
