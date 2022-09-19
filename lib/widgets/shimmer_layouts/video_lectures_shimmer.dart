import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 22/4/21 at 11:20 AM
///

class VideoLecturesShimmer extends StatelessWidget {
  final Axis scrollDirection;
  final int itemCount;

  const VideoLecturesShimmer({this.scrollDirection, this.itemCount});

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
        itemCount: itemCount ?? 10,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (ctx, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 88,
                width: 144,
                decoration: BoxDecoration(
                  color: Color(0xFFEBE8F4),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 18,
                    width: 160,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    color: Color(0xFFEBE8F4),
                  ),
                  Container(
                    height: 16,
                    width: 140,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    color: Color(0xFFEBE8F4),
                  ),
                  Container(
                    height: 16,
                    width: 80,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    color: Color(0xFFEBE8F4),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
