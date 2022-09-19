///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 11/1/21 at 8:57 PM
///

import 'dart:convert';

ChapterDatum chapterDatumFromJson(String str) =>
    ChapterDatum.fromJson(json.decode(str));

String chapterDatumToJson(ChapterDatum data) => json.encode(data.toJson());

class ChapterDatum {
  ChapterDatum({
    this.id,
    this.status,
    this.name,
    this.unit,
    this.createdBy,
    this.syllabus,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.order,
    this.topicsCount,
    this.videosCount,
    this.avatar,
  });

  String id;
  int status;
  String name;
  String unit;
  String createdBy;
  String syllabus;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  int order;
  int topicsCount;
  int videosCount;
  String avatar;

  factory ChapterDatum.fromJson(Map<String, dynamic> json) => ChapterDatum(
        id: json["_id"] ?? '',
        status: json["status"] ?? 0,
        name: json["name"] ?? '',
        unit: json["unit"] ?? '',
        createdBy: json["createdBy"] ?? '',
        syllabus: json["syllabus"] ?? '',
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        v: json["__v"] ?? 0,
        order: json["order"] ?? 0,
        topicsCount: json["topicsCount"] ?? 0,
        videosCount: json["videosCount"] ?? 0,
        avatar: json["avatar"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "name": name,
        "unit": unit,
        "createdBy": createdBy,
        "syllabus": syllabus,
        "createdAt": createdAt != null ? createdAt.toIso8601String() : null,
        "updatedAt": updatedAt != null ? updatedAt.toIso8601String() : null,
        "__v": v,
        "order": order,
        "topicsCount": topicsCount,
        "avatar": avatar,
        "videosCount": videosCount,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChapterDatum &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
