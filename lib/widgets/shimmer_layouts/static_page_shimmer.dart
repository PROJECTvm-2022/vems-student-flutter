import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 22/4/21 at 11:20 AM
///

class StaticPageShimmer extends StatelessWidget {
  final Axis scrollDirection;
  final int itemCount;

  const StaticPageShimmer({this.scrollDirection, this.itemCount});

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
              width: 150,
              color: Color(0xFFEBE8F4),
            ),
          ),
          const SizedBox(height: 10),
          ...List.generate(
            4,
            (index) => Container(
              height: 15,
              margin: EdgeInsets.fromLTRB(0, 4,
                  (index % 2 == 0 ? index * 6.5 : index * 2).toDouble(), 4),
              // width: double.infinity,
              color: Color(0xFFEBE8F4),
            ),
          ).toList(),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 18,
              width: 190,
              color: Color(0xFFEBE8F4),
            ),
          ),
          const SizedBox(height: 10),
          ...List.generate(
            6,
            (index) => Container(
              height: 13,
              margin: EdgeInsets.fromLTRB(0, 4,
                  (index % 2 == 0 ? index * 6.5 : index * 2).toDouble(), 4),
              // width: double.infinity,
              color: Color(0xFFEBE8F4),
            ),
          ).toList(),
          const SizedBox(height: 14),
          ...List.generate(
            3,
            (index) => Container(
              height: 13,
              margin: EdgeInsets.fromLTRB(0, 4,
                  (index % 2 == 0 ? index * 2.5 : index * 8).toDouble(), 4),
              // width: double.infinity,
              color: Color(0xFFEBE8F4),
            ),
          ).toList(),
          const SizedBox(height: 14),
          ...List.generate(
            4,
            (index) => Container(
              height: 13,
              margin: EdgeInsets.fromLTRB(0, 4,
                  (index % 2 == 0 ? index * 8.5 : index * 2).toDouble(), 4),
              // width: double.infinity,
              color: Color(0xFFEBE8F4),
            ),
          ).toList(),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 18,
              width: 120,
              color: Color(0xFFEBE8F4),
            ),
          ),
          const SizedBox(height: 10),
          ...List.generate(
            6,
            (index) => Container(
              height: 15,
              margin: EdgeInsets.fromLTRB(0, 4,
                  (index % 2 == 0 ? index * 6.5 : index * 2).toDouble(), 4),
              // width: double.infinity,
              color: Color(0xFFEBE8F4),
            ),
          ).toList(),
        ],
      ),
    );
  }
}
