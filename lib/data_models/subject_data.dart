///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 11/1/21 at 8:46 PM
///

import 'dart:convert';

StudentSubjectData subjectDataFromJson(String str) =>
    StudentSubjectData.fromJson(json.decode(str));

String subjectDataToJson(StudentSubjectData data) => json.encode(data.toJson());

class StudentSubjectData {
  StudentSubjectData({
    this.id,
    this.status,
    this.institute,
    this.student,
    this.syllabus,
    this.subject,
    this.userCourseEnroll,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  int status;
  String institute;
  String student;
  String syllabus;
  SubjectDatum subject;
  String userCourseEnroll;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory StudentSubjectData.fromJson(Map<String, dynamic> json) =>
      StudentSubjectData(
        id: json["_id"] ?? '',
        status: json["status"] ?? 0,
        institute: json["institute"] ?? '',
        student: json["ems"] ?? '',
        syllabus: json["syllabus"] ?? '',
        subject: json["subject"] != null
            ? json["subject"] is String
                ? StudentSubjectData.fromJson({"_id": json["subject"]})
                : SubjectDatum.fromJson(json["subject"])
            : SubjectDatum(),
        userCourseEnroll: json["userCourseEnroll"] ?? '',
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "institute": institute,
        "ems": student,
        "syllabus": syllabus,
        "subject": subject != null ? subject.toJson() : null,
        "userCourseEnroll": userCourseEnroll,
        "createdAt": createdAt != null ? createdAt.toIso8601String() : null,
        "updatedAt": updatedAt != null ? updatedAt.toIso8601String() : null,
        "__v": v,
      };
}

SubjectDatum subjectDatumFromJson(String str) =>
    SubjectDatum.fromJson(json.decode(str));

String subjectDatumToJson(SubjectDatum data) => json.encode(data.toJson());

class SubjectDatum {
  SubjectDatum({
    this.id,
    this.status,
    this.name,
    this.shortName,
    this.createdBy,
    this.createdAt,
    this.avatar,
    this.updatedAt,
    this.v,
    this.updatedBy,
  });

  String id;
  int status;
  String name;
  String shortName;
  String avatar;
  String createdBy;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String updatedBy;

  factory SubjectDatum.fromJson(Map<String, dynamic> json) => SubjectDatum(
        id: json["_id"] ?? '',
        status: json["status"] ?? 1,
        name: json["name"] ?? '',
        shortName: json["shortName"] ?? '',
        avatar: json["avatar"] ?? '',
        createdBy: json["createdBy"] ?? '',
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        v: json["__v"] ?? 0,
        updatedBy: json["updatedBy"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "name": name,
        "shortName": shortName,
        "createdBy": createdBy,
        "avatar": avatar,
        "createdAt": createdAt != null ? createdAt.toIso8601String() : null,
        "updatedAt": updatedAt != null ? updatedAt.toIso8601String() : null,
        "__v": v,
        "updatedBy": updatedBy,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentSubjectData &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
