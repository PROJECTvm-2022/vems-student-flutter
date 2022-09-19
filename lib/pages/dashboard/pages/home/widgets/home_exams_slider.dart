import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/exam_bloc/upcoming_exam_bloc/index.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/dashboard/dashboard_page.dart';
import 'package:vems/pages/dashboard/pages/exams/exams_page.dart';
import 'package:vems/pages/dashboard/pages/home/home_page.dart';
import 'package:vems/pages/dashboard/pages/home/widgets/home_exam_card.dart';
import 'package:vems/pages/exams/exam_details_page.dart';
import 'package:vems/utils/shared_preference_helper.dart';
import 'package:vems/widgets/shimmer_layouts/exam_list_shimmer.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 14/4/21 at 2:27 PM
///

class HomeExamsSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpcomingExamsBloc, BaseState>(
        builder: (context, BaseState state) {
      if (state is EmptyBaseState) {
        return SizedBox();
      }
      if (state is LoadingBaseState) {
        return ExamListShimmer();
      }
      if (state is UpcomingExamsLoadedState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                HomeTitle(S.of(context).upcomingTests),
                Spacer(),
                TextButton(
                  onPressed: () {
                    dashboardIndexNotifier.value = 3;
                  },
                  child: Text("View All"),
                ),
                const SizedBox(width: 8),
              ],
            ),
            SizedBox(
              height: 155,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 6),
                itemCount: UpcomingExamsBloc().exams.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) => HomeExamCard(
                  index: index,
                  datum: UpcomingExamsBloc().exams[index],
                  onTap: () {
                    Get.toNamed(ExamDetailsPage.routeName,
                        arguments: UpcomingExamsBloc().exams[index].id);
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        );
      }
      return SizedBox();
    });
  }
}
