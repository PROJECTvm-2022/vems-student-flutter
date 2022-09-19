import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vems/config/functions.dart';
import 'package:vems/config/index.dart';
import 'package:intl/intl.dart';
import 'package:vems/data_models/student_exam_datum.dart';
import 'package:vems/pages/dashboard/pages/exams/widgets/exam_card.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 14/4/21 at 2:37 PM
///

class HomeExamCard extends StatelessWidget {
  final int index;
  final StudentExamDatum datum;
  final VoidCallback onTap;

  const HomeExamCard({Key key, this.index = 0, this.datum, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Container(
      width: width * 0.85,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.fromLTRB(10, 4, 10, 7.5),
      child: InkWell(
        borderRadius: BorderRadius.circular(3),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 16, 14, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "${datum.exam?.title}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  // Container(
                  //   padding:
                  //       const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                  //   child: Text(
                  //     "${datum.exam.subject.name}",
                  //     style: TextStyle(
                  //         color: MyColors.homeTestColors[index % 4],
                  //         fontSize: 12),
                  //   ),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(3),
                  //   ),
                  // ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            //   child: Text(
            //     "${datum.exam.course.name}",
            //     style: TextStyle(
            //       fontSize: 12,
            //       color: Theme.of(context).brightness == Brightness.light
            //           ? MyColors.grey
            //           : Colors.white.withOpacity(0.6),
            //     ),
            //   ),
            // ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              child: Row(
                children: [
                  IconText(
                    icon: MyAssets.questionMarkGrey,
                    text: '${datum.exam?.questionCount} Questions',
                    color: Colors.white,
                  ),
                  Expanded(child: Dot(color: Colors.white)),
                  IconText(
                    text: datum.exam == null
                        ? ''
                        : '${countDownTimeFormatFromSeconds(datum.exam.duration * 60, isHrMin: true)}',
                    icon: MyAssets.clockGrey,
                    color: Colors.white,
                  ),
                  Expanded(child: Dot(color: Colors.white)),
                  IconText(
                    text: datum.exam == null
                        ? ''
                        : DateFormat('dd.MM.yyyy')
                            .format(datum.exam?.scheduledOn),
                    icon: MyAssets.calenderGrey,
                    color: Colors.white,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: MyColors.homeTestColors[index % 4],
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: MyColors.homeTestColors[index % 4].withOpacity(0.3),
      ),
    );
  }
}
