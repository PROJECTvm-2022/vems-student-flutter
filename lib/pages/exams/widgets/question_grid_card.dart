import 'package:flutter/material.dart';
import 'package:vems/config/colors.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 3/4/21 at 9:57 AM
///

class QuestionGridCard extends StatelessWidget {
  final bool isCurrentQuestion;
  final int index;
  final VoidCallback onTap;
  final int colorIndex;

  const QuestionGridCard(
      {Key key,
      this.isCurrentQuestion = false,
      this.index,
      this.onTap,
      this.colorIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notVisitedColor = Colors.grey[400];
    final skippedColor = Colors.redAccent;
    final answeredColor = MyColors.green;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          "Q.${(index + 1)}",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: isCurrentQuestion ? Colors.white : Colors.black,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: isCurrentQuestion
              ? MyColors.brightPrimary
              : (colorIndex == 0
                  ? notVisitedColor
                  : colorIndex == 1
                      ? skippedColor
                      : answeredColor),
        ),
      ),
    );
  }
}
