///
/// Created by Auro (auro@smarttersstudio.com) on 15/06/21 at 8:12 PM
///

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class QuizResultShimmer extends StatelessWidget {
  final Axis scrollDirection;
  final int itemCount;

  const QuizResultShimmer({this.scrollDirection, this.itemCount});

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
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemBuilder: (ctx, index) => Container(
          height: 40,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
          // width: double.infinity,
          decoration: BoxDecoration(
              color: Color(0xFFEBE8F4), borderRadius: BorderRadius.circular(5)),
        ),
        itemCount: 16,
      ),
    );
  }
}
