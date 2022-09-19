import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vems/config/index.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 11/1/21 at 5:00 PM
///

class SheetTopBar extends StatelessWidget {
  final String primaryText;
  final String secondaryText;

  const SheetTopBar({Key key, this.primaryText = '', this.secondaryText = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => Get.back(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Row(
              children: [
                Text(
                  primaryText ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).brightness == Brightness.light
                        ? MyColors.lightTextColor
                        : Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                if (secondaryText?.isNotEmpty)
                  Text(
                    secondaryText,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                Spacer(),
                RotatedBox(
                  quarterTurns: 2,
                  child: SvgPicture.asset(MyAssets.dropDown),
                )
              ],
            ),
          ),
        ),
        Divider(
          height: 22,
          thickness: 1,
          endIndent: 16,
          indent: 16,
          color: Theme.of(context).brightness == Brightness.dark
              ? MyColors.grey
              : MyColors.lightDividerColor,
        )
      ],
    );
  }
}
