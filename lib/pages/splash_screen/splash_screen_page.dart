import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:vems/api_services/authentication_api_services.dart';
import 'package:vems/config/index.dart';
import 'package:vems/pages/authentication/login/login_page.dart';
import 'package:vems/pages/dashboard/pages/exams/exams_page.dart';
import 'package:vems/utils/shared_preference_helper.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 4/1/21 at 8:47 PM
///

class SplashScreen extends StatefulWidget {
  static final routeName = '/SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (SharedPreferenceHelper.accessToken != null) {
        refreshUser()
            .then((datum) {
              SharedPreferenceHelper.storeUser(user: datum);
            })
            .catchError((err) {})
            .whenComplete(() {
              // checkUserLevel();
              Get.offAllNamed(ExamsPage.routeName);
            });
      } else {
        Get.offAllNamed(LoginPage.routeName);
      }
    });
    // if (SharedPreferenceHelper.accessToken != null) {
    //   /// each time jwt refresh to get latest user from server
    //   refreshUser().then((datum) {
    //     SharedPreferenceHelper.storeUser(user: datum);
    //     Future.delayed(Duration(milliseconds: 600))
    //         .then((value) => checkUserLevel());
    //   }).catchError((err, s) {
    //     SnackBarHelper.show(S.of(context).error, err?.toString());
    //     Future.delayed(Duration(milliseconds: 600))
    //         .then((value) => Get.offAllNamed(WelcomePage.routeName));
    //   });
    // } else {
    //   Future.delayed(Duration(milliseconds: 500), () => checkUserLevel());
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Center(
          child: Image.asset(
            MyAssets.splashLogo,
            width: 250,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
