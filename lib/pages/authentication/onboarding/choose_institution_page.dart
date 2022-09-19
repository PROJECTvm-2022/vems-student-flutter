import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vems/config/index.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/authentication/onboarding/choose_course_page.dart';
import 'package:vems/pages/authentication/onboarding/widgets/search_institute_field.dart';
import 'package:vems/pages/authentication/widgets/auth_text_widgets.dart';
import 'package:vems/utils/snackbar_helper.dart';
import 'package:vems/widgets/back_button.dart';
import 'package:vems/widgets/button.dart';
import 'package:vems/widgets/logout_button.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 6/1/21 at 1:14 AM
///

class ChooseInstitutionPage extends StatefulWidget {
  static final routeName = '/ChooseInstitutionPage';

  @override
  _ChooseInstitutionPageState createState() => _ChooseInstitutionPageState();
}

class _ChooseInstitutionPageState extends State<ChooseInstitutionPage> {
  String instituteId = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: MyBackButton(),
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
                AuthHeadingText(S.of(context).chooseAnInstitute),
                const SizedBox(height: 8),
                Text(
                  S.of(context).searchForAnInstituteToContinue,
                  style: TextStyle(
                    color: MyColors.labelColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                SearchInstituteField(
                  onChanged: (val) {
                    if (val.isEmpty) {
                      instituteId = '';
                    }
                  },
                  onSuggestionSelected: (id) {
                    print("institute id : $id");
                    instituteId = id;
                  },
                )
              ],
            ),
          ),
          Positioned(
            bottom: 25,
            right: 16,
            left: 16,
            child: MyButton(
              child: Text(S.of(context).next),
              width: double.infinity,
              onPressed: () {
                if (instituteId.isNotEmpty) {
                  Get.toNamed(
                    ChooseCoursePage.routeName,
                    arguments: instituteId,
                  );
                } else {
                  SnackBarHelper.show(
                    S.of(context).oops,
                    S.of(context).pleaseSelectAnInstitutionFromTheListToProceed,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
