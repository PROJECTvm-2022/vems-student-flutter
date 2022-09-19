import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vems/api_services/authentication_api_services.dart';
import 'package:vems/config/index.dart';
import 'package:vems/data_models/user.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/authentication/widgets/auth_text_widgets.dart';
import 'package:vems/pages/authentication/widgets/gender_selector.dart';
import 'package:vems/utils/auth_helper.dart';
import 'package:vems/utils/my_form_validators.dart';
import 'package:vems/utils/shared_preference_helper.dart';
import 'package:vems/utils/snackbar_helper.dart';
import 'package:vems/widgets/back_button.dart';
import 'package:vems/widgets/button.dart';
import 'package:vems/widgets/logout_button.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 04/09/21 at 7:47 pm
///

class ParentOnboardingPage extends StatefulWidget {
  static final routeName = '/ParentOnboardingPage';

  const ParentOnboardingPage({Key key}) : super(key: key);

  @override
  _ParentOnboardingPageState createState() => _ParentOnboardingPageState();
}

class _ParentOnboardingPageState extends State<ParentOnboardingPage> {
  final _formKey = GlobalKey<FormState>();
  final _buttonKey = GlobalKey<MyButtonState>();
  bool autoValidate = false;
  String _name = "";
  int gender = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MyBackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [LogoutButton()],
      ),
      body: Form(
        key: _formKey,
        autovalidateMode:
            autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: Stack(
          children: [
            Positioned.fill(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                children: [
                  const SizedBox(height: 24),
                  AuthHeadingText(S.of(context).letUsKnowAboutYou),
                  const SizedBox(height: 8),
                  Text(
                    S.of(context).pleaseEnterFollowingDetailsToContinue,
                    style: TextStyle(
                        color: MyColors.labelColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 26),
                  TFLabelText(S.of(context).yourName),
                  TextFormField(
                    initialValue: SharedPreferenceHelper.user.name.isNotEmpty
                        ? SharedPreferenceHelper.user.name
                        : '',
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      _name = value.trim();
                      return MyFormValidators.validateName(value.trim());
                    },
                    decoration:
                        MyDecorations.textFieldDecoration(context).copyWith(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: SvgPicture.asset(
                          MyAssets.person,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? MyColors.lightTextColor
                                  : MyColors.darkTextColor,
                        ),
                      ),
                      hintText: S.of(context).enterYourName,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TFLabelText("Gender"),
                  GenderSelector(
                    gender: gender,
                    onChanged: (g) {
                      setState(() {
                        gender = g;
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
                onPressed: () {
                  ///-------- UPDATE Gender AND NAME API CALL-----------

                  if (_formKey.currentState.validate()) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    print("$_name && $gender");
                    _buttonKey.currentState.showLoader();
                    userOnBoarding(
                            id: SharedPreferenceHelper.user.id,
                            body: {"name": _name, "gender": gender})
                        .then((userDatum) {
                      _buttonKey.currentState.hideLoader();
                      UserDatum tempDatum = SharedPreferenceHelper.user;
                      tempDatum.name = userDatum.name;
                      tempDatum.gender = userDatum.gender;
                      SharedPreferenceHelper.storeUser(user: tempDatum);
                      checkUserLevel();
                    }).catchError((err) {
                      _buttonKey.currentState.hideLoader();
                      SnackBarHelper.show(S.of(context).error, err?.toString());
                    });

                    ///-------------------------------------------------------------
                  } else {
                    setState(() {
                      autoValidate = true;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
