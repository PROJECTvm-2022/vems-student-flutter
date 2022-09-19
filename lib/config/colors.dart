import 'dart:ui';

import 'package:flutter/material.dart';

///
/// Created By Guru (guru@smarttersstudio.com) on 12/06/20 11:48 AM
///

mixin MyColors {
  static final Color brightBackgroundColor = Color(0xffFFFFFF);
  static final Color darkBackgroundColor = Color(0xff373737);
  static final Color darkTextColor = Colors.white.withOpacity(0.87);
  static final Color lightTextColor = Color(0xff373737);
  static final Color primaryBlue = Color(0xFF118AB2);
  static final Color darkBlue = Color(0xff2F415E);
  static final Color grey = Color(0xff6A6A6A);
  static final Color labelColor = Color(0xffB2B6CA);
  static final Color fillGrey = Color(0xfff3f3f3);
  static final Color lightTFColor = Color(0xffF3F3F3);
  static final Color darkTFColor = Color(0xff272626);
  static final Color appBarTextColorLight = Color(0xff6A6A6A);
  static final Color hardGrey = Color(0xff9A9A9A);
  static final Color lightDividerColor = Color(0xffE6E7EF);
  static final Color f9Grey = Color(0xffF9F9F9);
  static final Color f8Grey = Color(0xffF8F8F8);
  static final Color borderGrey = Color(0xffDDDDDD);
  static final Color red = Color(0xffEA4335);
  static final Color green = Color(0xff4BBF57);
  static final Color scheduleRowGrey = Color(0xff818181);
  static final Color lightSky = Color(0xffBBD7FF);
  static final Color disabledHeading = Color(0xff939393);
  static final Color disabledFieldText = Color(0xffC2C2C2);
  static final Color questionCell = Color(0xffE0E0E0);
  static final Color answeredColor = Color(0xffE0E0E0);
  static final Color skippedColor = Color(0xffFFD9D6);
  static final Color notVisitedColor = Color(0xffEBF4FF);
  static final Color bodyGreyText = Color(0xff515151);
  static final Color activePanelBgColor = Color(0xffECF8FF);
  static final Color currentColor = brightPrimary;
  static final Color filterGrey = Color(0xffEEEEEE);
  static const dividerSlot = Color(0xffEAEAEA);
  static const primaryDark = Color(0xFF118AB2);
  static const parentDrawer = Color(0xFF118AB2);

  static final List<Color> homeTestColors = [
    Color(0xff29BCAD),
    Color(0xffFF951A),
    Color(0xff1A91FF),
    Color(0xff8D29BC),
  ];

  static const MaterialColor darkPrimary =
      MaterialColor(0xFF118AB2, <int, Color>{
    50: Color(0xFFE2F1F6),
    100: Color(0xFFB8DCE8),
    200: Color(0xFF88C5D9),
    300: Color(0xFF58ADC9),
    400: Color(0xFF359CBE),
    500: Color(0xFF118AB2),
    600: Color(0xFF0F82AB),
    700: Color(0xFF0C77A2),
    800: Color(0xFF0A6D99),
    900: Color(0xFF055A8A),
  });

  static const MaterialColor brightPrimary =
      MaterialColor(0xFF118AB2, <int, Color>{
    50: Color(0xFFE2F1F6),
    100: Color(0xFFB8DCE8),
    200: Color(0xFF88C5D9),
    300: Color(0xFF58ADC9),
    400: Color(0xFF359CBE),
    500: Color(0xFF118AB2),
    600: Color(0xFF0F82AB),
    700: Color(0xFF0C77A2),
    800: Color(0xFF0A6D99),
    900: Color(0xFF055A8A),
  });
}

LinearGradient getDynamicGradient(BuildContext context) {
  final ThemeData theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  if (colorScheme.brightness == Brightness.light) {
    return LinearGradient(
      colors: const [
        Color(0xff17EAD9),
        Color(0xFF6078EA),
      ],
    );
  } else {
    return LinearGradient(
      colors: const [
        const Color(0xffF42A83),
        const Color(0xff8E3FFC),
      ],
    );
  }
}
