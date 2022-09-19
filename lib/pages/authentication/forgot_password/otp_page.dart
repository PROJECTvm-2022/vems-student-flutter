import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vems/api_services/authentication_api_services.dart';
import 'package:vems/config/colors.dart';
import 'package:vems/config/functions.dart';
import 'package:vems/data_models/user.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/authentication/widgets/auth_text_widgets.dart';
import 'package:vems/pages/dashboard/pages/exams/exams_page.dart';
import 'package:vems/utils/shared_preference_helper.dart';
import 'package:vems/utils/snackbar_helper.dart';
import 'package:vems/widgets/back_button.dart';
import 'package:vems/widgets/button.dart';
import 'package:vems/widgets/pin_textfield.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 5/1/21 at 10:18 PM
///

class OTPPage extends StatefulWidget {
  static final routeName = '/OTPPage';

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  String _pin = '', _email = '';
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
    requestOtp({"target": "email", "email": _email}).then((value) {
      SnackBarHelper.show(S.of(context).otpSent, value);
    }).catchError((err) {
      SnackBarHelper.show(S.of(context).error, err?.toString());
    });
    Future.delayed(const Duration(seconds: 60),
        () => setState(() => _isResendActive = true));
  }

  _verifyOTP() {
    if (!_pin.isBlank) {
      _buttonKey.currentState.showLoader();
      verifyEmailOtp({"email": _email, "otp": _pin}).then((token) {
        _buttonKey.currentState.hideLoader();

        SharedPreferenceHelper.storeAccessToken(token["accessToken"]);
        SharedPreferenceHelper.storeUser(
            user: UserDatum.fromJson(token["user"]));
        Get.offAllNamed(ExamsPage.routeName);
      }).catchError((err) {
        _buttonKey.currentState.hideLoader();
        SnackBarHelper.show(S.of(context).error, err?.toString());
      });
    }
  }

  @override
  void initState() {
    _email = Get.arguments ?? '';
    _startTimer();
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
                AuthHeadingText(S.of(context).verifyOtp),
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
                          // text: ' ' + "${obscuredMail(_email)}",
                          text: ' ' + "$_email",
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
                  textStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  enableEmptyColor:
                      Theme.of(context).brightness == Brightness.light
                          ? MyColors.lightTFColor
                          : MyColors.darkTFColor,
                  enableFillColor:
                      Theme.of(context).brightness == Brightness.light
                          ? MyColors.lightTFColor
                          : MyColors.darkTFColor,
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
