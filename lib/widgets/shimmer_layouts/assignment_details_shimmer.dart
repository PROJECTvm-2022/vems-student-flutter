import 'package:flutter/material.dart';
import 'package:vems/pages/dashboard/pages/exams/widgets/exam_card.dart';
import 'package:shimmer/shimmer.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 08/07/21 at 10:26 am
///

class AssignmentDetailsShimmer extends StatelessWidget {
  final Axis scrollDirection;
  final int itemCount;

  const AssignmentDetailsShimmer({this.scrollDirection, this.itemCount});

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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Row(
              children: [
                Container(
                  height: 18,
                  width: 140,
                  color: Color(0xFFEBE8F4),
                ),
                Spacer(),
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
          Row(
            children: [
              Expanded(
                  child: Column(
                children: List.generate(
                  3,
                  (index) => Container(
                    height: 18,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    // width: double.infinity,
                    color: Color(0xFFEBE8F4),
                  ),
                ),
              )),
              SizedBox(width: 20),
              Expanded(
                  child: Column(
                children: List.generate(
                  3,
                  (index) => Container(
                    height: 18,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    // width: double.infinity,
                    color: Color(0xFFEBE8F4),
                  ),
                ),
              )),
            ],
          ),
          const SizedBox(height: 8),
          Divider(
            color: Color(0xFFEBE8F4),
            height: 0,
          ),
          const SizedBox(height: 16),
          ...List.generate(
            1,
            (index) => Container(
              height: 35,
              margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
              // width: double.infinity,
              color: Color(0xFFEBE8F4),
            ),
          ).toList(),
          const SizedBox(height: 16),
          Divider(
            color: Color(0xFFEBE8F4),
            height: 0,
          ),
          Container(
            height: 18,
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            width: 100,
            color: Color(0xFFEBE8F4),
          ),
          Container(
            height: 18,
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            width: 2100,
            color: Color(0xFFEBE8F4),
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            width: 2100,
            color: Color(0xFFEBE8F4),
          ),
          Divider(
            color: Color(0xFFEBE8F4),
            height: 0,
          ),
          const SizedBox(height: 16),
          Container(
            height: 18,
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            width: 200,
            color: Color(0xFFEBE8F4),
          ),
          ...List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(
                children: [
                  Dot(radius: 13),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 14,
                        width: 160,
                        color: Color(0xFFEBE8F4),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 14,
                        width: 100,
                        color: Color(0xFFEBE8F4),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ).toList(),
          Spacer(),
        ],
      ),
    );
  }
}
