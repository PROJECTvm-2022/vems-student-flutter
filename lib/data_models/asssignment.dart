///
/// Created by Auro (auro@smarttersstudio.com) on 07/07/21 at 8:22 pm
///

import 'dart:convert';

import 'package:vems/data_models/course_data.dart';
import 'package:vems/data_models/subject_data.dart';
import 'package:vems/data_models/user.dart';

StudentAssignment assignmentFromJson(String str) =>
    StudentAssignment.fromJson(json.decode(str));

String assignmentToJson(StudentAssignment data) => json.encode(data.toJson());

class StudentAssignment {
  StudentAssignment({
    this.id,
    this.status,
    this.student,
    this.assignment,
    this.answers,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.mark,
    this.submittedAt,
    this.verifiedAt,
  });

  String id;
  int status;
  UserDatum student;
  Assignment assignment;
  List<Answer> answers;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime submittedAt;
  DateTime verifiedAt;
  int v;
  int mark;

  factory StudentAssignment.fromJson(Map<String, dynamic> json) =>
      StudentAssignment(
        id: json["_id"] ?? '',
        status: json["status"] ?? 0,
        student: json["ems"] != null
            ? json["ems"] is String
                ? UserDatum.fromJson({"_id": json["ems"]})
                : UserDatum.fromJson(json["ems"])
            : null,
        assignment: json["assignment"] != null
            ? json["assignment"] is String
                ? Assignment.fromJson({"_id": json["assignment"]})
                : Assignment.fromJson(json["assignment"])
            : null,
        answers: json["answers"] == null
            ? []
            : List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"]).toLocal()
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        submittedAt: json["submittedAt"] != null
            ? DateTime.parse(json["submittedAt"]).toLocal()
            : null,
        verifiedAt: json["verifiedAt"] != null
            ? DateTime.parse(json["verifiedAt"]).toLocal()
            : null,
        v: json["__v"],
        mark: json["mark"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "ems": student.toJson(),
        "assignment": assignment.toJson(),
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "submittedAt": submittedAt?.toIso8601String(),
        "verifiedAt": verifiedAt?.toIso8601String(),
        "__v": v,
        "mark": mark,
      };
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentAssignment &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class Answer {
  Answer({
    this.type,
    this.id,
    this.link,
    this.reviewedLink,
  });

  String type;
  String id;
  String link;
  String reviewedLink;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        type: json["type"] ?? '',
        id: json["_id"] ?? '',
        link: json["link"] ?? '',
        reviewedLink: json["reviewedLink"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "_id": id,
        "link": link,
        "reviewedLink": reviewedLink == null ? null : reviewedLink,
      };
}

class Assignment {
  Assignment({
    this.id,
    this.instructions,
    this.status,
    this.entityType,
    this.entityId,
    this.instituteBatches,
    this.deadLine,
    this.createdBy,
    this.title,
    this.description,
    this.subject,
    this.course,
    this.syllabus,
    this.totalMark,
    this.questions,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  List<dynamic> instructions;
  int status;
  String entityType;
  String entityId;
  List<InstituteBatchElement> instituteBatches;
  DateTime deadLine;
  String createdBy;
  String title;
  String description;
  SubjectDatum subject;
  CourseDatum course;
  String syllabus;
  String totalMark;
  List<Answer> questions;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
        id: json["_id"],
        instructions: json["Instructions"] == null
            ? []
            : List<dynamic>.from(json["Instructions"].map((x) => x)),
        status: json["status"],
        entityType: json["entityType"],
        entityId: json["entityId"],
        instituteBatches: json["instituteBatches"] == null
            ? []
            : List<InstituteBatchElement>.from(json["instituteBatches"]
                .map((x) => InstituteBatchElement.fromJson(x))),
        deadLine: json["deadLine"] != null
            ? DateTime.parse(json["deadLine"]).toLocal()
            : null,
        createdBy: json["createdBy"],
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        subject: json["subject"] != null
            ? json["subject"] is String
                ? SubjectDatum.fromJson({"_id": json["subject"]})
                : SubjectDatum.fromJson(json["subject"])
            : null,
        course: json["course"] != null
            ? json["course"] is String
                ? CourseDatum.fromJson({"_id": json["course"]})
                : CourseDatum.fromJson(json["course"])
            : null,
        syllabus: json["syllabus"] ?? '',
        totalMark: json["totalMark"] ?? '',
        questions: json["questions"] == null
            ? []
            : List<Answer>.from(
                json["questions"].map((x) => Answer.fromJson(x))),
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "Instructions": List<dynamic>.from(instructions.map((x) => x)),
        "status": status,
        "entityType": entityType,
        "entityId": entityId,
        "instituteBatches":
            List<dynamic>.from(instituteBatches.map((x) => x.toJson())),
        "deadLine": deadLine.toIso8601String(),
        "createdBy": createdBy,
        "title": title,
        "description": description,
        "subject": subject?.toJson(),
        "course": course?.toJson(),
        "syllabus": syllabus,
        "totalMark": totalMark,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
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
        id: json["_id"],
        instituteBatch: json["instituteBatch"],
        institute: json["institute"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "instituteBatch": instituteBatch,
        "institute": institute,
      };
}

class AssignmentInstituteBatch {
  AssignmentInstituteBatch({
    this.instituteBatch,
    this.institute,
  });

  String instituteBatch;
  String institute;

  factory AssignmentInstituteBatch.fromJson(Map<String, dynamic> json) =>
      AssignmentInstituteBatch(
        instituteBatch: json["instituteBatch"],
        institute: json["institute"],
      );

  Map<String, dynamic> toJson() => {
        "instituteBatch": instituteBatch,
        "institute": institute,
      };
}
