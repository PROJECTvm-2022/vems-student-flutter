///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 11/1/21 at 9:01 PM
///

import 'dart:convert';

import 'package:vems/data_models/chapter_data.dart';
import 'package:vems/data_models/question_data.dart';
import 'package:vems/data_models/unit_data.dart';

StudentVideoDatum studentVideoDatumFromJson(String str) =>
    StudentVideoDatum.fromJson(json.decode(str));

String studentVideoDatumToJson(StudentVideoDatum data) =>
    json.encode(data.toJson());

class StudentVideoDatum {
  StudentVideoDatum({
    this.id,
    this.status,
    this.student,
    this.institute,
    this.instituteBatch,
    this.instituteBatchVideo,
    this.topic,
    this.chapter,
    this.unit,
    this.syllabus,
    this.video,
    this.thumbnail,
    this.answers,
    this.videoId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  int status;
  String student;
  String institute;
  String instituteBatch;
  InstituteBatchVideo instituteBatchVideo;
  dynamic topic;
  ChapterDatum chapter;
  UnitDatum unit;
  String syllabus;
  String video;
  String thumbnail;
  List<QuestionAnswerDatum> answers;
  VideoDatum videoId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory StudentVideoDatum.fromJson(Map<String, dynamic> json) =>
      StudentVideoDatum(
        id: json["_id"] ?? '',
        status: json["status"] ?? 0,
        student: json["ems"] ?? '',
        institute: json["institute"] ?? '',
        instituteBatch: json["instituteBatch"] ?? '',
        instituteBatchVideo: json["instituteBatchVideo"] != null
            ? json["instituteBatchVideo"] is String
                ? InstituteBatchVideo.fromJson(
                    {"_id": json["instituteBatchVideo"]})
                : InstituteBatchVideo.fromJson(json["instituteBatchVideo"])
            : null,
        topic: json["topic"],
        chapter: json["chapter"] != null
            ? json["chapter"] is String
                ? ChapterDatum.fromJson({"_id": json["chapter"]})
                : ChapterDatum.fromJson(json["chapter"])
            : null,
        unit: json["unit"] != null
            ? json["unit"] is String
                ? UnitDatum.fromJson({"_id": json["unit"]})
                : UnitDatum.fromJson(json["unit"])
            : null,
        syllabus: json["syllabus"] ?? '',
        video: json["video"] ?? '',
        thumbnail: json["thumbnail"] ?? '',
        answers: json["answers"] == null
            ? []
            : List<QuestionAnswerDatum>.from(
                json["answers"].map((x) => QuestionAnswerDatum.fromJson(x))),
        videoId: json["videoId"] != null
            ? json["videoId"] is String
                ? VideoDatum.fromJson({"_id": json["videoId"]})
                : VideoDatum.fromJson(json["videoId"])
            : null,
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
        "ems": student,
        "institute": institute,
        "instituteBatch": instituteBatch,
        "instituteBatchVideo":
            instituteBatchVideo != null ? instituteBatchVideo.toJson() : null,
        "topic": topic,
        "chapter": chapter != null ? chapter.toJson() : null,
        "unit": unit != null ? unit.toJson() : null,
        "syllabus": syllabus,
        "video": video,
        "thumbnail": thumbnail,
        "answers": List<dynamic>.from(answers.map((x) => x)),
        "videoId": videoId != null ? videoId.toJson() : null,
        "createdAt": createdAt != null ? createdAt.toIso8601String() : null,
        "updatedAt": updatedAt != null ? updatedAt.toIso8601String() : null,
        "__v": v,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentVideoDatum &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class InstituteBatchVideo {
  InstituteBatchVideo({
    this.id,
    this.publicCommentCount,
    this.privateCommentCount,
    this.status,
    this.order,
    this.createdBy,
    this.institute,
    this.instituteCourse,
    this.instituteBatch,
    this.topic,
    this.course,
    this.subject,
    this.syllabus,
    this.unit,
    this.chapter,
    this.video,
    this.thumbnail,
    this.videoId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.scheduledOn,
    this.updatedBy,
  });

  String id;
  int publicCommentCount;
  int privateCommentCount;
  int status;
  int order;
  String createdBy;
  String institute;
  String instituteCourse;
  String instituteBatch;
  dynamic topic;
  String course;
  String subject;
  String syllabus;
  String unit;
  String chapter;
  String video;
  String thumbnail;
  String videoId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  DateTime scheduledOn;
  String updatedBy;

  factory InstituteBatchVideo.fromJson(Map<String, dynamic> json) =>
      InstituteBatchVideo(
        id: json["_id"] ?? '',
        publicCommentCount: json["publicCommentCount"] ?? 0,
        privateCommentCount: json["privateCommentCount"] ?? 0,
        status: json["status"] ?? 0,
        order: json["order"] ?? 0,
        createdBy: json["createdBy"] ?? '',
        institute: json["institute"] ?? '',
        instituteCourse: json["instituteCourse"] ?? '',
        instituteBatch: json["instituteBatch"] ?? '',
        topic: json["topic"],
        course: json["course"] ?? '',
        subject: json["subject"] ?? '',
        syllabus: json["syllabus"] ?? '',
        unit: json["unit"] ?? '',
        chapter: json["chapter"] ?? '',
        video: json["video"] ?? '',
        thumbnail: json["thumbnail"] ?? '',
        videoId: json["videoId"] ?? '',
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        v: json["__v"],
        scheduledOn: DateTime.parse(json["scheduledOn"]),
        updatedBy: json["updatedBy"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "publicCommentCount": publicCommentCount,
        "privateCommentCount": privateCommentCount,
        "status": status,
        "order": order,
        "createdBy": createdBy,
        "institute": institute,
        "instituteCourse": instituteCourse,
        "instituteBatch": instituteBatch,
        "topic": topic,
        "course": course,
        "subject": subject,
        "syllabus": syllabus,
        "unit": unit,
        "chapter": chapter,
        "video": video,
        "thumbnail": thumbnail,
        "videoId": videoId,
        "createdAt": createdAt != null ? createdAt.toIso8601String() : null,
        "updatedAt": updatedAt != null ? updatedAt.toIso8601String() : null,
        "__v": v,
        "scheduledOn": scheduledOn.toIso8601String(),
        "updatedBy": updatedBy,
      };
}

class VideoDatum {
  VideoDatum({
    this.id,
    this.order,
    this.questionCount,
    this.commentCount,
    this.status,
    this.title,
    this.chapter,
    this.description,
    this.createdBy,
    this.course,
    this.subject,
    this.unit,
    this.syllabus,
    this.video,
    this.thumbnail,
    this.duration,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.secondsWatched = 0,
  });

  String id;
  int order;
  int questionCount;
  int commentCount;
  int status;
  String title;
  String chapter;
  String description;
  String createdBy;
  String course;
  String subject;
  String unit;
  String syllabus;
  String video;
  String thumbnail;
  int duration;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  int secondsWatched;

  factory VideoDatum.fromJson(Map<String, dynamic> json) => VideoDatum(
        id: json["_id"] ?? '',
        order: json["order"] ?? 0,
        questionCount: json["questionCount"] ?? 0,
        commentCount: json["commentCount"] ?? 0,
        status: json["status"] ?? 0,
        title: json["title"] ?? '',
        chapter: json["chapter"] ?? '',
        description: json["description"] ?? '',
        createdBy: json["createdBy"] ?? '',
        course: json["course"] ?? '',
        subject: json["subject"] ?? '',
        unit: json["unit"] ?? '',
        syllabus: json["syllabus"] ?? '',
        video: json["video"] ?? '',
        thumbnail: json["thumbnail"] ?? '',
        duration: json["duration"] == null ? 0 : json["duration"].toInt(),
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        v: json["__v"],
        secondsWatched: json["secondsWatched"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "order": order,
        "questionCount": questionCount,
        "commentCount": commentCount,
        "status": status,
        "title": title,
        "chapter": chapter,
        "description": description,
        "createdBy": createdBy,
        "course": course,
        "subject": subject,
        "unit": unit,
        "syllabus": syllabus,
        "video": video,
        "thumbnail": thumbnail,
        "duration": duration,
        "createdAt": createdAt != null ? createdAt.toIso8601String() : null,
        "updatedAt": updatedAt != null ? updatedAt.toIso8601String() : null,
        "__v": v,
        "secondsWatched": secondsWatched,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoDatum && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
