import 'package:flutter/material.dart';
import 'package:vems/bloc_models/assignments_bloc/upcoming_assignments_bloc/index.dart';
import 'package:vems/bloc_models/exam_bloc/upcoming_exam_bloc/index.dart';
import 'package:vems/bloc_models/live_class_bloc/index.dart';
import 'package:vems/bloc_models/subjects_bloc/index.dart';
import 'package:vems/bloc_models/video_history_bloc/index.dart';
import 'package:vems/pages/dashboard/pages/home/widgets/greetings_widget.dart';
import 'package:vems/pages/dashboard/pages/home/widgets/home_exams_slider.dart';
import 'package:vems/pages/dashboard/pages/profile/widgets/my_subjects_fragment.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 8/1/21 at 1:39 AM
///

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    UpcomingExamsBloc().add(LoadUpcomingExamsEvent());
    VideoHistoryBloc().add(LoadVideoHistory());
    LiveClassBloc().add(LoadUpcomingClasses());
    UpcomingAssignmentBloc().add(LoadAssignments());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        UpcomingExamsBloc().add(LoadUpcomingExamsEvent());
        VideoHistoryBloc().add(LoadVideoHistory());
        LiveClassBloc().add(LoadUpcomingClasses());
        SubjectsBloc().add(LoadSubjectsEvent());
        UpcomingAssignmentBloc().add(LoadAssignments());
      },
      child: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          GreetingsWidget(),
          const SizedBox(height: 10),
          HomeExamsSlider(),
          MySubjectsFragment(isHome: true),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class HomeTitle extends StatelessWidget {
  final String text;

  const HomeTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        text ?? '',
        style: TextStyle(
            fontWeight: FontWeight.w700, fontSize: 16, letterSpacing: 0.6),
      ),
    );
  }
}
