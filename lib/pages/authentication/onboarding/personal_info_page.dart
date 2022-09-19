import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vems/api_services/authentication_api_services.dart';
import 'package:vems/config/index.dart';
import 'package:vems/data_models/user.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/authentication/widgets/auth_text_widgets.dart';
import 'package:vems/utils/auth_helper.dart';
import 'package:vems/utils/my_form_validators.dart';
import 'package:vems/utils/shared_preference_helper.dart';
import 'package:vems/utils/snackbar_helper.dart';
import 'package:vems/widgets/back_button.dart';
import 'package:vems/widgets/button.dart';
import 'package:vems/widgets/logout_button.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 6/1/21 at 1:14 AM
///

class PersonalInfoPage extends StatefulWidget {
  static final routeName = '/PersonalInfoPage';

  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final _buttonKey = GlobalKey<MyButtonState>();
  bool autoValidate = false;
  String _name = "", _phone = "", _parentPhone = "";

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
                  TFLabelText(S.of(context).contactNo),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    validator: (value) {
                      _phone = value.trim();
                      return MyFormValidators.validatePhone(value.trim());
                    },
                    decoration:
                        MyDecorations.textFieldDecoration(context).copyWith(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: SvgPicture.asset(
                          MyAssets.phone,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? MyColors.lightTextColor
                                  : MyColors.darkTextColor,
                        ),
                      ),
                      hintText: S.of(context).enterYourPhoneNumber,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TFLabelText(S.of(context).parentsContactNo),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    validator: (value) {
                      _parentPhone = value.trim();
                      return _parentPhone.isEmpty
                          ? null
                          : MyFormValidators.validatePhone(value.trim());
                    },
                    decoration:
                        MyDecorations.textFieldDecoration(context).copyWith(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: SvgPicture.asset(
                          MyAssets.phone,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? MyColors.lightTextColor
                                  : MyColors.darkTextColor,
                        ),
                      ),
                      hintText: S.of(context).enterYourParentsPhoneNumber,
                    ),
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
                  ///-------- UPDATE PHONE AND NAME API CALL-----------

                  if (_formKey.currentState.validate()) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    _buttonKey.currentState.showLoader();
                    userOnBoarding(id: SharedPreferenceHelper.user.id, body: {
                      "name": _name,
                      "phone": _phone,
                      if (_parentPhone.isNotEmpty) "parentPhone": _parentPhone,
                    }).then((userDatum) {
                      _buttonKey.currentState.hideLoader();
                      UserDatum tempDatum = SharedPreferenceHelper.user;
                      tempDatum.name = userDatum.name;
                      tempDatum.phone = userDatum.phone;
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
