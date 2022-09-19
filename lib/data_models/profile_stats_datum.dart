///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 15/4/21 at 6:21 PM
///

import 'dart:convert';

ProfileStatsDatum profileStatsDatumFromJson(String str) =>
    ProfileStatsDatum.fromJson(json.decode(str));

String profileStatsDatumToJson(ProfileStatsDatum data) =>
    json.encode(data.toJson());

class ProfileStatsDatum {
  ProfileStatsDatum({
    this.upcomingLiveClasses,
    this.attendedClasses,
    this.attendancePercentage,
  });

  int upcomingLiveClasses;
  int attendedClasses;
  int attendancePercentage;

  factory ProfileStatsDatum.fromJson(Map<String, dynamic> json) =>
      ProfileStatsDatum(
        upcomingLiveClasses: json["upcomingLiveClasses"] ?? 0,
        attendedClasses: json["attendedClasses"] ?? 0,
        attendancePercentage: json["attendancePercentage"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "upcomingLiveClasses": upcomingLiveClasses,
        "attendedClasses": attendedClasses,
        "attendancePercentage": attendancePercentage,
      };
}
