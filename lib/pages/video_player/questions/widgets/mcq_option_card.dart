import 'package:flutter/material.dart';
import 'package:vems/config/index.dart';
import 'package:vems/pages/exams/widgets/html_view.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 14/1/21 at 7:23 PM
///

class MCQOptionCard extends StatelessWidget {
  final String name;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isExam;

  const MCQOptionCard(
      {Key key,
      this.name,
      this.isSelected = false,
      this.onTap,
      this.isExam = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _foregroundColor;
    Color _backgroundColor;
    if (isSelected) {
      _foregroundColor = isExam ? Colors.white : MyColors.primaryBlue;
      _backgroundColor =
          isExam ? MyColors.primaryBlue : MyColors.primaryBlue.withOpacity(0.1);
    } else {
      _foregroundColor = Theme.of(context).brightness == Brightness.light
          ? MyColors.lightTextColor
          : Colors.white.withOpacity(0.8);
      _backgroundColor = Theme.of(context).brightness == Brightness.light
          ? MyColors.lightTFColor
          : MyColors.darkTFColor;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: HtmlView(name, color: _foregroundColor),
        // child: Row(
        //   children: [
        //     Expanded(
        //       child: Text(
        //         name ?? '',
        //         style: TextStyle(
        //           color: _foregroundColor,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(5),
          // border: Border.all(
          //   color: _foregroundColor.withOpacity(0.2),
          // ),
        ),
      ),
    );
  }
}
