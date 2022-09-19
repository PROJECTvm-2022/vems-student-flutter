import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vems/config/index.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 05/07/21 at 2:22 pm
///

class SheetTitle extends StatelessWidget {
  final String title;

  const SheetTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 5, 0, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          IconButton(
              icon: SvgPicture.asset(MyAssets.cross),
              onPressed: () => Get.back())
        ],
      ),
    );
  }
}
