import 'package:get/get.dart';
import 'package:vems/config/colors.dart';
import 'package:flutter/material.dart';

///
/// Created By Guru (guru@smarttersstudio.com) on 12/06/20 11:52 AM
///

mixin MyThemes {
  static final lightThemeData = ThemeData(
      fontFamily: "Poppins",
      primarySwatch: MyColors.brightPrimary,
      primaryColor: MyColors.brightPrimary,
      accentColor: MyColors.brightPrimary,
      canvasColor: MyColors.brightBackgroundColor,
      cursorColor: MyColors.brightPrimary,
      iconTheme: IconThemeData(color: Colors.black),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: MyColors.brightBackgroundColor,
      brightness: Brightness.light,
      textSelectionHandleColor: MyColors.brightPrimary,
      textSelectionColor: MyColors.brightPrimary.withOpacity(0.3));

  static final darkThemeData = ThemeData(
      fontFamily: "Poppins",
      primarySwatch: MyColors.darkPrimary,
      primaryColor: MyColors.darkPrimary,
      accentColor: MyColors.darkPrimary,
      canvasColor: MyColors.darkBackgroundColor,
      cursorColor: MyColors.darkPrimary,
      iconTheme: IconThemeData(color: Colors.white),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: MyColors.darkBackgroundColor,
      brightness: Brightness.dark,
      textSelectionHandleColor: MyColors.darkPrimary,
      textSelectionColor: MyColors.darkPrimary.withOpacity(0.3));
}

enum ColorThemes { red }
