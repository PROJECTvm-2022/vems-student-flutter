import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vems/config/index.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 04/09/21 at 8:43 pm
///

class GenderSelector extends StatelessWidget {
  final int gender;
  final Function(int r) onChanged;

  GenderSelector({this.gender, this.onChanged});

  final List<String> assets = [MyAssets.male, MyAssets.female, MyAssets.others];
  final List<String> title = ["Male", "Female", "Others"];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).brightness;

    return Row(
      children: List.generate(
        3,
        (index) => Expanded(
          child: GestureDetector(
            onTap: () {
              onChanged.call(index + 1);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              margin: index == 1
                  ? EdgeInsets.symmetric(horizontal: 4)
                  : EdgeInsets.fromLTRB(
                      index == 2 ? 8 : 0, 0, index == 0 ? 8 : 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("${assets[index]}"),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("${title[index]}"),
                ],
              ),
              decoration: BoxDecoration(
                color: gender == index + 1
                    ? theme == Brightness.dark
                        ? Get.theme.primaryColor.withOpacity(0.6)
                        : Color(0xffDBEDFF)
                    : theme == Brightness.dark
                        ? Get.theme.bottomAppBarColor
                        : MyColors.fillGrey,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
