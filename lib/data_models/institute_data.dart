///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 6/1/21 at 8:44 PM
///

class InstituteData {
  InstituteData({
    this.id,
    this.status,
    this.institute,
    this.user,
    this.accessType,
    this.specialization,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  int status;
  String specialization;
  InstituteDatum institute;
  String user;
  int accessType;
  String createdBy;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory InstituteData.fromJson(Map<String, dynamic> json) => InstituteData(
        id: json["_id"] ?? '',
        status: json["status"] ?? 0,
        institute: json["institute"] != null
            ? json["institute"] is String
                ? InstituteDatum.fromJson({"_id": json["institute"]})
                : InstituteDatum.fromJson(json["institute"])
            : null,
        user: json["user"] ?? '',
        accessType: json["accessType"] ?? 0,
        specialization: json["specialization"] ?? '',
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
        "institute": institute != null ? institute.toJson() : null,
        "user": user,
        "accessType": accessType,
        "specialization": specialization,
        "createdBy": createdBy,
        "createdAt": createdAt != null ? createdAt.toIso8601String() : null,
        "updatedAt": updatedAt != null ? updatedAt.toIso8601String() : null,
        "__v": v,
      };
}

class InstituteDatum {
  InstituteDatum({
    this.id,
    this.status,
    this.menuLocation,
    this.affiliatedUnder,
    this.name,
    this.logo,
    this.phone,
    this.website,
    this.email,
    this.user,
    this.colorCode,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.updatedBy,
    this.state,
    this.address,
    this.city,
    this.pin,
  });

  String id;
  int status;
  String menuLocation;
  dynamic affiliatedUnder;
  String name;
  String logo;
  String phone;
  String website;
  String email;
  String user;
  ColorCode colorCode;
  String createdBy;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String updatedBy;
  String address;
  String city;
  String state;
  String pin;

  factory InstituteDatum.fromJson(Map<String, dynamic> json) => InstituteDatum(
        id: json["_id"] ?? '',
        status: json["status"] ?? 0,
        menuLocation: json["menuLocation"] ?? '',
        affiliatedUnder: json["affiliatedUnder"],
        name: json["name"] ?? '',
        logo: json["logo"] ?? '',
        phone: json["phone"] ?? '',
        website: json["website"] ?? '',
        email: json["email"] ?? '',
        user: json["user"] ?? '',
        colorCode: json["colorCode"] != null
            ? ColorCode.fromJson(json["colorCode"])
            : null,
        createdBy: json["createdBy"] ?? '',
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        v: json["__v"],
        updatedBy: json["updatedBy"] ?? '',
        address: json["address"] ?? '',
        city: json["city"] ?? '',
        state: json["state"] ?? '',
        pin: json["pin"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "menuLocation": menuLocation,
        "affiliatedUnder": affiliatedUnder,
        "name": name,
        "logo": logo,
        "phone": phone,
        "website": website,
        "email": email,
        "user": user,
        "colorCode": colorCode != null ? colorCode.toJson() : null,
        "createdBy": createdBy,
        "createdAt": createdAt != null ? createdAt.toIso8601String() : null,
        "updatedAt": updatedAt != null ? updatedAt.toIso8601String() : null,
        "__v": v,
        "updatedBy": updatedBy,
        "address": address,
        "city": city,
        "state": state,
        "pin": pin,
      };
}

class ColorCode {
  ColorCode({
    this.primary,
  });

  String primary;

  factory ColorCode.fromJson(Map<String, dynamic> json) => ColorCode(
        primary: json["primary"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "primary": primary,
      };
}
