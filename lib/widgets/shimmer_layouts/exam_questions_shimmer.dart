import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vems/pages/dashboard/pages/exams/widgets/exam_card.dart';
import 'package:shimmer/shimmer.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 22/4/21 at 11:20 AM
///

class ExamQuestionsShimmer extends StatelessWidget {
  final Axis scrollDirection;
  final int itemCount;

  const ExamQuestionsShimmer({this.scrollDirection, this.itemCount});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Shimmer.fromColors(
      baseColor: brightness == Brightness.light
          ? Colors.grey.shade300
          : Colors.grey.shade800,
      highlightColor: brightness == Brightness.light
          ? Colors.grey.shade100
          : Colors.grey.shade600,
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Dot(radius: 16),
                const SizedBox(width: 5),
                Container(
                  height: 18,
                  width: 80,
                  color: Color(0xFFEBE8F4),
                ),
                Spacer(),
                Dot(radius: 16),
                const SizedBox(width: 5),
                Container(
                  height: 18,
                  width: 80,
                  color: Color(0xFFEBE8F4),
                ),
              ],
            ),
          ),
          Divider(
            color: Color(0xFFEBE8F4),
            height: 0,
          ),
          const SizedBox(height: 10),
          Container(
            height: 18,
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            width: double.infinity,
            color: Color(0xFFEBE8F4),
          ),
          Container(
            height: 18,
            margin: const EdgeInsets.fromLTRB(16, 6, 30, 6),
            width: double.infinity,
            color: Color(0xFFEBE8F4),
          ),
          Container(
            height: 18,
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            width: 100,
            color: Color(0xFFEBE8F4),
          ),
          ...List.generate(
            4,
            (index) => Container(
              height: 40,
              margin: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
              // width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xFFEBE8F4),
                  borderRadius: BorderRadius.circular(5)),
            ),
          ).toList(),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color(0xFFEBE8F4),
                        borderRadius: BorderRadius.circular(6)),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color(0xFFEBE8F4),
                        borderRadius: BorderRadius.circular(6)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
