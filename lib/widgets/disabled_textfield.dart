import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vems/config/index.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 4/3/21 at 9:41 AM
///

class DisabledTextField extends StatelessWidget {
  final String label;
  final String asset;
  final String value;
  final Widget trailingWidget;
  final double vPadding;
  final TextStyle textStyle;

  const DisabledTextField({
    Key key,
    this.label,
    this.asset,
    this.value,
    this.trailingWidget,
    this.vPadding,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label ?? '',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: MyColors.labelColor),
          ),
          const SizedBox(height: 6),
          Container(
            padding: EdgeInsets.only(
                left: 16, top: vPadding ?? 0, bottom: vPadding ?? 0),
            child: Row(
              children: [
                SvgPicture.asset(asset ?? ''),
                const SizedBox(width: 10),
                Text(
                  value ?? '',
                  style: textStyle ??
                      TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Spacer(),
                if (trailingWidget != null) trailingWidget
              ],
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? MyColors.lightTFColor
                    : MyColors.darkTFColor,
                borderRadius: BorderRadius.circular(6)),
          ),
        ],
      ),
    );
  }
}
