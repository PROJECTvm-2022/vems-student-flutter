///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 7/1/21 at 2:14 PM
///
import 'dart:convert';

import 'package:vems/data_models/institute_data.dart';

CourseDatum courseDatumFromJson(String str) =>
    CourseDatum.fromJson(json.decode(str));

String courseDatumToJson(CourseDatum data) => json.encode(data.toJson());

class CourseDatum {
  CourseDatum({
    this.id = '',
    this.institute,
    this.status,
    this.name,
    this.shortName,
    this.course,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.updatedBy,
  });

  String id;
  InstituteDatum institute;
  int status;
  String name;
  String shortName;
  String createdBy;
  String course;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String updatedBy;

  factory CourseDatum.fromJson(Map<String, dynamic> json) => CourseDatum(
        id: json["_id"] ?? '',
        institute: json["institute"] != null
            ? json["institute"] is String
                ? InstituteDatum.fromJson({"_id": json["institute"]})
                : InstituteDatum.fromJson(json["institute"])
            : null,
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
        updatedBy: json["updatedBy"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "institute": institute != null ? institute.toJson() : null,
        "status": status,
        "name": name,
        "shortName": shortName,
        "course": course,
        "createdBy": createdBy,
        "createdAt": createdAt != null ? createdAt.toIso8601String() : null,
        "updatedAt": updatedAt != null ? updatedAt.toIso8601String() : null,
        "__v": v,
        "updatedBy": updatedBy,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseDatum &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
