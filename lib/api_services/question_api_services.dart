import 'package:vems/api_services/base_api.dart';
import 'package:vems/config/api_routes.dart';
import 'package:vems/data_models/question_data.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 14/1/21 at 11:37 PM
///

/// Get all questions of a video
Future<List<QuestionDatum>> getVideoQuestions(String videoId) async {
  Map<String, dynamic> query = {
    "entityId": videoId,
  };

  final result = await ApiCall.get(ApiRoutes.question, query: query);

  return List<QuestionDatum>.from(
      result.data.map((x) => QuestionDatum.fromJson(x)));
}

/// Answer to a question
Future<StudentVideoAnswers> answerVideoQuestion(
    Map<String, dynamic> body) async {
  var resultMap = await ApiCall.post(ApiRoutes.answer, body: body);

  print(resultMap?.toString());

  return StudentVideoAnswers.fromJson(resultMap.data);
}
