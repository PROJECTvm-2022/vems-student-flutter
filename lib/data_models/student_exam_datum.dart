///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 7/4/21 at 10:12 AM
///

import 'dart:convert';

import 'package:vems/data_models/exam_datum.dart';
import 'package:vems/data_models/user.dart';

StudentExamDatum studentExamDatumFromJson(String str) =>
    StudentExamDatum.fromJson(json.decode(str));

String studentExamDatumToJson(StudentExamDatum data) =>
    json.encode(data.toJson());

class StudentExamDatum {
  StudentExamDatum({
    this.id,
    this.status,
    // this.student,
    this.exam,
    this.answers,
    this.mark,
    this.grade,
    this.attendanceStatus,
    this.instituteBatch,
    this.createdAt,
    this.updatedAt,
    this.studentExamRoll,
    this.studentName,
  });

  String id;
  int status;
  ExamDatum exam;
  double mark;
  String grade;
  int attendanceStatus;
  List<ExamQuestionDatum> answers;
  StudentExamDatumInstituteBatch instituteBatch;
  DateTime createdAt;
  DateTime updatedAt;
  String studentName, studentExamRoll;

  factory StudentExamDatum.fromJson(Map<String, dynamic> json) =>
      StudentExamDatum(
        id: json["_id"] ?? '',
        status: json["status"] ?? 0,
        mark: (json["mark"] ?? 0).toDouble(),
        grade: json["grade"],
        studentName: json["studentName"] ?? "",
        studentExamRoll: json["studentExamRoll"] ?? "",
        attendanceStatus: json["attendanceStatus"] ?? 0,
        exam: json["exam"] == null
            ? null
            : json["exam"] is String
                ? ExamDatum.fromJson({"_id": json["exam"]})
                : ExamDatum.fromJson(json["exam"]),
        answers: json["answers"] == null
            ? []
            : List<ExamQuestionDatum>.from(
                json["answers"].map((x) => ExamQuestionDatum.fromJson(x))),
        instituteBatch: json["instituteBatch"] == null
            ? null
            : StudentExamDatumInstituteBatch.fromJson(json["instituteBatch"]),
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "mark": mark,
        "grade": grade,
        "attendanceStatus": attendanceStatus,
        "exam": exam == null ? null : exam.toJson(),
        "answers": answers == null
            ? []
            : List<ExamQuestionDatum>.from(answers.map((x) => x)),
        "instituteBatch": instituteBatch?.toJson(),
        "createdAt": createdAt != null ? createdAt.toIso8601String() : null,
        "updatedAt": updatedAt != null ? updatedAt.toIso8601String() : null,
      };
}

class InstituteBatchElement {
  InstituteBatchElement({
    this.id,
    this.instituteBatch,
    this.institute,
  });

  String id;
  String instituteBatch;
  String institute;

  factory InstituteBatchElement.fromJson(Map<String, dynamic> json) =>
      InstituteBatchElement(
        id: json["_id"] ?? '',
        instituteBatch: json["instituteBatch"] ?? '',
        institute: json["institute"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "instituteBatch": instituteBatch,
        "institute": institute,
      };
}

class StudentExamDatumInstituteBatch {
  StudentExamDatumInstituteBatch({
    this.instituteBatch,
    this.institute,
  });

  String instituteBatch;
  String institute;

  factory StudentExamDatumInstituteBatch.fromJson(Map<String, dynamic> json) =>
      StudentExamDatumInstituteBatch(
        instituteBatch: json["instituteBatch"] ?? '',
        institute: json["institute"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "instituteBatch": instituteBatch,
        "institute": institute,
      };
}
