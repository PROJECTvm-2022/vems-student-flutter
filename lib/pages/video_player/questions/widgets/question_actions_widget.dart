import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vems/config/index.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/widgets/button.dart';
import 'package:vems/widgets/outlined_button.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 14/1/21 at 8:49 PM
///

class QuestionActionsWidget extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onNext;
  final bool isOnlyFinish;
  final bool isOnlyNext;

  const QuestionActionsWidget(
      {Key key,
      this.onBack,
      this.onNext,
      this.isOnlyFinish = false,
      this.isOnlyNext = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!isOnlyNext)
          Container(
            decoration: BoxDecoration(
              color: Get.theme.canvasColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: MyOutlineButton(
              height: 44,
              width: 94,
              text: S.of(context).back,
              textStyle: TextStyle(
                fontSize: 16,
                color: MyColors.primaryBlue,
              ),
              onPressed: onBack,
              border: BorderSide(color: MyColors.primaryBlue),
            ),
          ),
        Spacer(),
        if (!isOnlyNext) const SizedBox(width: 10),
        SizedBox(
          width: 94,
          child: MyButton(
            height: 44,
            child: Text(isOnlyFinish ? "Finish" : S.of(context).next),
            onPressed: onNext,
          ),
        )
      ],
    );
  }
}
