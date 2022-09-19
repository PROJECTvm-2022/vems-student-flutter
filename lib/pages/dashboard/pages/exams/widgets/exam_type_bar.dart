import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vems/config/index.dart';
import 'package:vems/generated/l10n.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 2/4/21 at 9:02 AM
///

class ExamTypeBar extends StatelessWidget {
  final Function(bool r) onChanged;
  final bool isScheduledExams;

  const ExamTypeBar({Key key, this.onChanged, this.isScheduledExams = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {
                onChanged(true);
              },
              child: ExamTypeTitle(
                text: S.of(context).scheduledExams,
                isScheduledExams: isScheduledExams,
                icon: isScheduledExams
                    ? MyAssets.scheduledExamsEnable
                    : MyAssets.scheduledExamsDisabled,
              ),
            ),
          ),
          Container(
            width: 2,
            height: 30,
            color: MyColors.borderGrey,
          ),
          Expanded(
            child: TextButton(
              onPressed: () {
                onChanged(false);
              },
              child: ExamTypeTitle(
                text: S.of(context).completedExams,
                isScheduledExams: !isScheduledExams,
                icon: isScheduledExams
                    ? MyAssets.completedExamsDisabled
                    : MyAssets.completedExamsEnabled,
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: MyColors.borderGrey),
        ),
      ),
    );
  }
}

class ExamTypeTitle extends StatelessWidget {
  final String icon;
  final String text;
  final bool isScheduledExams;

  const ExamTypeTitle(
      {Key key, this.icon, this.text, this.isScheduledExams = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(icon ?? ''),
        const SizedBox(width: 6),
        Text(
          text ?? '',
          style: TextStyle(
            color:
                isScheduledExams ? Color(0xFF118AB2) : MyColors.disabledHeading,
          ),
        ),
      ],
    );
  }
}
