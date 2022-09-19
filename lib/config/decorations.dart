import 'package:flutter/material.dart';
import 'package:vems/config/index.dart';

///
/// Created By Guru (guru@smarttersstudio.com) on 12/06/20 11:51 AM
///
mixin MyDecorations {
  static InputDecoration textFieldDecoration(BuildContext context,
      {double radius, bool filled = true}) {
    return InputDecoration(
        fillColor: Theme.of(context).brightness == Brightness.light
            ? MyColors.lightTFColor
            : MyColors.darkTFColor,
        filled: filled,
        counterText: '',
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
        contentPadding: EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 16.0),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 8),
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? filled
                      ? MyColors.darkTFColor
                      : MyColors.lightTFColor
                  : MyColors.lightTFColor,
              width: filled ? 3.0 : 2,
            )),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 8),
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? filled
                      ? MyColors.darkTFColor
                      : MyColors.lightTFColor
                  : MyColors.lightTFColor,
              width: filled ? 3.0 : 2,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 8),
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? filled
                      ? MyColors.darkTFColor
                      : MyColors.lightTFColor
                  : MyColors.lightTFColor,
              width: filled ? 3.0 : 2,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 8),
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? filled
                      ? MyColors.darkTFColor
                      : MyColors.lightTFColor
                  : MyColors.lightTFColor,
              width: filled ? 3.0 : 2,
            ))).copyWith();
  }

  static List<LinearGradient> myGradients = [
    LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xffFF7C1D).withOpacity(0.65),
        Color(0xffFFC91D).withOpacity(0.65),
      ],
    ),
    LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xffFF395D).withOpacity(0.65),
        Color(0xffFF8024).withOpacity(0.65),
      ],
    ),
    LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xff037FFB).withOpacity(0.65),
        Color(0xff03FBEC).withOpacity(0.65),
      ],
    ),
    LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xff45BA51).withOpacity(0.65),
        Color(0xffC5BE2C).withOpacity(0.65),
      ],
    ),
    LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xffD7608B).withOpacity(0.65),
        Color(0xffDA4FDD).withOpacity(0.65),
      ],
    ),
    LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xff3FB9FD).withOpacity(0.65),
        Color(0xff3FFDFD).withOpacity(0.65),
        Color(0xff32C6C6).withOpacity(0.65),
      ],
    ),
    LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xffF66BF9).withOpacity(0.65),
        Color(0xffF0D12B).withOpacity(0.65),
      ],
    ),
  ];

  static LinearGradient profileGradient = LinearGradient(
    colors: [
      Color(0xFF118AB2),
      Color(0xff28BFFF),
    ],
  );

  static LinearGradient lectureTagGradient = LinearGradient(
    colors: [
      Color(0xffEA4335),
      Color(0xffFF8770),
    ],
  );

  static LinearGradient examTagGradient = LinearGradient(
    colors: [
      Color(0xff4BBF57),
      Color(0xff96D9C9),
    ],
  );

  static LinearGradient examAppBarGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xFF118AB2),
      Color(0xFFAD9FD3),
    ],
  );

  static LinearGradient examScoreGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF118AB2),
      Color(0xFFAD9FD3),
    ],
  );

  static LinearGradient morningGradient(BuildContext context) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF118AB2),
        Theme.of(context).brightness == Brightness.light
            ? Color(0xffFFFFFF)
            : MyColors.darkBackgroundColor,
      ],
    );
  }

  static LinearGradient afternoonGradient(BuildContext context) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF118AB2),
        Theme.of(context).brightness == Brightness.light
            ? Color(0xffFFFFFF)
            : MyColors.darkBackgroundColor,
      ],
    );
  }

  static LinearGradient eveningGradient(BuildContext context) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xffEC6E13),
        Theme.of(context).brightness == Brightness.light
            ? Color(0xffFFFFFF)
            : MyColors.darkBackgroundColor,
      ],
    );
  }

  static LinearGradient nightGradient(BuildContext context) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xff393939),
        Theme.of(context).brightness == Brightness.light
            ? Color(0xffFFFFFF)
            : MyColors.darkBackgroundColor,
      ],
    );
  }

  static TextStyle videoDescStyle =
      TextStyle(fontSize: 12, color: MyColors.grey);

  static TextStyle commentTitle(BuildContext context) => TextStyle(
        fontSize: 12,
        color: Theme.of(context).brightness == Brightness.light
            ? Color(0xff6A6A6A)
            : Colors.white.withOpacity(0.7),
      );
}
