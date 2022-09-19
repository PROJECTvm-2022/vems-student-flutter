import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 22/4/21 at 11:20 AM
///

class ContinueWatchingShimmer extends StatelessWidget {
  final Axis scrollDirection;
  final int itemCount;

  const ContinueWatchingShimmer({this.scrollDirection, this.itemCount});

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
            height: 18,
            width: 145,
            margin: const EdgeInsets.fromLTRB(16, 5, 16, 10),
            color: Color(0xFFEBE8F4),
          ),
          SizedBox(
            height: 185,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 6),
              itemCount: itemCount ?? 6,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 7.5, horizontal: 10),
                      width: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Color(0xFFEBE8F4),
                      ),
                    ),
                  ),
                  Container(
                    height: 18,
                    width: 145,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    color: Color(0xFFEBE8F4),
                  ),
                  Container(
                    height: 16,
                    width: 80,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    color: Color(0xFFEBE8F4),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
