import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vems/config/index.dart';
import 'package:vems/data_models/exam_datum.dart';
import 'package:vems/pages/dashboard/pages/exams/widgets/exam_card.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 2/4/21 at 9:00 PM
///

class ExamAppBarContent extends StatelessWidget {
  final ExamDatum examDatum;
  final VoidCallback onBack;

  const ExamAppBarContent({Key key, this.examDatum, this.onBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.centerLeft,
      child: SafeArea(
        child: Row(
          children: [
            BackButton(
                color: Colors.white, onPressed: onBack ?? () => Get.back()),
            examDatum == null
                ? SizedBox()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${examDatum?.title}",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      // Row(
                      //   children: [
                      //     Text("${examDatum.subject?.name}",
                      //         style:
                      //             TextStyle(fontSize: 12, color: Colors.white)),
                      //     const SizedBox(width: 6),
                      //     Dot(color: Colors.white),
                      //     const SizedBox(width: 6),
                      //     Text("${examDatum.course?.name}",
                      //         style: TextStyle(fontSize: 12, color: Colors.white))
                      //   ],
                      // )
                    ],
                  )
          ],
        ),
      ),
      decoration: BoxDecoration(
        gradient: MyDecorations.examAppBarGradient,
      ),
    );
  }
}
