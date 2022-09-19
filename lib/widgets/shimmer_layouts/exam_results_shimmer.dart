import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 22/4/21 at 11:20 AM
///

class ExamResultsShimmer extends StatelessWidget {
  final Axis scrollDirection;
  final int itemCount;

  const ExamResultsShimmer({this.scrollDirection, this.itemCount});

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
          Container(
            height: 56,
            width: double.infinity,
            color: Color(0xFFEBE8F4),
          ),
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
          Container(
            height: 18,
            margin: const EdgeInsets.fromLTRB(16, 5, 16, 10),
            width: 150,
            color: Color(0xFFEBE8F4),
          ),
          Container(
            height: 35,
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            width: 100,
            color: Color(0xFFEBE8F4),
          ),
          Divider(
            color: Color(0xFFEBE8F4),
            height: 0,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 10),
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 16,
                    margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                    width: 100,
                    color: Color(0xFFEBE8F4),
                  ),
                ),
                ...List.generate(
                  4,
                  (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 18,
                        margin: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                        width: double.infinity,
                        color: Color(0xFFEBE8F4),
                      ),
                      Container(
                        height: 18,
                        margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                        width: 100,
                        color: Color(0xFFEBE8F4),
                      ),
                      Container(
                        height: 40,
                        margin: const EdgeInsets.symmetric(
                            vertical: 9, horizontal: 16),
                        // width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xFFEBE8F4),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ],
                  ),
                ).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
