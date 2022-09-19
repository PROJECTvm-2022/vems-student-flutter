import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vems/config/index.dart';
import 'package:vems/data_models/chapter_data.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 9/1/21 at 5:48 PM
///

class ChapterTile extends StatelessWidget {
  final ChapterDatum datum;

  const ChapterTile({Key key, this.datum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 18),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    datum.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Get.isDarkMode
                          ? MyColors.darkTextColor
                          : MyColors.lightTextColor,
                    ),
                  ),
                  // const SizedBox(height: 4),
                  // Text(
                  //   '${datum.chaptersCount} Chapters',
                  //   style: TextStyle(fontSize: 12, color: Colors.grey),
                  // ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_outlined,
              size: 18,
              color: Get.isDarkMode
                  ? MyColors.darkTextColor
                  : MyColors.lightTextColor,
            )
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Theme.of(context).brightness == Brightness.light
              ? MyColors.lightTFColor
              : MyColors.darkTFColor,
        ),
      ),
    );
  }
}
