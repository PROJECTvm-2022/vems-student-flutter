import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vems/pages/authentication/login/login_page.dart';
import 'package:vems/utils/dialogue_helper.dart';
import 'package:vems/utils/shared_preference_helper.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 17/5/21 at 10:47 PM
///

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: TextButton(
        onPressed: () {
          showJupionDialogue(
              title: 'Log Out',
              description:
                  'Are you sure you want to log out from ${SharedPreferenceHelper.user?.email ?? ""}?',
              positiveCallback: () {
                SharedPreferenceHelper.logOut();
                Get.offAllNamed(LoginPage.routeName);
              },
              positiveText: 'Yes',
              negativeText: 'No');
        },
        child: Text("Logout"),
      ),
    );
  }
}
