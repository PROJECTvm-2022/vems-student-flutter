import 'package:flutter/material.dart';
import 'package:vems/config/colors.dart';
import 'package:vems/data_models/course_data.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 6/1/21 at 11:30 AM
///

class DisplayedCoursesWidget extends StatelessWidget {
  final List<CourseDatum> courses;
  final String selectedCourse;
  final Function(CourseDatum r) onChanged;

  const DisplayedCoursesWidget(
      {Key key, this.courses = const [], this.selectedCourse, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: courses
          .map((e) => GestureDetector(
                onTap: () {
                  onChanged(e);
                },
                child: DisplayedCourseCard(
                  name: e.name,
                  active: selectedCourse == e.id,
                ),
              ))
          .toList(),
      spacing: 14,
      runSpacing: 14,
    );
  }
}

class DisplayedCourseCard extends StatelessWidget {
  final String name;
  final bool active;

  const DisplayedCourseCard({Key key, this.name, this.active = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
      child: Text(
        name ?? '',
        style: TextStyle(
          fontSize: 12,
          color: active ? MyColors.primaryBlue : null,
          fontWeight: FontWeight.w500,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: active ? MyColors.primaryBlue.withOpacity(0.1) : null,
        border: Border.all(
            width: 1, color: active ? Colors.transparent : Color(0xff6A6A6A)),
      ),
    );
  }
}
