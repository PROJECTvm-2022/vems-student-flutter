///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 9/3/21 at 9:59 PM
///

import 'dart:convert';
import 'package:vems/data_models/course_data.dart';
import 'package:vems/data_models/schedule_cell_datum.dart';
import 'package:vems/data_models/subject_data.dart';
import 'package:vems/data_models/user.dart';

LiveClassDatum liveClassDatumFromJson(String str) =>
    LiveClassDatum.fromJson(json.decode(str));

String liveClassDatumToJson(LiveClassDatum data) => json.encode(data.toJson());

class LiveClassDatum {
  LiveClassDatum({
    this.id,
    this.meetingPassword,
    this.status,
    this.teacher,
    this.teacherSlot,
    this.scheduledAt,
    this.meetingId,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.subject,
    this.course,
    this.syllabus,
  });

  String id;
  String meetingPassword;
  int status;
  UserDatum teacher;
  TeacherSlot teacherSlot;
  DateTime scheduledAt;
  String meetingId;
  String createdBy;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  CourseDatum course;
  SubjectDatum subject;
  SyllabusDatum syllabus;

  factory LiveClassDatum.fromJson(Map<String, dynamic> json) => LiveClassDatum(
        id: json["_id"] ?? '',
        meetingPassword: json["meetingPassword"] ?? '',
        status: json["status"] ?? 0,
        teacher: json["teacher"] == null
            ? UserDatum()
            : UserDatum.fromJson(json["teacher"]),
        teacherSlot: json["teacherSlot"] == null
            ? TeacherSlot()
            : TeacherSlot.fromJson(json["teacherSlot"]),
        scheduledAt: json["scheduledAt"] != null
            ? DateTime.parse(json["scheduledAt"])
            : null,
        meetingId: json["meetingId"] ?? '',
        createdBy: json["createdBy"] ?? '',
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        v: json["__v"],
        course: json["course"] == null
            ? null
            : json["course"] is String
                ? CourseDatum(id: json["course"])
                : CourseDatum.fromJson(json["course"]),
        subject: json["subject"] == null
            ? null
            : json["subject"] is String
                ? SubjectDatum(id: json["subject"])
                : SubjectDatum.fromJson(json["subject"]),
        syllabus: json["syllabus"] == null
            ? null
            : json["syllabus"] is String
                ? SyllabusDatum(id: json["syllabus"])
                : SyllabusDatum.fromJson(json["syllabus"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "meetingPassword": meetingPassword,
        "status": status,
        "teacher": teacher == null ? null : teacher.toJson(),
        "teacherSlot": teacherSlot == null ? null : teacherSlot.toJson(),
        "scheduledAt":
            scheduledAt != null ? scheduledAt.toIso8601String() : null,
        "meetingId": meetingId,
        "createdBy": createdBy,
        "createdAt": createdAt != null ? createdAt.toIso8601String() : null,
        "updatedAt": updatedAt != null ? updatedAt.toIso8601String() : null,
        "course": course == null ? null : course.toJson(),
        "subject": subject == null ? null : subject.toJson(),
        "syllabus": syllabus == null ? null : syllabus.toJson(),
        "__v": v,
      };
}
