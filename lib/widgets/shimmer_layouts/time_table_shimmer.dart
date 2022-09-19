import 'package:flutter/material.dart';
import 'package:vems/config/index.dart';
import 'package:vems/widgets/sticky_headers_table.dart';
import 'package:shimmer/shimmer.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 22/4/21 at 11:20 AM
///

class TimeTableShimmer extends StatelessWidget {
  final Axis scrollDirection;
  final int itemCount;

  const TimeTableShimmer({this.scrollDirection, this.itemCount});

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
      child: StickyHeadersTable(
        cellDimensions: CellDimensions.uniform(width: 88, height: 120),
        columnsLength: 4,
        rowsLength: 12,
        columnsTitleBuilder: (i) => Container(
          height: 60,
          width: 96,
          color: Color(0xFFEBE8F4),
        ),
        rowsTitleBuilder: (i) => Container(
          height: 60,
          width: 66,
          color: Color(0xFFEBE8F4),
        ),
        contentCellBuilder: (i, j) {
          return j % 2 == 0 || i == j || i % 4 == 0 && (i == 4 && j == 3)
              ? SizedBox()
              : Container(
                  // height: 18,
                  // width: 120,
                  decoration: BoxDecoration(color: Color(0xFFEBE8F4)),
                );
        },
        legendCellDecoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? MyColors.darkTFColor
              : MyColors.f9Grey,
        ),
        columnTitleDecoration: (index) => BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? MyColors.darkTFColor
              : MyColors.f9Grey,
          border: Border(
              right: BorderSide(
            color: Colors.white,
            width: 1,
          )),
        ),
        rowTitleDecoration: (index) => BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? MyColors.darkTFColor
              : MyColors.f9Grey,
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
        ),
        cellDecoration: (i, j) => BoxDecoration(
          border: Border(
            right: BorderSide(
              color: MyColors.borderGrey,
              width: 1,
            ),
            bottom: BorderSide(
              color: MyColors.borderGrey,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
