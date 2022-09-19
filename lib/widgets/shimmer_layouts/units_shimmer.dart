import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 22/4/21 at 11:20 AM
///

class UnitsShimmer extends StatelessWidget {
  final Axis scrollDirection;
  final int itemCount;

  const UnitsShimmer({this.scrollDirection, this.itemCount});

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
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 18,
              width: 120,
              color: Color(0xFFEBE8F4),
            ),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            itemCount: itemCount ?? 10,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) => Container(
              height: 62,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Color(0xFFEBE8F4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
