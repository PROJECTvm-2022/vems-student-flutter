import 'dart:convert';

import 'package:vems/data_models/institute_data.dart';
import 'package:vems/data_models/student_seat_datum.dart';

///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 7/1/2020 12:12 PM
///

UserDatum userDatumFromJson(String str) => UserDatum.fromJson(json.decode(str));

String userDatumToJson(UserDatum data) => json.encode(data.toJson());

class UserDatum {
  UserDatum({
    this.id,
    this.emailVerified,
    this.gender,
    this.role,
    this.status,
    this.email,
    this.name,
    this.avatar,
    this.createdAt,
    this.updatedAt,
    this.phone,
    this.parentPhone,
    this.institute,
    this.state,
    this.address,
    this.city,
    this.pin,
    this.studentSeat,
    this.students,
  });

  String id;
  bool emailVerified;
  int gender;
  int role;
  int status;
  String email;
  String name;
  String avatar;
  DateTime createdAt;
  DateTime updatedAt;
  String phone;
  String parentPhone;
  String address;
  String city;
  String state;
  String pin;
  InstituteDatum institute;
  StudentSeatDatum studentSeat;
  List<UserDatum> students;

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
        id: json["_id"] ?? '',
        emailVerified: json["emailVerified"] ?? false,
        gender: json["gender"] ?? 0,
        role: json["role"] ?? 0,
        status: json["status"] ?? 0,
        email: json["email"] ?? '',
        name: json["name"] ?? '',
        avatar: json["avatar"] ?? '',
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        phone: json["phone"] ?? '',
        parentPhone: json["parentPhone"] ?? '',
        address: json["address"] ?? '',
        city: json["city"] ?? '',
        state: json["state"] ?? '',
        pin: json["pin"] ?? '',
        institute: json["institute"] != null
            ? json["institute"] is String
                ? InstituteDatum.fromJson({"_id": json["institute"]})
                : InstituteDatum.fromJson(json["institute"])
            : null,
        studentSeat: json["studentSeat"] != null
            ? json["studentSeat"] is String
                ? StudentSeatDatum.fromJson({"_id": json["studentSeat"]})
                : StudentSeatDatum.fromJson(json["studentSeat"])
            : null,
        students: List<UserDatum>.from(json["students"] == null
            ? []
            : json["students"].map((x) => UserDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "emailVerified": emailVerified,
        "gender": gender,
        "role": role,
        "status": status,
        "email": email,
        "name": name,
        "avatar": avatar,
        "address": address,
        "city": city,
        "state": state,
        "pin": pin,
        "createdAt": createdAt != null ? createdAt.toIso8601String() : null,
        "updatedAt": updatedAt != null ? updatedAt.toIso8601String() : null,
        "phone": phone,
        "parentPhone": parentPhone,
        "institute": institute != null ? institute.toJson() : null,
        "studentSeat": studentSeat != null ? studentSeat.toJson() : null,
        "students": List<dynamic>.from(students.map((x) => x.toJson())),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDatum && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
