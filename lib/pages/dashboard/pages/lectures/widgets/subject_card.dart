import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vems/config/colors.dart';
import 'package:vems/config/decorations.dart';
import 'package:vems/data_models/subject_data.dart';
import 'package:vems/pages/units/units_page.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 9/1/21 at 1:49 PM
///

class SubjectCard extends StatelessWidget {
  final int index;
  final StudentSubjectData datum;
  final VoidCallback onTap;

  const SubjectCard({Key key, this.index, this.datum, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            FocusScope.of(context).requestFocus(FocusNode());
            Get.toNamed(UnitsPage.routeName, arguments: datum.id);
          },
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: Image.network(
                datum.subject.avatar,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              datum.subject.name ?? '',
              style: TextStyle(
                color: MyColors.darkTextColor,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  spreadRadius: 0,
                  offset: Offset(0, 4),
                )
              ],
              gradient:
                  MyDecorations.myGradients[index > 6 ? index % 6 : index],
            ),
          ),
        ],
      ),
    );
  }
}
