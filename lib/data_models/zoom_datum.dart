///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 23/5/21 at 7:40 PM
///

import 'dart:convert';

ZoomDatum zoomDatumFromJson(String str) => ZoomDatum.fromJson(json.decode(str));

String zoomDatumToJson(ZoomDatum data) => json.encode(data.toJson());

class ZoomDatum {
  ZoomDatum({
    this.signature,
    this.apiKey,
    this.apiSecret,
    this.appKey,
    this.appSecret,
    this.jwtToken,
  });

  String signature;
  String apiKey;
  String apiSecret;
  String appKey;
  String appSecret;
  String jwtToken;

  factory ZoomDatum.fromJson(Map<String, dynamic> json) => ZoomDatum(
        signature: json["signature"] ?? '',
        apiKey: json["apiKey"] ?? '',
        apiSecret: json["apiSecret"] ?? '',
        appKey: json["appKey"] ?? '',
        appSecret: json["appSecret"] ?? '',
    jwtToken: json["jwtToken"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "signature": signature,
        "apiKey": apiKey,
        "apiSecret": apiSecret,
        "appKey": appKey,
        "appSecret": appSecret,
        "jwtToken": jwtToken,
      };
}
