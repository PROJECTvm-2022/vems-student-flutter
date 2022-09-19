///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 4/2/21 at 1:40 PM
///

import 'dart:convert';

import 'package:vems/data_models/course_data.dart';
import 'package:vems/data_models/subject_data.dart';
import 'package:vems/data_models/user.dart';

TimeTableDatum timeTableDatumFromJson(String str) =>
    TimeTableDatum.fromJson(json.decode(str));

String timeTableDatumToJson(TimeTableDatum data) => json.encode(data.toJson());

class TimeTableDatum {
  TimeTableDatum({
    this.id,
    this.status,
    this.teacherSlot,
    this.teacher,
    this.syllabus,
    this.institute,
    this.instituteBatch,
    this.subject,
    this.course,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  int status;
  TeacherSlot teacherSlot;
  UserDatum teacher;
  String syllabus;
  String institute;
  String instituteBatch;
  SubjectDatum subject;
  String course;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory TimeTableDatum.fromJson(Map<String, dynamic> json) => TimeTableDatum(
        id: json["_id"] ?? '',
        status: json["status"] ?? 0,
        teacherSlot: json["teacherSlot"] != null
            ? json["teacherSlot"] is String
                ? TeacherSlot.fromJson({"_id": json["teacherSlot"]})
                : TeacherSlot.fromJson(json["teacherSlot"])
            : null,
        teacher: json["teacher"] != null
            ? json["teacher"] is String
                ? UserDatum.fromJson({"_id": json["teacher"]})
                : UserDatum.fromJson(json["teacher"])
            : null,
        syllabus: json["syllabus"] ?? '',
        institute: json["institute"] ?? '',
        instituteBatch: json["instituteBatch"] ?? '',
        subject: json["subject"] != null
            ? json["subject"] is String
                ? SubjectDatum.fromJson({"_id": json["subject"]})
                : SubjectDatum.fromJson(json["subject"])
            : null,
        course: json["course"] ?? '',
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
        "status": status,
        "teacherSlot": teacherSlot != null ? teacherSlot.toJson() : null,
        "teacher": teacher != null ? teacher.toJson() : null,
        "syllabus": syllabus,
        "institute": institute,
        "instituteBatch": instituteBatch,
        "subject": subject != null ? subject.toJson() : null,
        "course": course,
        "createdAt": createdAt != null ? createdAt.toIso8601String() : null,
        "updatedAt": updatedAt != null ? updatedAt.toIso8601String() : null,
        "__v": v,
      };
}

class TeacherSlot {
  TeacherSlot({
    this.id,
    this.subject,
    this.status,
    this.teacher,
    this.startTime,
    this.endTime,
    this.day,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.requestsCount,
    this.course,
    this.institutionsCount,
    this.syllabus,
  });

  String id;
  SubjectDatum subject;
  int status;
  String teacher;
  int startTime;
  int endTime;
  int day;
  String createdBy;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  int requestsCount;
  CourseDatum course;
  int institutionsCount;
  SyllabusDatum syllabus;

  factory TeacherSlot.fromJson(Map<String, dynamic> json) => TeacherSlot(
        id: json["_id"] ?? '',
        subject: json["subject"] != null
            ? json["subject"] is String
                ? SubjectDatum.fromJson({"_id": json["subject"]})
                : SubjectDatum.fromJson(json["subject"])
            : null,
        status: json["status"] ?? 0,
        teacher: json["teacher"] ?? '',
        startTime: json["startTime"] ?? 0,
        endTime: json["endTime"] ?? 0,
        day: json["day"] ?? 0,
        createdBy: json["createdBy"] ?? '',
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        v: json["__v"],
        requestsCount: json["requestsCount"] ?? 0,
        course: json["course"] != null
            ? json["course"] is String
                ? CourseDatum.fromJson({"_id": json["course"]})
                : CourseDatum.fromJson(json["course"])
            : null,
        institutionsCount: json["institutionsCount"] ?? 0,
        syllabus: json["syllabus"] != null
            ? json["syllabus"] is String
                ? SyllabusDatum.fromJson({"_id": json["syllabus"]})
                : SyllabusDatum.fromJson(json["syllabus"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "subject": subject == null ? null : subject.toJson(),
        "status": status,
        "teacher": teacher,
        "startTime": startTime,
        "endTime": endTime,
        "day": day,
        "createdBy": createdBy,
        "createdAt": createdAt != null ? createdAt.toIso8601String() : null,
        "updatedAt": updatedAt != null ? updatedAt.toIso8601String() : null,
        "__v": v,
        "requestsCount": requestsCount,
        "course": course == null ? null : course.toJson(),
        "institutionsCount": institutionsCount,
        "syllabus": syllabus == null ? null : syllabus.toJson(),
      };
}

class TimeDatum {
  TimeDatum({
    this.startingTime = 0,
    this.endingTime = 0,
  });

  int startingTime;
  int endingTime;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeDatum &&
          runtimeType == other.runtimeType &&
          startingTime == other.startingTime &&
          endingTime == other.endingTime;

  @override
  int get hashCode => startingTime.hashCode;
}

class CellDatum {
  CellDatum({
    this.localStart,
    this.localEnd,
    this.data,
    this.globalEnd,
    this.globalStart,
  });

  int localStart;
  int localEnd;
  int globalStart;
  int globalEnd;
  TimeTableDatum data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CellDatum && runtimeType == other.runtimeType;

  @override
  int get hashCode => localStart.hashCode;
}

SyllabusDatum syllabusDatumFromJson(String str) =>
    SyllabusDatum.fromJson(json.decode(str));

String syllabusDatumToJson(SyllabusDatum data) => json.encode(data.toJson());

class SyllabusDatum {
  SyllabusDatum({
    this.id,
    this.status,
    this.course,
    this.subject,
    this.name,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  int status;
  String course;
  String subject;
  String name;
  String createdBy;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory SyllabusDatum.fromJson(Map<String, dynamic> json) => SyllabusDatum(
        id: json["_id"] ?? '',
        status: json["status"] ?? 0,
        course: json["course"] ?? '',
        subject: json["subject"] ?? '',
        name: json["name"] ?? '',
        createdBy: json["createdBy"] ?? '',
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
        "status": status,
        "course": course,
        "subject": subject,
        "name": name,
        "createdBy": createdBy,
        "createdAt": createdAt != null ? createdAt.toIso8601String() : null,
        "updatedAt": updatedAt != null ? updatedAt.toIso8601String() : null,
        "__v": v,
      };
}
