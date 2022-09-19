import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vems/api_services/authentication_api_services.dart';
import 'package:vems/config/decorations.dart';
import 'package:vems/config/index.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/authentication/forgot_password/otp_page.dart';
import 'package:vems/pages/authentication/widgets/auth_text_widgets.dart';
import 'package:vems/utils/auth_helper.dart';
import 'package:vems/utils/my_form_validators.dart';
import 'package:vems/utils/snackbar_helper.dart';
import 'package:vems/widgets/button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vems/widgets/loader.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 5/1/21 at 11:00 AM
///

class LoginPage extends StatefulWidget {
  static final routeName = '/LoginPage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = false;
  String _emailId = '', _password = '', _phone = '';
  final _formKey = GlobalKey<FormState>();
  final _buttonKey = GlobalKey<MyButtonState>();
  bool autoValidate = false;
  int role = 1;

  // _back() {
  //   Get.offNamedUntil(WelcomePage.routeName,
  //       (route) => route.settings.name == WelcomePage.routeName);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        autovalidateMode:
            autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          children: [
            SizedBox(height: Get.height / 8),
            Align(
                alignment: Alignment.center,
                child: AuthHeadingText(S.of(context).login)),
            const SizedBox(height: 30),
            SvgPicture.asset(MyAssets.loginVector),

            const SizedBox(height: 30),

            const SizedBox(height: 20),
            TFLabelText("Email-ID / Roll No."),
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                _emailId = value.trim();
                return MyFormValidators.validateEmpty(value.trim());
              },
              decoration: MyDecorations.textFieldDecoration(context).copyWith(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: SvgPicture.asset(
                    MyAssets.mail,
                    color: Theme.of(context).brightness == Brightness.light
                        ? MyColors.lightTextColor
                        : MyColors.darkTextColor,
                  ),
                ),
                hintText: "Enter your Email-ID or Roll number",
              ),
            ),

            const SizedBox(height: 15),
            // TFLabelText(S.of(context).password),
            // TextFormField(
            //   obscureText: _isObscure ? false : true,
            //   textInputAction: TextInputAction.done,
            //   validator: (value) {
            //     _password = value.trim();
            //     return MyFormValidators.validatePassword(value.trim());
            //   },
            //   decoration: MyDecorations.textFieldDecoration(context).copyWith(
            //     hintText: S.of(context).enterYourPassword,
            //     prefixIcon: Padding(
            //       padding: const EdgeInsets.all(14.0),
            //       child: SvgPicture.asset(
            //         MyAssets.password,
            //         color: Theme.of(context).brightness == Brightness.light
            //             ? MyColors.lightTextColor
            //             : MyColors.darkTextColor,
            //       ),
            //     ),
            //     suffixIcon: IconButton(
            //         icon: Icon(
            //           _isObscure ? Icons.visibility : Icons.visibility_off,
            //           color: MyColors.labelColor,
            //         ),
            //         onPressed: () {
            //           setState(() {
            //             _isObscure = !_isObscure;
            //           });
            //         }),
            //   ),
            // ),
            // const SizedBox(height: 22),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: GestureDetector(
            //     onTap: () {
            //       FocusScope.of(context).requestFocus(FocusNode());
            //       Get.toNamed(ForgotPasswordPage.routeName);
            //     },
            //     child: Text(S.of(context).forgotPassword,
            //         style: TextStyle(
            //             color: MyColors.primaryBlue,
            //             fontWeight: FontWeight.w500)),
            //   ),
            // ),
            const SizedBox(height: 44),
            MyButton(
              key: _buttonKey,
              child: Text(S.of(context).signIn),
              onPressed: () async {
                try {
                  if (_formKey.currentState.validate()) {
                    print("$_emailId");
                    FocusScope.of(context).requestFocus(FocusNode());
                    _buttonKey.currentState.showLoader();
                    await requestOtp({"email": _emailId});
                    log("login msg,");
                    _buttonKey.currentState.hideLoader();
                    // SharedPreferenceHelper.storeUser(user: _tempDatum);
                    Get.toNamed(OTPPage.routeName, arguments: _emailId);
                    // checkUserLevel();
                  } else {
                    setState(() {
                      autoValidate = true;
                    });
                  }
                } catch (err) {
                  print(err.toString());
                  _buttonKey.currentState.hideLoader();
                  SnackBarHelper.show("ERROR", err?.toString());
                }
              },
              width: double.infinity,
            ),
            const SizedBox(height: 24),
            MyButton(
              color: Colors.white,
              onPressed: socialSignIn,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(MyAssets.google),
                  const SizedBox(width: 6),
                  const Flexible(
                      child: Text(
                    "Sign in with Google",
                    style: TextStyle(color: Colors.black),
                  )),
                ],
              ),
            ),
            // Center(
            //   child: RichText(
            //       text: TextSpan(
            //           text: S.of(context).newUser,
            //           style: TextStyle(
            //               color:
            //                   Theme.of(context).brightness == Brightness.light
            //                       ? MyColors.lightTextColor
            //                       : MyColors.darkTextColor,
            //               fontFamily: 'Poppins',
            //               fontWeight: FontWeight.w500,
            //               fontSize: 15),
            //           children: <TextSpan>[
            //         TextSpan(
            //             text: ' ' + S.of(context).registerHere,
            //             style: TextStyle(
            //               fontWeight: FontWeight.w700,
            //               fontSize: 15,
            //               color: MyColors.primaryBlue,
            //             ),
            //             recognizer: TapGestureRecognizer()
            //               ..onTap = () {
            //                 FocusScope.of(context).requestFocus(FocusNode());
            //                 Get.back();
            //                 Get.toNamed(SignUpPage.routeName);
            //               })
            //       ])),
            // )
          ],
        ),
      ),
    );
  }

  socialSignIn() async {
    Get.key.currentState?.push(LoaderOverlay());
    try {
      final res = await userLoginWithGoogle();
      if (res != null) {
        checkUserLevel();
      } else {
        Get.key.currentState?.pop();
      }
    } catch (err, s) {
      Get.key.currentState?.pop();
      log('socialSignIn $err $s');
      SnackBarHelper.show("Error", err.toString());
    }
  }
}
