///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 22/4/21 at 8:56 PM
///

import 'dart:convert';

FaqDatum faqDatumFromJson(String str) => FaqDatum.fromJson(json.decode(str));

String faqDatumToJson(FaqDatum data) => json.encode(data.toJson());

class FaqDatum {
  FaqDatum({
    this.id,
    this.status,
    this.question,
    this.answer,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  int status;
  String question;
  String answer;
  String createdBy;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory FaqDatum.fromJson(Map<String, dynamic> json) => FaqDatum(
        id: json["_id"] ?? '',
        status: json["status"] ?? 0,
        question: json["question"] ?? '',
        answer: json["answer"] ?? '',
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
        "status": status,
        "question": question,
        "answer": answer,
        "createdBy": createdBy,
        "createdAt": createdAt != null ? createdAt.toIso8601String() : null,
        "updatedAt": updatedAt != null ? updatedAt.toIso8601String() : null,
        "__v": v,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FaqDatum && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
