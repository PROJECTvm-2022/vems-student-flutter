import 'package:flutter/material.dart';
import 'package:vems/config/colors.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 05/07/21 at 5:47 pm
///

class MyDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 0,
      thickness: 1,
      color: MyColors.dividerSlot,
    );
  }
}
