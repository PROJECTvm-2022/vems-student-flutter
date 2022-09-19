import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vems/config/index.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 4/4/21 at 10:03 AM
///

class ExamScoreCard extends StatelessWidget {
  final String title;
  final String value;
  final String asset;

  const ExamScoreCard({Key key, this.title, this.value, this.asset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            height: 33,
            width: 33,
            padding: const EdgeInsets.all(6),
            child: SvgPicture.asset(asset ?? ''),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: MyDecorations.examScoreGradient,
            ),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? '',
                  style: TextStyle(
                    fontSize: 11,
                    color: Theme.of(context).brightness == Brightness.light
                        ? MyColors.grey
                        : MyColors.darkTextColor.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Theme.of(context).brightness == Brightness.light
                          ? MyColors.lightTextColor
                          : MyColors.darkTextColor),
                ),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? MyColors.fillGrey
              : MyColors.darkTFColor,
          borderRadius: BorderRadius.circular(6)),
    );
  }
}
