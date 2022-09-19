import 'package:flutter/material.dart';
import 'package:vems/widgets/divider.dart';
import 'package:shimmer/shimmer.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 06/07/21 at 5:00 pm
///

class MaterialsShimmer extends StatelessWidget {
  final int itemCount;
  final bool scroll;

  const MaterialsShimmer({this.scroll = true, this.itemCount});

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
        separatorBuilder: (ctx, i) => MyDivider(),
        padding: EdgeInsets.symmetric(horizontal: scroll ? 16 : 0),
        itemCount: itemCount ?? 10,
        physics:
            scroll ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
        shrinkWrap: !scroll,
        itemBuilder: (ctx, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Container(
                height: 75,
                width: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFEBE8F4),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xFFEBE8F4),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 18,
                      width: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xFFEBE8F4),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 20,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xFFEBE8F4),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFEBE8F4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
