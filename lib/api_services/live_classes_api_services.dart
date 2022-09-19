import 'package:vems/api_services/base_api.dart';
import 'package:vems/config/api_routes.dart';
import 'package:vems/data_models/live_chat_data.dart';
import 'package:vems/data_models/live_class_data.dart';
import 'package:vems/utils/shared_preference_helper.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 9/3/21 at 11:01 PM
///

Future<List<LiveClassDatum>> getLiveClasses({bool isScheduled = false}) async {
  Map<String, dynamic> query = {
    '\$sort': '{scheduledAt: -1}',
    "status": isScheduled
        ? 1
        : {
            "\$in": [1, 2]
          },
    "student": SharedPreferenceHelper.user.id,
  };

  print(query.toString());
  final result = await ApiCall.get(ApiRoutes.liveClass, query: query);
  print(result.data.toString());
  return List<LiveClassDatum>.from(
      result.data.map((x) => LiveClassDatum.fromJson(x)));
}

Future<List<LiveChatDatum>> getLiveClassChats(
    String liveClassId, int skip, int limit) async {
  final result = await ApiCall.get(ApiRoutes.chat, query: {
    'entityId': liveClassId,
    '\$populate': 'createdBy',
    '\$sort[createdAt]': -1,
    "type": 1,
    "\$skip": skip,
    "\$limit": limit,
  });
  return List<LiveChatDatum>.from(
      result.data['data'].map((x) => LiveChatDatum.fromJson(x)));
}

Future<LiveChatDatum> sendMessage(Map<String, dynamic> body) async {
  var resultMap = await ApiCall.post(ApiRoutes.chat, body: body, query: {
    r"$populate": "createdBy",
  });

  return LiveChatDatum.fromJson(resultMap.data);
}

Future<List<LiveChatDatum>> getQuiz(String liveClassId,
    {int skip, int limit}) async {
  final result = await ApiCall.get(ApiRoutes.chat, query: {
    'entityId': liveClassId,
    '\$sort[createdAt]': -1,
    "type": 2,
    "\$skip": skip,
    "\$limit": limit,
  });
  return List<LiveChatDatum>.from(
      result.data['data'].map((x) => LiveChatDatum.fromJson(x)));
}

Future<List<LiveChatDatum>> getQuizResults(String chatId, String answer,
    {int skip, int limit}) async {
  final result = await ApiCall.get(ApiRoutes.chat, query: {
    'entityId': chatId,
    '\$sort[createdAt]': 1,
    "type": 3,
    "\$limit": -1,
    "text": answer,
    "status": 1,
    "\$populate": "createdBy",
  });
  print("${result.data}");
  return List<LiveChatDatum>.from(
      result.data.map((x) => LiveChatDatum.fromJson(x)));
}
