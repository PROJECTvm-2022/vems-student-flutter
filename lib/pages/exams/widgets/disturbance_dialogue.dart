import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vems/config/index.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/dashboard/dashboard_page.dart';
import 'package:vems/pages/dashboard/pages/exams/exams_page.dart';
import 'package:vems/widgets/button.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 10/4/21 at 4:46 PM
///

class DisturbanceDialogue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Material(
        color: Colors.black12,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
          color: Colors.black12,
          height: height,
          width: width,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Column(
              children: [
                Spacer(),
                Text(
                  "Exam aborted",
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  S.of(context).youreNowOutOfThisExamination,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                MyButton(
                  color: Colors.white,
                  width: double.infinity,
                  child: Text(
                    S.of(context).backToDashboard,
                    style: TextStyle(color: MyColors.brightPrimary),
                  ),
                  onPressed: () {
                    Get.offNamedUntil(ExamsPage.routeName,
                        (route) => route.settings.name == ExamsPage.routeName);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
