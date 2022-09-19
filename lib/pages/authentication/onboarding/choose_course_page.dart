import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vems/api_services/courses_api_services.dart';
import 'package:vems/config/index.dart';
import 'package:vems/data_models/course_data.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/authentication/onboarding/choose_mode_page.dart';
import 'package:vems/pages/authentication/onboarding/widgets/displayed_courses_widget.dart';
import 'package:vems/pages/authentication/onboarding/widgets/search_course_field.dart';
import 'package:vems/pages/authentication/widgets/auth_text_widgets.dart';
import 'package:vems/utils/snackbar_helper.dart';
import 'package:vems/widgets/back_button.dart';
import 'package:vems/widgets/button.dart';
import 'package:vems/widgets/logout_button.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 6/1/21 at 1:14 AM
///

class ChooseCoursePage extends StatefulWidget {
  static final routeName = '/ChooseCoursePage';

  @override
  _ChooseCoursePageState createState() => _ChooseCoursePageState();
}

class _ChooseCoursePageState extends State<ChooseCoursePage> {
  final _buttonKey = GlobalKey<MyButtonState>();
  CourseDatum _selectedCourse = CourseDatum();
  String _instituteId = '';
  List<CourseDatum> _courses = [];
  var _courseApi;

  @override
  void initState() {
    _instituteId = Get.arguments ?? '';
    print(_instituteId);
    _courseApi = getCourses(
      instituteId: _instituteId,
      skip: 0,
      limit: 10,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MyBackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [LogoutButton()],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 34, 16, 90),
              children: [
                AuthHeadingText(S.of(context).chooseCourses),
                const SizedBox(height: 8),
                Text(
                  S.of(context).pleaseSelectYourCourse,
                  style: TextStyle(
                      color: MyColors.labelColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 24),
                SearchCourseField(
                  instituteId: _instituteId,
                  onChanged: (val) {},
                  onSuggestionSelected: (datum) {
                    setState(() {
                      if (!_courses.contains(datum)) {
                        _courses.removeLast();
                        _courses.insert(0, datum);
                      }
                      _selectedCourse = datum;
                    });
                  },
                ),
                const SizedBox(height: 16),
                FutureBuilder<List<CourseDatum>>(
                  future: _courseApi, // async work
                  builder: (BuildContext context,
                      AsyncSnapshot<List<CourseDatum>> snapshot) {
                    if (snapshot.hasError) {
                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: Text(snapshot.error?.toString()),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      _courses = snapshot.data
                          .where((element) => element.course != null)
                          .toList();
                      return DisplayedCoursesWidget(
                        courses: _courses,
                        selectedCourse: _selectedCourse.id,
                        onChanged: (val) {
                          setState(() {
                            _selectedCourse = val;
                          });
                        },
                      );
                    } else {
                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
          Positioned(
            bottom: 25,
            right: 16,
            left: 16,
            child: MyButton(
              key: _buttonKey,
              child: Text(S.of(context).next),
              width: double.infinity,
              onPressed: () {
                if (_selectedCourse.id.isNotEmpty) {
                  Get.toNamed(ChooseAttendanceModePage.routeName, arguments: {
                    "instituteId": _instituteId,
                    "courseId": _selectedCourse.id,
                  });
                } else {
                  SnackBarHelper.show(
                    S.of(context).oops,
                    S.of(context).pleaseChooseACourseToProceed,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
