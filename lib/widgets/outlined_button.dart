import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vems/config/index.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 5/1/21 at 12:53 AM
///

class MyOutlineButton extends StatelessWidget {
  final double height;
  final double width;
  final VoidCallback onPressed;
  final String text;
  final TextStyle textStyle;
  final ShapeBorder shape;
  final BorderSide border;

  MyOutlineButton(
      {this.height = 40,
      this.width,
      @required this.onPressed,
      this.text = 'Back',
      this.textStyle,
      this.border,
      this.shape});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 40,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: border ??
              BorderSide(
                  color: Theme.of(context).brightness == Brightness.light
                      ? MyColors.grey
                      : MyColors.darkTextColor),
          shape: shape ??
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side: BorderSide(color: MyColors.primaryBlue)),
        ),
        child: Text(
          '$text',
          style: textStyle ??
              TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? MyColors.darkTextColor
                      : MyColors.grey),
        ),
      ),
    );
  }
}

class MyOutlineIconButton extends StatelessWidget {
  final double height;
  final double width;
  final VoidCallback onPressed;
  final String text;
  final TextStyle textStyle;
  final ShapeBorder shape;
  final BorderSide border;
  final String icon;

  MyOutlineIconButton(
      {this.height = 40,
      this.width,
      @required this.onPressed,
      this.text = 'Back',
      this.textStyle,
      this.border,
      @required this.icon,
      this.shape});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 40,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: border ??
              BorderSide(
                  color: Theme.of(context).brightness == Brightness.light
                      ? MyColors.grey
                      : MyColors.darkTextColor),
          shape: shape ??
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side: BorderSide(color: MyColors.primaryBlue)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: 16,
              width: 16,
              color: Theme.of(context).brightness == Brightness.dark
                  ? MyColors.darkTextColor
                  : MyColors.grey,
            ),
            const SizedBox(width: 13),
            Text(
              '$text',
              style: textStyle ??
                  TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? MyColors.darkTextColor
                          : MyColors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
