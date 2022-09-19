import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vems/api_services/base_api.dart';
import 'package:vems/config/api_routes.dart';
import 'package:vems/data_models/user.dart';
import 'package:vems/pages/authentication/intro/intro_page.dart';
import 'package:vems/pages/authentication/login/login_page.dart';
import 'package:vems/pages/authentication/onboarding/avatar_selection_page.dart';
import 'package:vems/pages/authentication/onboarding/choose_institution_page.dart';
import 'package:vems/pages/authentication/onboarding/parent_onboarding_page.dart';
import 'package:vems/pages/authentication/onboarding/personal_info_page.dart';
import 'package:vems/pages/authentication/signup/verify_email_page.dart';
import 'package:vems/pages/authentication/welcome/welcome_page.dart';
import 'package:vems/pages/dashboard/dashboard_page.dart';
import 'package:vems/pages/dashboard/pages/exams/exams_page.dart';
import 'package:vems/pages/pending_request/pending_request_page.dart';
import 'package:vems/utils/shared_preference_helper.dart';
import 'package:vems/utils/snackbar_helper.dart';
import 'package:device_info_plus/device_info_plus.dart';

///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 6/29/2020 11:19 AM
///

Future<void> checkUserLevel() async {
  UserDatum user = SharedPreferenceHelper.user;
  UserDatum primaryStudent = SharedPreferenceHelper.user;

  if (user != null) {
    dashboardIndexNotifier?.value = 0;
    Get.offAllNamed(ExamsPage.routeName);
    // if (!user.emailVerified) {
    //   Get.offAllNamed(VerifyEmailPage.routeName);
    // } else if (user.name.isEmpty || user.phone.isEmpty) {
    //   Get.offAllNamed(PersonalInfoPage.routeName);
    // } else if (user.avatar.isEmpty) {
    //   Get.offAllNamed(AvatarSelectionPage.routeName);
    // } else if (user.studentSeat == null) {
    //   Get.offAllNamed(ChooseInstitutionPage.routeName);
    // } else {
    //   try {
    //     if (user.studentSeat.status == 1) {
    //       Get.offAllNamed(PendingRequestPage.routeName);
    //     } else {
    //       dashboardIndexNotifier?.value = 0;
    //       Get.offAllNamed(ExamsPage.routeName);
    //     }
    //   } catch (err) {
    //     SnackBarHelper.show("ERROR", err?.toString());
    //     Future.delayed(Duration(milliseconds: 600))
    //         .then((value) => Get.offAllNamed(LoginPage.routeName));
    //   }
    // }
  } else {
    if (SharedPreferenceHelper.isFirstTime) {
      Get.offAllNamed(IntroPage.routeName);
    } else {
      Get.offAllNamed(LoginPage.routeName);
    }
  }
}

Future<UserDatum> userLoginWithGoogle() async {
  GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: ['email'],
      clientId:
          '339902792815-bn8lfr00p7ac3994ebumaapt64d5el36.apps.googleusercontent.com');
  try {
// final latLng = await CheckPermissions.getCurrentLocation();

    final deviceInfo = await getDeviceDetails();
    GoogleSignInAccount result = await _googleSignIn.signIn();
    if (result == null) {
      return null;
    }
    GoogleSignInAuthentication googleAuth = await result.authentication;
    log('TOKEN ${googleAuth.accessToken}');
    final resultMap = await ApiCall.post(ApiRoutes.googleLogin,
        body: {
          "accessToken": googleAuth.accessToken,
          "deviceId": deviceInfo['identifier'],
          "platform": deviceInfo['deviceId'],
// "coordinates": [latLng.longitude, latLng.latitude],
        },
        // query: {"\$populate": "community"},
        isAuthNeeded: false);

    final userResponse = UserDatum.fromJson(resultMap.data);
    print("sing respo $userResponse");
    SharedPreferenceHelper.storeAccessToken(resultMap.data["accessToken"]);
    SharedPreferenceHelper.storeUser(user: userResponse);
    return userResponse;
  } catch (e) {
    rethrow;
  } finally {
    _googleSignIn.signOut();
  }
}

Future<Map<String, dynamic>> getDeviceDetails() async {
  String deviceName;
  String identifier;
  int deviceType;
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      deviceType = 1;
      final build = await deviceInfoPlugin.androidInfo;
      deviceName = build.model;
//deviceVersion = build.version.toString();
      identifier = build.androidId; //UUID for Android
    } else if (Platform.isIOS) {
      deviceType = 2;
      final data = await deviceInfoPlugin.iosInfo;
      deviceName = data.name;
//deviceVersion = data.systemVersion;
      identifier = data.identifierForVendor; //UUID for iOS
    }
  } on PlatformException {
    throw 'Failed to get platform version';
  }
  return {
    "deviceId": Platform.isAndroid ? 1 : 2,
    "deviceName": deviceName,
    "identifier": identifier,
    "deviceType": deviceType
  };
}
