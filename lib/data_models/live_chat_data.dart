///
/// Created by Sunil Kumar on 17-03-2021 06:09 PM.
///
// To parse this JSON data, do
//
//     final liveChatResponse = liveChatResponseFromJson(jsonString);

import 'dart:convert';

import 'package:vems/data_models/user.dart';

LiveChatResponse liveChatResponseFromJson(String str) =>
    LiveChatResponse.fromJson(json.decode(str));

String liveChatResponseToJson(LiveChatResponse data) =>
    json.encode(data.toJson());

class LiveChatResponse {
  LiveChatResponse({
    this.total,
    this.limit,
    this.skip,
    this.data,
  });

  int total;
  int limit;
  int skip;
  List<LiveChatDatum> data;

  factory LiveChatResponse.fromJson(Map<String, dynamic> json) =>
      LiveChatResponse(
        total: json["total"],
        limit: json["limit"],
        skip: json["skip"],
        data: List<LiveChatDatum>.from(
            json["data"].map((x) => LiveChatDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "limit": limit,
        "skip": skip,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LiveChatDatum {
  LiveChatDatum({
    this.id,
    this.text,
    this.answerOfQuiz,
    this.attachments,
    this.type,
    this.entityType,
    this.entityId,
    this.createdBy,
    this.status,
    this.options,
    this.createdAt,
    this.updatedAt,
    this.duration,
    this.answerGiven,
    this.publishedAt,
  });

  String id;
  String text;
  String answerOfQuiz;
  List<String> attachments;

  /// 1. message, 2. quiz, 3.answer of quiz
  int type;
  String entityType;
  LiveChatDatum entityId;
  UserDatum createdBy;

  /// 1. active 2. quiz created, 3. deleted
  int status;
  List<ChatOption> options;
  DateTime createdAt;
  DateTime updatedAt;
  int duration;
  String answerGiven;

  DateTime publishedAt;

  factory LiveChatDatum.fromJson(Map<String, dynamic> json) => LiveChatDatum(
        id: json["_id"],
        text: json["text"] ?? '',
        answerOfQuiz: json["answerOfQuiz"] ?? '',
        attachments: json["attachments"] != null
            ? List<String>.from(json["attachments"].map((x) => x))
            : [],
        type: json["type"] ?? 1,
        entityType: json["entityType"] ?? '',
        answerGiven: json["answerGiven"] ?? '',
        entityId: json["entityId"] == null
            ? null
            : json["entityId"] is String
                ? LiveChatDatum(id: json["entityId"])
                : LiveChatDatum.fromJson(json["entityId"]),
        createdBy: json["createdBy"] != null
            ? json["createdBy"] is String
                ? UserDatum.fromJson({'_id': json["createdBy"]})
                : UserDatum.fromJson(json["createdBy"])
            : null,
        status: json["status"] ?? 1,
        options: json["options"] == null
            ? []
            : List<ChatOption>.from(
                json["options"].map((x) => ChatOption.fromJson(x))),
        duration: json["duration"] ?? 0,
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        publishedAt: json["publishedAt"] != null
            ? DateTime.parse(json["publishedAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "text": text,
        "answerOfQuiz": answerOfQuiz == null ? null : answerOfQuiz,
        "attachments": List<dynamic>.from(attachments.map((x) => x)),
        "type": type,
        "entityType": entityType,
        "entityId": entityId,
        "createdBy": createdBy.toJson(),
        "status": status,
        "options":
            options == null ? null : List<dynamic>.from(options.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "publishedAt": publishedAt?.toIso8601String(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LiveChatDatum &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

ChatOption chatOptionFromJson(String str) =>
    ChatOption.fromJson(json.decode(str));

String chatOptionToJson(ChatOption data) => json.encode(data.toJson());

class ChatOption {
  ChatOption({
    this.supportCount,
    this.id,
    this.name,
  });

  int supportCount;
  String id;
  String name;

  factory ChatOption.fromJson(Map<String, dynamic> json) => ChatOption(
        supportCount: json["supportCount"],
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "supportCount": supportCount,
        "_id": id,
        "name": name,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatOption && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
