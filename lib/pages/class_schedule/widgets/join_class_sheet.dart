import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vems/config/assets.dart';
import 'package:vems/config/colors.dart';
import 'package:vems/config/functions.dart';
import 'package:vems/data_models/schedule_cell_datum.dart';
import 'package:vems/widgets/my_avatar.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 26/1/21 at 10:58 AM
///

class JoinClassSheet extends StatelessWidget {
  final TimeTableDatum datum;

  const JoinClassSheet({Key key, this.datum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 5, 0, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${datum.subject.name}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              IconButton(
                  icon: SvgPicture.asset(MyAssets.cross),
                  onPressed: () => Get.back())
            ],
          ),
        ),
        const Divider(
          height: 0,
          thickness: 1,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 19, 16, 19),
          child: Text(
            "${scheduleTimeFormat(TimeDatum(startingTime: datum.teacherSlot.startTime, endingTime: datum.teacherSlot.endTime))}",
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? MyColors.darkTextColor
                  : MyColors.grey,
            ),
          ),
        ),
        Row(
          children: [
            const SizedBox(width: 16),
            MyCircleAvatar(
              datum.teacher.avatar,
              name: datum.teacher.name,
              radius: 17,
            ),
            const SizedBox(width: 10),
            Text(
              "By ${datum.teacher.name}",
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? MyColors.darkTextColor
                    : MyColors.grey,
              ),
            )
          ],
        ),
        const SizedBox(height: 25),
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(16, 23, 16, 25),
        //   child: MyButton(
        //     child: Text(S.of(context).join),
        //     color: MyColors.green,
        //     width: double.infinity,
        //     onPressed: () {
        //       Get.back();
        //       Get.toNamed(LiveClassPage.routeName, arguments: {
        //         "liveClass": LiveClassDatum(
        //           id: datum.id,
        //           teacherSlot: datum.teacherSlot,
        //           status: datum.status,
        //           teacher: datum.teacher,
        //         )
        //       });
        //     },
        //   ),
        // )
      ],
    );
  }
}
