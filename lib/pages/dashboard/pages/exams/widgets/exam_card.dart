import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vems/config/functions.dart';
import 'package:vems/config/index.dart';
import 'package:intl/intl.dart';
import 'package:vems/data_models/student_exam_datum.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 2/4/21 at 8:32 AM
///

class ExamCard extends StatelessWidget {
  final VoidCallback onTap;
  final StudentExamDatum datum;

  const ExamCard({Key key, this.onTap, this.datum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.5),
      child: InkWell(
        borderRadius: BorderRadius.circular(3),
        onTap: onTap,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${datum.exam?.title}",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      // Container(
                      //   padding: const EdgeInsets.symmetric(
                      //       vertical: 4, horizontal: 6),
                      //   child: Text(
                      //     "${datum.exam.subject.name ?? ''}",
                      //     style: TextStyle(
                      //         color: MyColors.brightPrimary, fontSize: 12),
                      //   ),
                      //   decoration: BoxDecoration(
                      //     color: MyColors.brightPrimary.withOpacity(0.2),
                      //     borderRadius: BorderRadius.circular(3),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Row(
                  //   children: [
                  //     Spacer(),
                  // Expanded(
                  //   child: Text(
                  //     "${datum.exam.course.name ?? ''}",
                  //     style: TextStyle(
                  //       fontSize: 12,
                  //       color: MyColors.hardGrey,
                  //     ),
                  //   ),
                  // ),
                  // if (datum?.status == 4)
                  //   Text(
                  //     "Score : ${datum.mark}/${datum.exam.mark.total}",
                  //     style: TextStyle(
                  //       fontSize: 12,
                  //     ),
                  //   )
                  // ],
                  // ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Row(
                children: [
                  IconText(
                    text: datum.exam == null
                        ? ''
                        : DateFormat('dd.MM.yyyy')
                            .format(datum.exam?.scheduledOn),
                    icon: MyAssets.calenderGrey,
                  ),
                  Expanded(child: Dot()),
                  IconText(
                    icon: MyAssets.questionMarkGrey,
                    text:
                        '${DateFormat('hh:mm a').format(datum.exam?.scheduledOn)}',
                  ),
                  Expanded(child: Dot()),
                  IconText(
                    text: datum.exam == null
                        ? ''
                        : '${countDownTimeFormatFromSeconds(datum.exam.duration * 60, isHrMin: true)}',
                    icon: MyAssets.clockGrey,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? MyColors.f8Grey
                    : MyColors.darkTFColor,
                border: Border(
                    top: BorderSide(
                        color: Theme.of(context).brightness == Brightness.light
                            ? MyColors.borderGrey
                            : MyColors.borderGrey.withOpacity(0.3))),
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
            color: Theme.of(context).brightness == Brightness.light
                ? MyColors.borderGrey
                : MyColors.borderGrey.withOpacity(0.3)),
      ),
    );
  }
}

class IconText extends StatelessWidget {
  final String text;
  final String icon;
  final Color color;

  const IconText({Key key, this.text, this.icon, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(icon ?? '', color: color ?? MyColors.hardGrey),
        const SizedBox(width: 4),
        Text(
          text ?? '',
          style: TextStyle(
            color: color ?? MyColors.hardGrey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class Dot extends StatelessWidget {
  final Color color;
  final double radius;

  const Dot({Key key, this.color, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius ?? 3,
      width: radius ?? 3,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color ?? MyColors.hardGrey,
      ),
    );
  }
}
