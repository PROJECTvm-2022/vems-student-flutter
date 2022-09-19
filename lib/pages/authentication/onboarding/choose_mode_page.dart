import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vems/api_services/request_institute_access_api_services.dart';
import 'package:vems/config/index.dart';
import 'package:vems/data_models/user.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/authentication/onboarding/widgets/mode_selection_widget.dart';
import 'package:vems/pages/authentication/widgets/auth_text_widgets.dart';
import 'package:vems/pages/pending_request/pending_request_page.dart';
import 'package:vems/utils/shared_preference_helper.dart';
import 'package:vems/utils/snackbar_helper.dart';
import 'package:vems/widgets/back_button.dart';
import 'package:vems/widgets/button.dart';
import 'package:vems/widgets/logout_button.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 8/1/21 at 5:14 PM
///

class ChooseAttendanceModePage extends StatefulWidget {
  static final routeName = '/ChooseAttendanceModePage';

  @override
  _ChooseAttendanceModePageState createState() =>
      _ChooseAttendanceModePageState();
}

class _ChooseAttendanceModePageState extends State<ChooseAttendanceModePage> {
  final _buttonKey = GlobalKey<MyButtonState>();
  String _instituteId = '';
  String _courseId = '';
  int _modeOfClass = 0;

  @override
  void initState() {
    Map<String, dynamic> map = Get.arguments;
    _instituteId = map['instituteId'] ?? '';
    _courseId = map['courseId'] ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MyBackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [LogoutButton()],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              children: [
                const SizedBox(height: 24),
                AuthHeadingText(S.of(context).chooseModeOfClasses),
                const SizedBox(height: 8),
                Text(
                  S.of(context).selectTheModeOfClassesThatYouWouldLikeTo,
                  style: TextStyle(
                    color: MyColors.labelColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                ModeSelectionWidget(
                  hintText: "Select mode of class",
                  data: ["Physical", "Virtual"],
                  onChanged: (value) {
                    setState(() {
                      _modeOfClass = value == 'Physical' ? 2 : 1;
                    });
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 25,
            right: 16,
            left: 16,
            child: MyButton(
              key: _buttonKey,
              child: Text(S.of(context).next),
              width: double.infinity,
              onPressed: _modeOfClass == 0
                  ? null
                  : () {
                      print("$_instituteId + $_courseId + $_modeOfClass");
                      //-------------API CALL TO REQUEST TO AN INSTITUTE FOR ACCESS-----------------
                      _buttonKey.currentState.showLoader();
                      requestForInstituteAccess(
                        course: _courseId,
                        institute: _instituteId,
                        mode: _modeOfClass,
                      ).then((datum) {
                        _buttonKey.currentState.hideLoader();
                        SnackBarHelper.show(
                            S.of(context).submitted,
                            S
                                .of(context)
                                .yourRequestForTheInstituteHasBeenSubmittedSuccessfully);
                        // update the seat datum in shared-pref
                        UserDatum temp = SharedPreferenceHelper.user;
                        temp.studentSeat = datum;
                        SharedPreferenceHelper.storeUser(user: temp);
                        Future.delayed(Duration(milliseconds: 700))
                            .then((value) {
                          Get.offAllNamed(PendingRequestPage.routeName);
                        });
                      }).catchError((err) {
                        _buttonKey.currentState.hideLoader();
                        SnackBarHelper.show(
                            S.of(context).error, err?.toString());
                      });
                    },
            ),
          ),
        ],
      ),
    );
  }
}
