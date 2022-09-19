///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 14/1/21 at 11:15 PM
///

import 'dart:convert';

QuestionData questionDataFromJson(String str) =>
    QuestionData.fromJson(json.decode(str));

String questionDataToJson(QuestionData data) => json.encode(data.toJson());

class QuestionData {
  QuestionData({
    this.total,
    this.limit,
    this.skip,
    this.data,
  });

  int total;
  int limit;
  int skip;
  List<QuestionDatum> data;

  factory QuestionData.fromJson(Map<String, dynamic> json) => QuestionData(
        total: json["total"],
        limit: json["limit"],
        skip: json["skip"],
        data: json["data"] == null
            ? []
            : List<QuestionDatum>.from(
                json["data"].map((x) => QuestionDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "limit": limit,
        "skip": skip,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

QuestionDatum questionDatumFromJson(String str) =>
    QuestionDatum.fromJson(json.decode(str));

String questionDatumToJson(QuestionDatum data) => json.encode(data.toJson());

class QuestionDatum {
  QuestionDatum({
    this.id,
    this.choices,
    this.myChoice = '',
    this.questionType,
    this.hardnessLevel,
    this.status,
    this.question,
    this.entityType,
    this.entityId,
    this.answer,
    this.answerType,
    this.mark,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.studentAnswer,
    this.colorIndex = 0,
  });

  String id;
  List<String> choices;
  String myChoice;
  int questionType;
  int hardnessLevel;
  int status;
  String question;
  String entityType;
  String entityId;
  AnswerDatum answer;
  int answerType;
  int mark;
  String createdBy;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  StudentAnswerDatum studentAnswer;
  int colorIndex;

  // Color Index values
  // 0. not reached
  // 1. viewed
  // 2. answered

  factory QuestionDatum.fromJson(Map<String, dynamic> json) => QuestionDatum(
        id: json["_id"] ?? '',
        choices: json["choices"] != null
            ? List<String>.from(json["choices"].map((x) => x))
            : [],
        questionType: json["questionType"] ?? 0,
        hardnessLevel: json["hardnessLevel"] ?? 0,
        status: json["status"] ?? 0,
        question: json["question"] ?? '',
        entityType: json["entityType"] ?? '',
        entityId: json["entityId"] ?? '',
        answer: json["answer"] != null
            ? AnswerDatum.fromJson(json["answer"])
            : null,
        answerType: json["answerType"] ?? 0,
        mark: json["mark"] ?? 0,
        createdBy: json["createdBy"] ?? '',
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        v: json["__v"] ?? 0,
        studentAnswer: json["studentAnswer"] != null
            ? StudentAnswerDatum.fromJson(json["studentAnswer"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "choices": List<dynamic>.from(choices.map((x) => x)),
        "questionType": questionType,
        "hardnessLevel": hardnessLevel,
        "status": status,
        "question": question,
        "entityType": entityType,
        "entityId": entityId,
        "answer": answer != null ? answer.toJson() : null,
        "answerType": answerType,
        "mark": mark,
        "createdBy": createdBy,
        "createdAt": createdAt != null ? createdAt.toIso8601String() : null,
        "updatedAt": updatedAt != null ? updatedAt.toIso8601String() : null,
        "__v": v,
        "studentAnswer": studentAnswer != null ? studentAnswer.toJson() : null,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionDatum &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class AnswerDatum {
  AnswerDatum({
    this.answerOfQuestion,
  });

  List<String> answerOfQuestion;

  factory AnswerDatum.fromJson(Map<String, dynamic> json) => AnswerDatum(
        answerOfQuestion: json["answerOfQuestion"] != null
            ? json["answerOfQuestion"] is String
                ? [json["answerOfQuestion"]]
                : List<String>.from(
                    json["answerOfQuestion"].map((x) => x.toString()))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "answerOfQuestion": List<dynamic>.from(answerOfQuestion.map((x) => x)),
      };
}

class StudentAnswerDatum {
  StudentAnswerDatum({
    this.id,
    this.question,
    this.createdBy,
    this.status,
    this.entityId,
    this.entityType,
    this.attempts,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  String question;
  String createdBy;
  int status;
  String entityId;
  String entityType;
  List<AttemptDatum> attempts;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory StudentAnswerDatum.fromJson(Map<String, dynamic> json) =>
      StudentAnswerDatum(
        id: json["_id"] ?? '',
        question: json["question"] ?? '',
        createdBy: json["createdBy"] ?? '',
        status: json["status"] ?? 0,
        entityId: json["entityId"] ?? '',
        entityType: json["entityType"] ?? '',
        attempts: json["attempts"] != null
            ? List<AttemptDatum>.from(
                json["attempts"].map((x) => AttemptDatum.fromJson(x)))
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
        "question": question,
        "createdBy": createdBy,
        "status": status,
        "entityId": entityId,
        "entityType": entityType,
        "attempts": List<dynamic>.from(attempts.map((x) => x.toJson())),
        "createdAt": createdAt != null ? createdAt.toIso8601String() : null,
        "updatedAt": updatedAt != null ? updatedAt.toIso8601String() : null,
        "__v": v,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentAnswerDatum &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class AttemptDatum {
  AttemptDatum({
    this.id,
    this.answer,
    this.attemptedAt,
    this.isCorrect,
  });

  String id;
  String answer;
  DateTime attemptedAt;
  bool isCorrect;

  factory AttemptDatum.fromJson(Map<String, dynamic> json) => AttemptDatum(
        id: json["_id"] ?? '',
        answer: json["answer"] ?? '',
        attemptedAt: json["attemptedAt"] != null
            ? DateTime.parse(json["attemptedAt"])
            : null,
        isCorrect: json["isCorrect"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "answer": answer,
        "attemptedAt":
            attemptedAt != null ? attemptedAt.toIso8601String() : null,
        "isCorrect": isCorrect,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttemptDatum &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class StudentVideoAnswers {
  StudentVideoAnswers({
    this.answers,
    this.videoTobeUnlocked,
  });

  List<QuestionAnswerDatum> answers;
  String videoTobeUnlocked;

  factory StudentVideoAnswers.fromJson(Map<String, dynamic> json) =>
      StudentVideoAnswers(
        answers: json["answers"] != null
            ? List<QuestionAnswerDatum>.from(
                json["answers"].map((x) => QuestionAnswerDatum.fromJson(x)))
            : [],
        videoTobeUnlocked: json['videoTobeUnlocked'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "answers": List<dynamic>.from(answers.map((x) => x)),
        "videoTobeUnlocked": videoTobeUnlocked,
      };
}

QuestionAnswerDatum qaDatumFromJson(String str) =>
    QuestionAnswerDatum.fromJson(json.decode(str));

String qaDatumToJson(QuestionAnswerDatum data) => json.encode(data.toJson());

class QuestionAnswerDatum {
  QuestionAnswerDatum({
    this.question = '',
    this.answer = '',
    this.status = 0,
    this.id = '',
    this.correctAnswer,
  });

  String id;
  String question;
  String answer;
  int status;
  List<String> correctAnswer;

  factory QuestionAnswerDatum.fromJson(Map<String, dynamic> json) =>
      QuestionAnswerDatum(
        id: json["_id"] ?? '',
        question: json["question"] ?? '',
        answer: json["answer"] ?? '',
        status: json["status"] ?? 0,
        correctAnswer: json["correctAnswer"] != null
            ? List<String>.from(json["correctAnswer"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "answer": answer,
        "question": question,
        "status": status,
        "correctAnswer": List<dynamic>.from(correctAnswer.map((x) => x)),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionAnswerDatum &&
          runtimeType == other.runtimeType &&
          question == other.question;

  @override
  int get hashCode => question.hashCode;
}
