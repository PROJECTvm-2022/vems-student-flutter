///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 27/2/21 at 3:33 PM
///

import 'dart:convert';

import 'package:vems/data_models/course_data.dart';
import 'package:vems/data_models/institute_data.dart';

StudentSeatDatum studentSeatDatumFromJson(String str) =>
    StudentSeatDatum.fromJson(json.decode(str));

String studentSeatDatumToJson(StudentSeatDatum data) =>
    json.encode(data.toJson());

class StudentSeatDatum {
  StudentSeatDatum({
    this.id,
    this.status,
    this.instituteBatch,
    this.type,
    this.student,
    this.institute,
    this.instituteCourse,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.acceptedOrRejectedBy,
    this.acceptedOrRejectedOn,
  });

  String id;
  int status;
  InstituteBatch instituteBatch;
  int type;
  String student;
  InstituteDatum institute;
  CourseDatum instituteCourse;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String acceptedOrRejectedBy;
  DateTime acceptedOrRejectedOn;

  factory StudentSeatDatum.fromJson(Map<String, dynamic> json) =>
      StudentSeatDatum(
        id: json["_id"] ?? '',
        status: json["status"] ?? 0,
        instituteBatch: json["instituteBatch"] == null
            ? null
            : json["instituteBatch"] is String
                ? InstituteBatch(id: json["instituteBatch"])
                : InstituteBatch.fromJson(json["instituteBatch"]),
        type: json["type"] ?? 0,
        student: json["ems"] ?? '',
        institute: json["institute"] != null
            ? json["institute"] is String
                ? InstituteDatum.fromJson({"_id": json["institute"]})
                : InstituteDatum.fromJson(json["institute"])
            : null,
        instituteCourse: json["instituteCourse"] == null
            ? null
            : json["instituteCourse"] is String
                ? CourseDatum(id: json["instituteCourse"])
                : CourseDatum.fromJson(json["instituteCourse"]),
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        v: json["__v"],
        acceptedOrRejectedBy: json["acceptedOrRejectedBy"] ?? '',
        acceptedOrRejectedOn: json["acceptedOrRejectedOn"] != null
            ? DateTime.parse(json["acceptedOrRejectedOn"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "instituteBatch":
            instituteBatch != null ? instituteBatch.toJson() : null,
        "type": type,
        "ems": student,
        "institute": institute != null ? institute.toJson() : null,
        "instituteCourse":
            instituteCourse == null ? null : instituteCourse.toJson(),
        "createdAt": createdAt != null ? createdAt.toIso8601String() : null,
        "updatedAt": updatedAt != null ? updatedAt.toIso8601String() : null,
        "__v": v,
        "acceptedOrRejectedBy": acceptedOrRejectedBy,
        "acceptedOrRejectedOn": acceptedOrRejectedOn != null
            ? acceptedOrRejectedOn.toIso8601String()
            : null,
      };
}

InstituteBatch instituteBatchFromJson(String str) =>
    InstituteBatch.fromJson(json.decode(str));

String instituteBatchToJson(InstituteBatch data) => json.encode(data.toJson());

class InstituteBatch {
  InstituteBatch({
    this.id,
    this.acquiredSeatCount,
    this.syllabuses,
    this.status,
    this.instituteCourse,
    this.price,
    this.name,
    this.totalSeatCount,
    this.createdBy,
    this.institute,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  int acquiredSeatCount;
  List<String> syllabuses;
  int status;
  String instituteCourse;
  int price;
  String name;
  int totalSeatCount;
  String createdBy;
  String institute;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory InstituteBatch.fromJson(Map<String, dynamic> json) => InstituteBatch(
        id: json["_id"] ?? '',
        acquiredSeatCount: json["acquiredSeatCount"] ?? 0,
        syllabuses: json["syllabuses"] == null
            ? []
            : List<String>.from(json["syllabuses"].map((x) => x)),
        status: json["status"] ?? 0,
        instituteCourse: json["instituteCourse"] ?? '',
        price: json["price"] ?? 0,
        name: json["name"] ?? '',
        totalSeatCount: json["totalSeatCount"] ?? 0,
        createdBy: json["createdBy"] ?? '',
        institute: json["institute"] ?? '',
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
        "acquiredSeatCount": acquiredSeatCount,
        "syllabuses": List<dynamic>.from(syllabuses.map((x) => x)),
        "status": status,
        "instituteCourse": instituteCourse,
        "price": price,
        "name": name,
        "totalSeatCount": totalSeatCount,
        "createdBy": createdBy,
        "institute": institute,
        "createdAt": createdAt != null ? createdAt.toIso8601String() : null,
        "updatedAt": updatedAt != null ? updatedAt.toIso8601String() : null,
        "__v": v,
      };
}
