///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 8/1/21 at 4:14 PM
///

import 'dart:convert';

SpecializationDatum specializationDatumFromJson(String str) =>
    SpecializationDatum.fromJson(json.decode(str));

String specializationDatumToJson(SpecializationDatum data) =>
    json.encode(data.toJson());

class SpecializationDatum {
  SpecializationDatum({
    this.id,
    this.institute,
    this.status,
    this.name,
    this.shortName,
    this.course,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  String institute;
  int status;
  String name;
  String shortName;
  String course;
  String createdBy;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory SpecializationDatum.fromJson(Map<String, dynamic> json) =>
      SpecializationDatum(
        id: json["_id"] ?? '',
        institute: json["institute"] ?? '',
        status: json["status"] ?? 0,
        name: json["name"] ?? '',
        shortName: json["shortName"] ?? '',
        course: json["course"] ?? '',
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
        "institute": institute,
        "status": status,
        "name": name,
        "shortName": shortName,
        "course": course,
        "createdBy": createdBy,
        "createdAt": createdAt != null ? createdAt.toIso8601String() : null,
        "updatedAt": updatedAt != null ? updatedAt.toIso8601String() : null,
        "__v": v,
      };
}
