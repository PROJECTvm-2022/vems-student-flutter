import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vems/config/index.dart';
import 'package:vems/data_models/schedule_cell_datum.dart';
import 'package:vems/pages/class_schedule/widgets/join_class_sheet.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 26/1/21 at 12:41 AM
///

class ScheduleCell extends StatelessWidget {
  final List<CellDatum> data;
  final List<int> hours;

  ScheduleCell({Key key, this.data, this.hours}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Column(
            children: List.generate(
              hours.length,
              (index) => Container(
                height: 120,
                alignment: Alignment.bottomCenter,
                child: Divider(
                  height: 0,
                ),
              ),
            ).toList(),
          ),
        ),
        ...data.map(
          (e) {
            double height =
                ((e.data.teacherSlot.endTime - e.data.teacherSlot.startTime) *
                        2)
                    .toDouble();
            double topPadding = ((e.globalStart - hours.first) * 120 +
                (e.localStart * 2).toDouble());
            return Positioned(
              top: topPadding,
              height: height,
              right: 0,
              left: 0,
              child: GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                      JoinClassSheet(
                        datum: e.data,
                      ),
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor);
                },
                child: Container(
                  height: height,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: MyColors.primaryBlue,
                    border: Border(
                        top: BorderSide(color: Colors.white),
                        bottom: BorderSide(color: Colors.white)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${e.data.subject.name}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      if (height > 40)
                        Text(
                          "by ${e.data.teacher.name}",
                          maxLines: height > 80 ? 3 : 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 11, color: Colors.white),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class BreakCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(6),
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      child: Text(
        "Break",
        style: TextStyle(color: MyColors.red, fontWeight: FontWeight.w600),
      ),
      decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(7),
          color: MyColors.red.withOpacity(0.1)),
    );
  }
}

class HolidayCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(6),
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      child: Text("Holiday",
          style: TextStyle(color: MyColors.green, fontWeight: FontWeight.w600)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: MyColors.green.withOpacity(0.1)),
    );
  }
}
