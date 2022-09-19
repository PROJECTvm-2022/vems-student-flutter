import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vems/api_services/authentication_api_services.dart';
import 'package:vems/data_models/institute_data.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/authentication/login/login_page.dart';
import 'package:vems/pages/authentication/welcome/welcome_page.dart';
import 'package:vems/utils/auth_helper.dart';
import 'package:vems/utils/dialogue_helper.dart';
import 'package:vems/utils/shared_preference_helper.dart';
import 'package:vems/utils/snackbar_helper.dart';
import 'package:vems/widgets/button.dart';
import 'package:vems/widgets/my_avatar.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 8/1/21 at 5:47 PM
///

class PendingRequestPage extends StatefulWidget {
  static final routeName = '/PendingRequestPage';

  @override
  _PendingRequestPageState createState() => _PendingRequestPageState();
}

class _PendingRequestPageState extends State<PendingRequestPage> {
  InstituteDatum get institute =>
      SharedPreferenceHelper.user.studentSeat.institute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          refreshUser().then((datum) {
            SharedPreferenceHelper.storeUser(user: datum);
            checkUserLevel();
          }).catchError((err) {
            SnackBarHelper.show("", "$err");
          });
        },
        child: ListView(
          children: [
            const SizedBox(height: 200),
            MyCircleAvatar(
              institute.logo,
              radius: 70,
            ),
            const SizedBox(height: 16),
            Center(child: Text(S.of(context).yourRequestIsPendingUnder)),
            const SizedBox(height: 10),
            Center(
              child: Text(
                institute.name,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: MyButton(
                child: Text('Logout'),
                onPressed: () {
                  showJupionDialogue(
                      title: 'Log Out',
                      description: 'Are you sure you want to log out ?',
                      positiveCallback: () {
                        SharedPreferenceHelper.logOut();
                        Get.offAllNamed(LoginPage.routeName);
                      },
                      positiveText: 'Yes',
                      negativeText: 'No');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
