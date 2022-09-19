import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vems/config/index.dart';
import 'package:vems/data_models/schedule_cell_datum.dart';
import 'package:vems/pages/class_schedule/widgets/schedule_cells.dart';
import 'package:vems/widgets/sticky_headers_table.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 25/1/21 at 9:48 PM
///

class ScheduleGrid extends StatelessWidget {
  final List<TimeTableDatum> cells;
  final List<String> days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  ScheduleGrid({Key key, this.cells}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TimeDatum> times = [];
    List<List<CellDatum>> cellData = [];
    List<int> timeVariants = [];
    List<int> hours = [];
    cells.forEach((element) {
      TimeDatum temp = TimeDatum(
        startingTime: element.teacherSlot.startTime,
        endingTime: element.teacherSlot.endTime,
      );
      if (!times.contains(temp)) {
        times.add(temp);
      }
    });
    times.forEach((time) {
      int start = (time.startingTime / 60).truncate(); // start time bet 1-23
      int end = (time.endingTime / 60).truncate(); // end time bet 1-23
      if (!timeVariants.contains(start)) {
        timeVariants.add(start);
      }
      if (!timeVariants.contains(end)) {
        timeVariants.add(end);
      }
    });
    timeVariants.sort();
    if (timeVariants.isNotEmpty) {
      for (int i = timeVariants.first; i <= timeVariants.last; i++) {
        hours.add(i);
      }
    }
    if (hours.isNotEmpty) {
      hours.insert(0, hours.first - 1);
      // to add a blank row initially to make the ui clean
    }
    for (int i = 0; i < days.length; i++) {
      List<CellDatum> tempCells = [];
      cells.forEach((cell) {
        int start = (cell.teacherSlot.startTime / 60).truncate();
        int end = (cell.teacherSlot.endTime / 60).truncate();
        int startMin = cell.teacherSlot.startTime % 60;
        int endMin = cell.teacherSlot.endTime % 60;
        if (cell.teacherSlot.day == i) {
          tempCells.add(CellDatum(
            localStart: startMin,
            localEnd: endMin,
            globalStart: start,
            globalEnd: end,
            data: cell,
          ));
        }
      });
      cellData.add(tempCells);
    }

    // timeVariants : all types of times available
    // hours : min timeVariant to max timeVariant with 1 hour gap
    // Magic number 120 : taken as vertical single cell height

    return StickyHeadersTable(
      columnTitleHeight: 60,
      columnsLength: days.length,
      rowsLength: 1,
      cellDimensions: CellDimensions.uniform(
          width: 88, height: (hours.length * 120.toDouble())),
      columnsTitleBuilder: (i) => Text(
        days[i],
        style: TextStyle(
          fontSize: 16,
          color:
              Get.isDarkMode ? MyColors.labelColor : MyColors.scheduleRowGrey,
        ),
      ),
      rowsTitleBuilder: (i) => Column(
        children: hours.map((e) {
          int index = hours.indexOf(e);
          return SizedBox(
            height: 120,
            child: index == 0
                ? SizedBox()
                : Transform.translate(
                    offset: Offset(0, -8),
                    child: Text(
                      e >= 12
                          ? "${(e % 12 == 0 ? 12 : (e % 12).toString().padLeft(2, "0"))} : 00 PM"
                          : "${e.toString().padLeft(2, "0")} : 00 AM",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          color: Get.isDarkMode
                              ? MyColors.labelColor
                              : MyColors.grey),
                    ),
                  ),
          );
        }).toList(),
      ),
      contentCellBuilder: (i, j) {
        return ScheduleCell(
          data: cellData[i],
          hours: hours,
        );
      },
      legendCell: Text(
        'Day/\nTime',
        style: TextStyle(fontSize: 15),
      ),
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
          color: MyColors.borderGrey,
          width: 1,
        )),
      ),
      rowTitleDecoration: (index) => BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? MyColors.darkTFColor
            : MyColors.f9Grey,
        border: Border(
          bottom: BorderSide(
            color: MyColors.borderGrey,
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
        ),
      ),
    );
  }
}
