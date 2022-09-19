import 'package:flutter/material.dart';
import 'package:vems/api_services/base_api.dart';
import 'package:vems/config/api_routes.dart';
import 'package:vems/data_models/user.dart';
import 'package:vems/utils/shared_preference_helper.dart';

///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 7/1/2020 11:38 AM
///

/// Api Call to sign in using email id
Future<UserDatum> signInWithEmail(String email, String password) async {
  Map<String, dynamic> body = {
    "strategy": "local",
    "email": email,
    "password": password,
    "fcmId": '1213123'
  };
  Map<String, dynamic> query = {"\$populate": "institute"};

  var resultMap = await ApiCall.post(ApiRoutes.authentication,
      query: query, body: body, isAuthNeeded: false);

  SharedPreferenceHelper.storeAccessToken(resultMap.data['accessToken']);
  return UserDatum.fromJson(resultMap.data['user']);
}

/// Api Call to sign up using email id
Future<UserDatum> signUpWithEmail(String email, String password) async {
  Map<String, dynamic> body = {
    "email": email,
    "password": password,
    "role": 1,
  };

  var resultMap =
      await ApiCall.post(ApiRoutes.user, body: body, isAuthNeeded: false);

  SharedPreferenceHelper.storeAccessToken(resultMap.data['accessToken']);
  return UserDatum.fromJson(resultMap.data['user']);
}

/// Api Call to update user data
Future<UserDatum> userOnBoarding(
    {@required Map<String, dynamic> body, String id}) async {
  var resultMap = await ApiCall.patch(
    ApiRoutes.user,
    body: body,
    id: id ?? SharedPreferenceHelper.user.id,
  );

  return UserDatum.fromJson(resultMap.data);
}

/// APi call to send otp to email
Future<dynamic> requestOtp(Map<String, dynamic> body) async {
  final result = await ApiCall.post(ApiRoutes.authenticationEmail, body: body);
  print("requestOtp${result.data}");
  return result.data;
}

/// APi call to verify otp  email
Future<dynamic> verifyEmailOtp(Map<String, dynamic> body) async {
  final result = await ApiCall.patch(ApiRoutes.authenticationEmail, body: body);
  print("verifyEmailOtp${result.data}");
  return result.data;
}

/// Api call to verify email`
Future verifyEmail(String email, String otp) async {
  final result = await ApiCall.post(ApiRoutes.verifyEmail,
      body: {"email": email, "otp": otp});
  return result.data['message'];
}

/// Api call to verify reset password OTP
Future verifyResetOTP(String email, String otp) async {
  final result = await ApiCall.post(ApiRoutes.verifyResetOTP,
      body: {"email": email, "otp": otp});
  return result.data['passwordResetToken'];
}

/// Api call to update password
Future resetPassword({
  String token,
  String password,
  String confirmPassword,
}) async {
  final result = await ApiCall.post(ApiRoutes.resetPassword, body: {
    "passwordResetToken": token,
    "newPassword": password,
    "confirmPassword": confirmPassword
  });
  return result.data['message'];
}

/// Get updated user and accessToken from server without login
Future<UserDatum> refreshUser() async {
  Map<String, dynamic> body = {
    "strategy": "jwt",
    "accessToken": SharedPreferenceHelper.accessToken,
    "fcmId": "12121312"
  };
  Map<String, dynamic> query = {r"$populate": "institute"};

  var resultMap = await ApiCall.post(ApiRoutes.authentication,
      query: query, body: body, isAuthNeeded: false);

  SharedPreferenceHelper.storeAccessToken(resultMap.data['accessToken']);
  return UserDatum.fromJson(resultMap.data['user']);
}

/// --------- parent
/// Api Call to sign up using phone
Future<UserDatum> signUpWithPhone(String phone, String password) async {
  Map<String, dynamic> body = {
    "phone": phone,
    "password": password,
    "role": 16
  };

  var resultMap =
      await ApiCall.post(ApiRoutes.user, body: body, isAuthNeeded: false);

  SharedPreferenceHelper.storeAccessToken(resultMap.data['accessToken']);
  return UserDatum.fromJson(resultMap.data['user']);
}

/// Api call to verify parent phone
Future verifyPhone(String phone, String otp) async {
  final result = await ApiCall.post(ApiRoutes.verifyParent,
      body: {"phone": phone, "otp": otp});
  return result.data['message'];
}

/// parent login
Future<UserDatum> signInWithPhone(String phone, String password) async {
  Map<String, dynamic> body = {
    "strategy": "phone",
    "phone": phone,
    "password": password,
    "fcmId": "212121"
  };
  Map<String, dynamic> query = {r"$populate": "institute"};

  print("$body");
  var resultMap = await ApiCall.post(ApiRoutes.authentication,
      query: query, body: body, isAuthNeeded: false);
  // print("$body");
  SharedPreferenceHelper.storeAccessToken(resultMap.data['accessToken']);
  return UserDatum.fromJson(resultMap.data['user']);
}
