///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 11/1/21 at 8:50 PM
///

import 'dart:convert';

UnitDatum unitDatumFromJson(String str) => UnitDatum.fromJson(json.decode(str));

String unitDatumToJson(UnitDatum data) => json.encode(data.toJson());

class UnitDatum {
  UnitDatum({
    this.id,
    this.status,
    this.syllabus,
    this.name,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.order,
    this.chaptersCount,
    this.topicsCount,
  });

  String id;
  int status;
  String syllabus;
  String name;
  String createdBy;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  int order;
  int chaptersCount;
  int topicsCount;

  factory UnitDatum.fromJson(Map<String, dynamic> json) => UnitDatum(
        id: json["_id"] ?? '',
        status: json["status"] ?? 0,
        syllabus: json["syllabus"] ?? '',
        name: json["name"] ?? '',
        createdBy: json["createdBy"] ?? '',
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        v: json["__v"] ?? 0,
        order: json["order"] ?? 0,
        chaptersCount: json["chaptersCount"] ?? 0,
        topicsCount: json["topicsCount"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "syllabus": syllabus,
        "name": name,
        "createdBy": createdBy,
        "createdAt": createdAt != null ? createdAt.toIso8601String() : null,
        "updatedAt": updatedAt != null ? updatedAt.toIso8601String() : null,
        "__v": v,
        "order": order,
        "chaptersCount": chaptersCount,
        "topicsCount": topicsCount,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UnitDatum && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
