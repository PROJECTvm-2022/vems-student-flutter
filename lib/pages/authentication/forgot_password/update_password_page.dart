import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vems/api_services/authentication_api_services.dart';
import 'package:vems/config/index.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/authentication/widgets/auth_text_widgets.dart';
import 'package:vems/utils/my_form_validators.dart';
import 'package:vems/utils/snackbar_helper.dart';
import 'package:vems/widgets/back_button.dart';
import 'package:vems/widgets/button.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 5/1/21 at 10:21 PM
///

class UpdatePasswordPage extends StatefulWidget {
  static final routeName = '/UpdatePasswordPage';

  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _buttonKey = GlobalKey<MyButtonState>();
  bool _isObscure = false;
  String _password = '', _confirmPassword = '', _token = '';
  bool autoValidate = false;

  @override
  void initState() {
    _token = Get.arguments ?? '';
    super.initState();
  }

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
                  AuthHeadingText(S.of(context).changePassword),
                  const SizedBox(height: 35),
                  TFLabelText("Enter new password"),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    obscureText: _isObscure ? false : true,
                    validator: (value) {
                      _password = value.trim();
                      return MyFormValidators.validatePassword(value.trim());
                    },
                    decoration:
                        MyDecorations.textFieldDecoration(context).copyWith(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: SvgPicture.asset(
                          MyAssets.password,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? MyColors.lightTextColor
                                  : MyColors.darkTextColor,
                        ),
                      ),
                      hintText: S.of(context).enterYourPassword,
                      suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: MyColors.labelColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TFLabelText("Confirm password"),
                  TextFormField(
                    obscureText: _isObscure ? false : true,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      _confirmPassword = value;
                      String errMsg = MyFormValidators.validatePassword(value);
                      if (errMsg != null) {
                        return errMsg;
                      } else if (_password != _confirmPassword) {
                        return "Password doesn't match";
                      } else {
                        return errMsg;
                      }
                    },
                    decoration:
                        MyDecorations.textFieldDecoration(context).copyWith(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: SvgPicture.asset(
                          MyAssets.password,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? MyColors.lightTextColor
                                  : MyColors.darkTextColor,
                        ),
                      ),
                      hintText: S.of(context).confirmYourPassword,
                      suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: MyColors.labelColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
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
                child: Text(S.of(context).changePassword),
                width: double.infinity,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    _buttonKey.currentState.showLoader();
                    resetPassword(
                      token: _token,
                      password: _password,
                      confirmPassword: _confirmPassword,
                    ).then((value) {
                      _buttonKey.currentState.hideLoader();
                      SnackBarHelper.show(S.of(context).success,
                          S.of(context).passwordUpdatedSuccessfully);
                      Future.delayed(Duration(milliseconds: 200)).then((value) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
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
