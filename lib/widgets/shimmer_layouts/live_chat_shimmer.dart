import 'package:flutter/material.dart';
import 'package:vems/pages/dashboard/pages/exams/widgets/exam_card.dart';
import 'package:shimmer/shimmer.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 22/4/21 at 11:22 AM
///

class LiveChatShimmer extends StatelessWidget {
  final Axis scrollDirection;
  final int itemCount;

  const LiveChatShimmer({this.scrollDirection, this.itemCount});

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
      child: ListView.separated(
        itemCount: itemCount ?? 10,
        shrinkWrap: true,
        separatorBuilder: (context, index) => Divider(color: Colors.grey),
        padding: const EdgeInsets.only(bottom: 10, top: 0),
        itemBuilder: (ctx, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Dot(radius: 46),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14,
                      width: 150,
                      color: Color(0xFFEBE8F4),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 16,
                      width: double.infinity,
                      color: Color(0xFFEBE8F4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
