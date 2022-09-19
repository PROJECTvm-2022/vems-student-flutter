import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 22/4/21 at 10:21 PM
///

class FAQShimmer extends StatelessWidget {
  final Axis scrollDirection;
  final int itemCount;

  const FAQShimmer({this.scrollDirection, this.itemCount});

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
        itemCount: itemCount ?? 18,
        itemBuilder: (ctx, index) => Container(
          height: 52,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Color(0xFFEBE8F4),
          ),
        ),
      ),
    );
  }
}
