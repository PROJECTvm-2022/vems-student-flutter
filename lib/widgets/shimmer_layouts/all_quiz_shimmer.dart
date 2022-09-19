import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 4/5/21 at 8:18 AM
///

class AllQuizShimmer extends StatelessWidget {
  final Axis scrollDirection;
  final int itemCount;

  const AllQuizShimmer({this.scrollDirection, this.itemCount});

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
      child: ListView.builder(
        itemBuilder: (ctx, index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 18,
                        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        color: Color(0xFFEBE8F4),
                      ),
                      Container(
                        height: 18,
                        margin: const EdgeInsets.fromLTRB(16, 6, 30, 6),
                        color: Color(0xFFEBE8F4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
            ...List.generate(
              4,
              (index) => Container(
                height: 40,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                // width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xFFEBE8F4),
                    borderRadius: BorderRadius.circular(5)),
              ),
            ).toList(),
          ],
        ),
        itemCount: 6,
      ),
    );
  }
}
