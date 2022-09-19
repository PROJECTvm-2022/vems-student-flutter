import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vems/api_services/authentication_api_services.dart';
import 'package:vems/config/index.dart';
import 'package:vems/data_models/user.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/authentication/login/login_page.dart';
import 'package:vems/pages/authentication/widgets/auth_text_widgets.dart';
import 'package:vems/pages/authentication/widgets/role_switcher.dart';
import 'package:vems/utils/auth_helper.dart';
import 'package:vems/utils/my_form_validators.dart';
import 'package:vems/utils/shared_preference_helper.dart';
import 'package:vems/utils/snackbar_helper.dart';
import 'package:vems/widgets/back_button.dart';
import 'package:vems/widgets/button.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 5/1/21 at 11:01 AM
///

class SignUpPage extends StatefulWidget {
  static final routeName = '/SignUpPage';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isObscure = false;
  String _emailId = '', _password = '', _phone = '';
  final _formKey = GlobalKey<FormState>();
  final _buttonKey = GlobalKey<MyButtonState>();
  bool autoValidate = false;
  int role = 1;

  /// 1 - ems , 2 - parent

  // _back() {
  //   Get.offNamedUntil(WelcomePage.routeName,
  //       (route) => route.settings.name == WelcomePage.routeName);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MyBackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        autovalidateMode:
            autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          children: [
            const SizedBox(height: 15),
            AuthHeadingText(S.of(context).registerNow),
            const SizedBox(height: 30),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: role == 1
                  ? SvgPicture.asset(MyAssets.signUpVector)
                  : SvgPicture.asset(MyAssets.parentVector),
            ),
            const SizedBox(height: 30),
            RoleSwitcher(
              role: role,
              onChanged: (r) {
                setState(() {
                  role = r;
                  autoValidate = false;
                });
              },
            ),
            const SizedBox(height: 20),
            TFLabelText(
                role == 1 ? S.of(context).emailId : S.of(context).phoneNo),
            role == 1
                ? TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      _emailId = value.trim();
                      return MyFormValidators.validateMail(value.trim());
                    },
                    decoration:
                        MyDecorations.textFieldDecoration(context).copyWith(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: SvgPicture.asset(
                          MyAssets.mail,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? MyColors.lightTextColor
                                  : MyColors.darkTextColor,
                        ),
                      ),
                      hintText: S.of(context).enterYourEmailId,
                    ),
                  )
                : TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) {
                      _phone = value.trim();
                      return MyFormValidators.validatePhone(value.trim());
                    },
                    decoration:
                        MyDecorations.textFieldDecoration(context).copyWith(
                      prefixIconConstraints: BoxConstraints.tightFor(width: 64),
                      prefixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            child: Text(
                              '+91',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            height: 32,
                            width: 1,
                            margin: const EdgeInsets.only(right: 8),
                            color: Colors.grey,
                          )
                        ],
                      ),
                      hintText: "Enter your phone no.",
                    ),
                  ),
            const SizedBox(height: 15),
            TFLabelText(S.of(context).password),
            TextFormField(
              obscureText: _isObscure ? false : true,
              textInputAction: TextInputAction.done,
              validator: (value) {
                _password = value.trim();
                return MyFormValidators.validatePassword(value.trim());
              },
              decoration: MyDecorations.textFieldDecoration(context).copyWith(
                hintText: S.of(context).enterYourPassword,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: SvgPicture.asset(
                    MyAssets.password,
                    color: Theme.of(context).brightness == Brightness.light
                        ? MyColors.lightTextColor
                        : MyColors.darkTextColor,
                  ),
                ),
                suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                      color: MyColors.labelColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    }),
              ),
            ),
            const SizedBox(height: 28),
            MyButton(
              key: _buttonKey,
              child: Text(S.of(context).signUp),
              onPressed: () async {
                ///-------- SIGN UP WITH EMAIL ID AND PASSWORD API CALL-----------
                try {
                  if (_formKey.currentState.validate()) {
                    print("$_emailId, $_phone and $_password");
                    _buttonKey.currentState.showLoader();
                    UserDatum _tempDatum;

                    if (role == 1) {
                      /// student
                      _tempDatum = await signUpWithEmail(_emailId, _password);
                    } else {
                      /// parent
                      _tempDatum = await signUpWithPhone(_phone, _password);
                    }
                    _buttonKey.currentState.hideLoader();
                    SharedPreferenceHelper.storeUser(user: _tempDatum);
                    checkUserLevel();
                  } else {
                    setState(() {
                      autoValidate = true;
                    });
                  }
                } catch (err) {
                  _buttonKey.currentState.hideLoader();
                  SnackBarHelper.show("ERROR", err?.toString());
                }

                ///-------------------------------------------------------------
              },
              width: double.infinity,
            ),
            const SizedBox(height: 24),
            Center(
              child: RichText(
                  text: TextSpan(
                      text: S.of(context).alreadyAnUser,
                      style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? MyColors.lightTextColor
                                  : MyColors.darkTextColor,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                      children: <TextSpan>[
                    TextSpan(
                        text: ' ' + S.of(context).loginHere,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: MyColors.primaryBlue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            Get.back();
                            Get.toNamed(LoginPage.routeName);
                          })
                  ])),
            )
          ],
        ),
      ),
    );
  }
}
