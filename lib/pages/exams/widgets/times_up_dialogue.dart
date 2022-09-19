import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vems/config/colors.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/dashboard/dashboard_page.dart';
import 'package:vems/pages/dashboard/pages/exams/exams_page.dart';
import 'package:vems/widgets/button.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 10/4/21 at 2:24 PM
///

class TimesUpDialogue extends StatelessWidget {
  final String examId;

  const TimesUpDialogue({Key key, this.examId = ''}) : super(key: key);

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
                  S.of(context).zeroTime,
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  S.of(context).timesUp,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                MyButton(
                  color: Colors.white,
                  width: double.infinity,
                  child: Text(
                    "Back to Dashboard",
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
