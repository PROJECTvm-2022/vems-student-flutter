import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vems/api_services/authentication_api_services.dart';
import 'package:vems/data_models/user.dart';
import 'package:vems/pages/authentication/signup/signup_page.dart';
import 'package:vems/pages/authentication/widgets/auth_text_widgets.dart';
import 'package:vems/utils/auth_helper.dart';
import 'package:vems/utils/shared_preference_helper.dart';
import 'package:vems/utils/snackbar_helper.dart';
import 'package:vems/widgets/back_button.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vems/config/colors.dart';
import 'package:vems/config/functions.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/widgets/button.dart';
import 'package:vems/widgets/pin_textfield.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 6/1/21 at 10:12 PM
///

class VerifyEmailPage extends StatefulWidget {
  static final routeName = '/VerifyEmailPage';

  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  String _pin = '', _email = '', _phone = '';
  final _buttonKey = GlobalKey<MyButtonState>();
  bool _isResendActive = false;
  Timer _timer;
  int _timerCounter = 60;

  ///Timer
  void _startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(
          () {
            if (_timerCounter < 1) {
              timer.cancel();
            } else {
              _timerCounter = _timerCounter - 1;
            }
          },
        );
      },
    );
  }

  _regenerateOTP() {
    _timer.cancel();
    setState(() {
      _isResendActive = false;
      _timerCounter = 60;
    });
    _startTimer();
    _requestOtp();
    Future.delayed(const Duration(seconds: 60),
        () => setState(() => _isResendActive = true));
  }

  _verifyOTP() async {
    if (!_pin.isBlank) {
      try {
        _buttonKey.currentState.showLoader();

        await verifyEmail(_email, _pin);
        _buttonKey.currentState.hideLoader();
        SharedPreferenceHelper.setFirstTime(false);
        SnackBarHelper.show(
            S.of(context).success, S.of(context).emailVerifiedSuccessfully);
        UserDatum user = SharedPreferenceHelper.user;

        user.emailVerified = true;

        SharedPreferenceHelper.storeUser(user: user);
        checkUserLevel();
      } catch (err) {
        _buttonKey.currentState.hideLoader();
        SnackBarHelper.show(S.of(context).error, err?.toString());
      }
    }
  }

  _requestOtp() {
    requestOtp({
      "verification": true,
      "email": _email,
    }).then((value) {
      SnackBarHelper.show(S.of(context).otpSent, value);
    }).catchError((err) {
      SnackBarHelper.show(S.of(context).error, err?.toString());
    });
  }

  @override
  void initState() {
    _email = SharedPreferenceHelper.user.email;
    _phone = SharedPreferenceHelper.user.phone;
    _startTimer();
    _requestOtp();
    Future.delayed(const Duration(seconds: 60), () => _isResendActive = true);
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MyBackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              children: [
                const SizedBox(height: 15),
                AuthHeadingText("Verify your email"),
                const SizedBox(height: 35),
                RichText(
                  text: TextSpan(
                      text:
                          S.of(context).pleaseEnterTheOtpThatHasBeenSentToYour,
                      style: TextStyle(
                          color: MyColors.labelColor,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ' + "${obscuredMail(_email)}",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? MyColors.darkBlue
                                    : Colors.white,
                          ),
                        )
                      ]),
                ),
                const SizedBox(height: 35),
                TFLabelText('Enter OTP'),
                const SizedBox(height: 5),
                PinCodeTextField(
                  length: 6,
                  borderRadius: BorderRadius.circular(6),
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  onChanged: (str) => setState(() => _pin = str.trim()),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textInputType: TextInputType.number,
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                  enableEmptyColor: MyColors.fillGrey,
                  enableFillColor: MyColors.fillGrey,
                  autoFocus: true,
                  onCompleted: (pin) {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    _verifyOTP();
                  },
                ),
                const SizedBox(height: 35),
                Center(
                  child: Text(
                      "${getDurationInMinutesAndSeconds(Duration(seconds: _timerCounter))}",
                      style: TextStyle(fontSize: 18, color: Colors.grey)),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (_isResendActive) {
                        _regenerateOTP();
                      }
                    },
                    child: Text(
                      S.of(context).resendCode,
                      style: TextStyle(
                          color: _isResendActive
                              ? MyColors.primaryBlue
                              : Color(0xffc7c7c7),
                          fontWeight: FontWeight.w700,
                          fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                Center(
                  child: RichText(
                      text: TextSpan(
                          text: "Not your email id?",
                          style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? MyColors.lightTextColor.withOpacity(0.6)
                                  : MyColors.darkTextColor,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                          children: <TextSpan>[
                        TextSpan(
                            text: ' ' + "Change here",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: MyColors.primaryBlue,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                SharedPreferenceHelper.logOut();
                                Get.offAllNamed(SignUpPage.routeName);
                              })
                      ])),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 25,
            right: 16,
            left: 16,
            child: MyButton(
              key: _buttonKey,
              child: Text(S.of(context).verify),
              width: double.infinity,
              onPressed: _pin.length < 6
                  ? null
                  : () {
                      _verifyOTP();
                    },
            ),
          ),
        ],
      ),
    );
  }
}
