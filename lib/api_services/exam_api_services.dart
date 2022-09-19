import 'dart:developer';

import 'package:vems/api_services/base_api.dart';
import 'package:vems/config/api_routes.dart';
import 'package:vems/data_models/student_exam_datum.dart';
import 'package:vems/utils/shared_preference_helper.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 7/4/21 at 10:42 AM
///

Future<List<StudentExamDatum>> getExams({
  int skip = 0,
  int limit = 40,
}) async {
  Map<String, dynamic> query = {
    "\$skip": skip,
    "\$limit": limit,
    "\$populate": "exam",
    "status": {
      "\$in": [2, 3]
    },
    "\$sort": {"status": -1, "createdAt": -1, "scheduledOn": -1, "endedAt": -1},
  };
  final result = await ApiCall.get(ApiRoutes.exams, query: query);
  return List<StudentExamDatum>.from(
      result.data['data'].map((x) => StudentExamDatum.fromJson(x)));
}

Future<List<StudentExamDatum>> getUpcomingExams({
  int skip = 0,
  int limit = 5,
}) async {
  Map<String, dynamic> query = {
    "\$skip": skip,
    "\$limit": limit,
    "\$populate": "exam",
    "status": 2,
    "\$sort": {
      "status": -1,
      "createdAt": -1,
    },
    "student": SharedPreferenceHelper.user.id,
  };

  final result = await ApiCall.get(ApiRoutes.exams, query: query);
  return List<StudentExamDatum>.from(
      result.data['data'].map((x) => StudentExamDatum.fromJson(x)));
}

Future<StudentExamDatum> getExamDetails(String examId) async {
  Map<String, dynamic> query = {
    "\$populate": ["exam", "answers.question", "exam.course", "exam.subject"],
    "student": SharedPreferenceHelper.user.id,
  };

  final result = await ApiCall.get(ApiRoutes.exams, query: query, id: examId);
  log("exam details : ${result.data}");
  final data = StudentExamDatum.fromJson(result.data);
  data.answers.shuffle();
  return data;
}

Future<bool> answerQuestion(
    {String examId, String questionId, String answer}) async {
  Map<String, dynamic> body = {
    "question": questionId,
    "answer": answer,
  };

  final result =
      await ApiCall.patch(ApiRoutes.examAnswer, id: examId, body: body);
  return result.data['result'];
}

Future<StudentExamDatum> joinExam(String id) async {
  final result = await ApiCall.patch(ApiRoutes.exams,
      id: id, body: {"attendanceStatus": 2});
  return StudentExamDatum.fromJson(result.data);
}
