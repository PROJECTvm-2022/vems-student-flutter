///
/// Created by Auro (auro@smarttersstudio.com) on 05/07/21 at 12:29 pm
///

import 'dart:convert';

import 'package:vems/data_models/chapter_data.dart';
import 'package:vems/data_models/subject_data.dart';
import 'package:vems/data_models/unit_data.dart';

MaterialDatum materialFromJson(String str) =>
    MaterialDatum.fromJson(json.decode(str));

String materialToJson(MaterialDatum data) => json.encode(data.toJson());

class MaterialDatum {
  MaterialDatum({
    this.id,
    this.status,
    this.title,
    this.description,
    this.chapter,
    this.type,
    this.createdBy,
    this.course,
    this.subject,
    this.unit,
    this.syllabus,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.attachment,
    this.duration,
    this.thumbnail,
    this.updatedBy,
    this.path,
    this.thumbnailPath,
  });

  String id;
  int status;
  String title;
  String description;
  ChapterDatum chapter;
  int type;
  String createdBy;
  String course;
  SubjectDatum subject;
  UnitDatum unit;
  String syllabus;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String attachment;
  int duration;
  String thumbnail;
  String updatedBy;
  String path;
  String thumbnailPath;

  factory MaterialDatum.fromJson(Map<String, dynamic> json) => MaterialDatum(
        id: json["_id"] ?? '',
        status: json["status"] ?? 0,
        title: json["title"] ?? '',
        description: json["description"],
        chapter: json["chapter"] != null
            ? json["chapter"] is String
                ? ChapterDatum.fromJson({"_id": json["chapter"]})
                : ChapterDatum.fromJson(json["chapter"])
            : null,
        type: json["type"] ?? 0,
        createdBy: json["createdBy"],
        course: json["course"],
        subject: json["subject"] != null && json["subject"] is! String
            ? SubjectDatum.fromJson(json["subject"])
            : null,
        unit: json["unit"] != null
            ? json["unit"] is String
                ? UnitDatum.fromJson({"_id": json["unit"]})
                : UnitDatum.fromJson(json["unit"])
            : null,
        syllabus: json["syllabus"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        v: json["__v"],
        attachment: json["attachment"] ?? '',
        duration: json["duration"] ?? 0,
        thumbnail: json["thumbnail"] ?? '',
        updatedBy: json["updatedBy"] ?? '',
        path: json["path"] ?? '',
        thumbnailPath: json["thumbnailPath"] ?? '',
      );
  factory MaterialDatum.fromSqlJson(Map<String, dynamic> json) => MaterialDatum(
        id: json["_id"] ?? '',
        status: json["status"] ?? 0,
        title: json["title"] ?? '',
        description: json["description"],
        chapter: json["chapter"] != null
            ? ChapterDatum.fromJson({
                "_id": jsonDecode(json["chapter"])['id'],
                'name': jsonDecode(json["chapter"])['name']
              })
            : null,
        type: json["type"] ?? 0,
        createdBy: json["createdBy"],
        course: json["course"],
        subject: json["subject"] != null
            ? SubjectDatum.fromJson({
                "_id": jsonDecode(json["subject"])['id'],
                'name': jsonDecode(json["subject"])['name']
              })
            : null,
        unit: json["unit"] != null
            ? UnitDatum.fromJson({
                "_id": jsonDecode(json["unit"])['id'],
                'name': jsonDecode(json["unit"])['name']
              })
            : null,
        syllabus: json["syllabus"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        v: json["__v"],
        attachment: json["attachment"] ?? '',
        duration: json["duration"] ?? 0,
        thumbnail: json["thumbnail"] ?? '',
        updatedBy: json["updatedBy"] ?? '',
        path: json["path"] ?? '',
        thumbnailPath: json["thumbnailPath"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "title": title,
        "description": description,
        "chapter": chapter,
        "type": type,
        "createdBy": createdBy,
        "course": course,
        "subject": subject?.toJson(),
        "unit": unit,
        "syllabus": syllabus,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "attachment": attachment,
        "duration": duration,
        "thumbnail": thumbnail,
        "updatedBy": updatedBy,
        "thumbnailPath": thumbnailPath,
        "path": path,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MaterialDatum &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
