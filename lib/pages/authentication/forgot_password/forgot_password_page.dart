import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vems/api_services/authentication_api_services.dart';
import 'package:vems/config/index.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/authentication/forgot_password/otp_page.dart';
import 'package:vems/pages/authentication/widgets/auth_text_widgets.dart';
import 'package:vems/utils/my_form_validators.dart';
import 'package:vems/utils/snackbar_helper.dart';
import 'package:vems/widgets/back_button.dart';
import 'package:vems/widgets/button.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 5/1/21 at 10:13 PM
///

class ForgotPasswordPage extends StatefulWidget {
  static final routeName = '/ForgotPasswordPage';

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String _emailId = '';
  final _formKey = GlobalKey<FormState>();
  final _buttonKey = GlobalKey<MyButtonState>();
  bool autoValidate = false;

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
        child: Stack(
          children: [
            Positioned.fill(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                children: [
                  const SizedBox(height: 15),
                  AuthHeadingText(S.of(context).forgotPassword),
                  const SizedBox(height: 35),
                  TFLabelText(
                      S.of(context).pleaseEnterYourAssociatedEmailIdToContinue),
                  TextFormField(
                    textInputAction: TextInputAction.done,
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
                child: Text(S.of(context).getOtp),
                width: double.infinity,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    _buttonKey.currentState.showLoader();
                    requestOtp({"target": "email", "email": _emailId})
                        .then((value) {
                      _buttonKey.currentState.hideLoader();
                      SnackBarHelper.show(S.of(context).otpSent,
                          'OTP sent successfully to $_emailId, if not found then please check the spam folder');
                      Future.delayed(Duration(milliseconds: 600)).then(
                        (value) =>
                            Get.toNamed(OTPPage.routeName, arguments: _emailId),
                      );
                    }).catchError((err) {
                      _buttonKey.currentState.hideLoader();
                      SnackBarHelper.show(S.of(context).error, err?.toString());
                    });
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
