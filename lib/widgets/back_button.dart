import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vems/config/assets.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 5/1/21 at 11:11 AM
///

class MyBackButton extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;

  const MyBackButton({Key key, this.color, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: SvgPicture.asset(
          MyAssets.backArrow,
          color: color != null
              ? color
              : Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Color(0xff6A6A6A),
        ),
        onPressed: onTap ??
            () {
              Get.back();
            });
  }
}
