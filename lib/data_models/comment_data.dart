///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 11/1/21 at 11:41 PM
///

import 'dart:convert';

import 'package:vems/data_models/user.dart';

CommentDatum commentDatumFromJson(String str) =>
    CommentDatum.fromJson(json.decode(str));

String commentDatumToJson(CommentDatum data) => json.encode(data.toJson());

class CommentDatum {
  CommentDatum({
    this.type,
    this.status,
    this.commentCount,
    this.id,
    this.comment,
    this.entityType,
    this.entityId,
    this.parentEntityType,
    this.parentEntityId,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  int type;
  int status;
  int commentCount;
  String id;
  String comment;
  String entityType;
  String entityId;
  String parentEntityType;
  String parentEntityId;
  UserDatum createdBy;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory CommentDatum.fromJson(Map<String, dynamic> json) => CommentDatum(
        type: json["type"] ?? 0,
        status: json["status"] ?? 0,
        commentCount: json["commentCount"] ?? 0,
        id: json["_id"] ?? '',
        comment: json["comment"] ?? '',
        entityType: json["entityType"] ?? '',
        entityId: json["entityId"] ?? '',
        parentEntityType: json["parentEntityType"] ?? '',
        parentEntityId: json["parentEntityId"] ?? "",
        createdBy: json["createdBy"] != null
            ? json["createdBy"] is String
                ? UserDatum.fromJson({"_id": json["createdBy"]})
                : UserDatum.fromJson(json["createdBy"])
            : UserDatum(),
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "status": status,
        "commentCount": commentCount,
        "_id": id,
        "comment": comment,
        "entityType": entityType,
        "entityId": entityId,
        "parentEntityType": parentEntityType,
        "parentEntityId": parentEntityId,
        "createdBy": createdBy != null ? createdBy.toJson() : null,
        "createdAt": createdAt != null ? createdAt.toIso8601String() : null,
        "updatedAt": updatedAt != null ? updatedAt.toIso8601String() : null,
        "__v": v,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentDatum &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
