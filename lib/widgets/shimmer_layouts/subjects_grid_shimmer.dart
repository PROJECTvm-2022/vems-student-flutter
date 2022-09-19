import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 22/4/21 at 11:20 AM
///

class SubjectsGridShimmer extends StatelessWidget {
  final bool isHome;
  final Axis scrollDirection;
  final int itemCount;

  const SubjectsGridShimmer(
      {this.scrollDirection, this.itemCount, this.isHome = false});

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
          isHome
              ? Container(
                  height: 18,
                  width: 165,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  color: Color(0xFFEBE8F4),
                )
              : const SizedBox(height: 16),
          GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: itemCount ?? 6,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemBuilder: (ctx, index) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Color(0xFFEBE8F4),
                    ),
                  )),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
