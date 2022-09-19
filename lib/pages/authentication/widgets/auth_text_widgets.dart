import 'package:flutter/material.dart';
import 'package:vems/config/index.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 5/1/21 at 12:05 PM
///

class TFLabelText extends StatelessWidget {
  final String text;

  const TFLabelText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(text,
          style: TextStyle(
              fontSize: 12,
              color: MyColors.labelColor,
              fontWeight: FontWeight.w500)),
    );
  }
}

class AuthHeadingText extends StatelessWidget {
  final String text;

  const AuthHeadingText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700));
  }
}
