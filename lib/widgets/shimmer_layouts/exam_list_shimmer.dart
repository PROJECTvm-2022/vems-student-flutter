import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 22/4/21 at 11:20 AM
///

class ExamListShimmer extends StatelessWidget {
  final Axis scrollDirection;
  final int itemCount;

  const ExamListShimmer({this.scrollDirection, this.itemCount});

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
      child: scrollDirection == null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 18,
                      width: 145,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      color: Color(0xFFEBE8F4),
                    ),
                    Container(
                      height: 22,
                      width: 70,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 14),
                      color: Color(0xFFEBE8F4),
                    ),
                  ],
                ),
                SizedBox(
                  height: 145,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(left: 6),
                    itemCount: itemCount ?? 6,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) => Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 7.5, horizontal: 10),
                      width: 306,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Color(0xFFEBE8F4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            )
          : ListView.builder(
              itemCount: itemCount ?? 10,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemBuilder: (ctx, index) => Container(
                height: 124,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 7.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Color(0xFFEBE8F4),
                ),
              ),
            ),
    );
  }
}
