///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 6/4/21 at 5:50 PM
///

import 'dart:convert';

import 'package:vems/data_models/course_data.dart';
import 'package:vems/data_models/question_data.dart';
import 'package:vems/data_models/subject_data.dart';

ExamDatum questionDatumFromJson(String str) =>
    ExamDatum.fromJson(json.decode(str));

String questionDatumToJson(ExamDatum data) => json.encode(data.toJson());

class ExamDatum {
  ExamDatum({
    this.id,
    this.mark,
    this.status,
    this.questionCount,
    this.title,
    this.description,
    this.scheduledOn,
    this.syllabus,
    this.createdBy,
    // this.subject,
    // this.course,
    this.instituteBatches,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.duration,
    this.instructions,
  });

  String id;
  MarkDatum mark;
  int status;
  int questionCount;
  String title;
  String description;
  DateTime scheduledOn;
  String syllabus;
  String createdBy;
  // SubjectDatum subject;
  // CourseDatum course;
  List<dynamic> instituteBatches;
  List<String> instructions;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  int duration;

  factory ExamDatum.fromJson(Map<String, dynamic> json) => ExamDatum(
        id: json["_id"] ?? '',
        mark: json["mark"] == null ? null : MarkDatum.fromJson(json["mark"]),
        status: json["status"] ?? 0,
        questionCount: json["questionCount"] ?? 0,
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        scheduledOn: json["scheduledOn"] != null
            ? DateTime.parse(json["scheduledOn"]).toLocal()
            : null,
        syllabus: json["syllabus"] ?? '',
        createdBy: json["createdBy"] ?? '',
        // subject: json["subject"] == null
        //     ? null
        //     : json["subject"] is String
        //         ? SubjectDatum.fromJson({"_id": json["subject"]})
        //         : SubjectDatum.fromJson(json["subject"]),
        // course: json["course"] == null
        //     ? null
        //     : json["course"] is String
        //         ? CourseDatum(id: json["course"])
        //         : CourseDatum.fromJson(json["course"]),
        instructions: json["instructions"] != null
            ? List<String>.from(json["instructions"].map((x) => x))
            : [],
        instituteBatches: json["instituteBatches"] == null
            ? []
            : List<dynamic>.from(json["instituteBatches"].map((x) => x)),
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        v: json["__v"],
        duration: json["duration"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "mark": mark.toJson(),
        "status": status,
        "questionCount": questionCount,
        "title": title,
        "description": description,
        "instructions": List<dynamic>.from(instructions.map((x) => x)),
        "scheduledOn":
            scheduledOn == null ? null : scheduledOn.toIso8601String(),
        "syllabus": syllabus,
        "createdBy": createdBy,
        // "subject": subject == null ? null : subject.toJson(),
        // "course": course == null ? null : course.toJson(),
        "instituteBatches": List<dynamic>.from(instituteBatches.map((x) => x)),
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v,
        "duration": duration,
      };
}

class MarkDatum {
  MarkDatum({
    this.grades,
    this.total,
    this.passingMark,
  });

  double total;
  double passingMark;
  List<GradeDatum> grades;

  factory MarkDatum.fromJson(Map<String, dynamic> json) => MarkDatum(
        total: (json["total"] ?? 0).toDouble(),
        passingMark: (json["passingMark"] ?? 0).toDouble(),
        grades: json["grades"] == null
            ? []
            : List<GradeDatum>.from(
                json["grades"].map((x) => GradeDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "passingMark": passingMark,
        "grades": List<dynamic>.from(grades.map((x) => x.toJson())),
      };
}

class GradeDatum {
  GradeDatum({
    this.id,
    this.name,
    this.mark,
  });

  String id;
  String name;
  double mark;

  factory GradeDatum.fromJson(Map<String, dynamic> json) => GradeDatum(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        mark: (json["mark"] ?? 0).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "mark": mark,
      };
}

ExamQuestionDatum examQuestionDatumFromJson(String str) =>
    ExamQuestionDatum.fromJson(json.decode(str));

String examQuestionDatumToJson(ExamQuestionDatum data) =>
    json.encode(data.toJson());

class ExamQuestionDatum {
  ExamQuestionDatum({
    this.id,
    this.question,
    this.answer,
  });

  String id;
  QuestionDatum question;
  String answer;

  factory ExamQuestionDatum.fromJson(Map<String, dynamic> json) =>
      ExamQuestionDatum(
        id: json["_id"] ?? '',
        answer: json["answer"] ?? '',
        question: json["question"] == null
            ? null
            : json["question"] is String
                ? QuestionDatum(id: json["question"])
                : QuestionDatum.fromJson(json["question"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "answer": answer,
        "question": question == null ? null : question.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExamQuestionDatum &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
