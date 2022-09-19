import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/subjects_bloc/index.dart';
import 'package:vems/data_models/subject_data.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/dashboard/pages/home/home_page.dart';
import 'package:vems/pages/dashboard/pages/lectures/widgets/subject_card.dart';
import 'package:vems/widgets/shimmer_layouts/subjects_grid_shimmer.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 3/3/21 at 10:30 PM
///

class MySubjectsFragment extends StatelessWidget {
  final bool isHome;
  final bool isMaterial;

  const MySubjectsFragment(
      {Key key, this.isHome = false, this.isMaterial = false})
      : super(key: key);

  List<StudentSubjectData> get _subjectList => SubjectsBloc().subjects;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubjectsBloc, BaseState>(
        builder: (context, BaseState state) {
      if (state is ErrorBaseState && !isHome) {
        return SizedBox(
          height: 150,
          child: Center(
            child: Text(state.errorMessage),
          ),
        );
      }
      if (state is EmptyBaseState && !isHome) {
        return SizedBox(
          height: 150,
          child: Center(
            child: Text(S.of(context).noSubjectsAvailable),
          ),
        );
      }
      if (state is LoadingBaseState) {
        return SubjectsGridShimmer(isHome: isHome);
      }
      if (state is SubjectLoadedState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isHome) HomeTitle(S.of(context).exploreVideos),
            _subjectList.length < 1
                ? Center(
                    child: Text(S.of(context).noSubjectsAvailable),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _subjectList.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    itemBuilder: (ctx, index) {
                      return SubjectCard(
                        index: index,
                        datum: _subjectList[index],
                        onTap: isMaterial
                            ? () {
                                // Get.toNamed(MaterialsPage.routeName,
                                //     arguments: {
                                //       "subjectId":
                                //           _subjectList[index].subject.id,
                                //       "syllabus": _subjectList[index].id,
                                //       "subject": _subjectList[index].subject,
                                //     });
                              }
                            : null,
                      );
                    },
                  ),
          ],
        );
      }
      return SizedBox(); // SubjectsGridShimmer(isHome: isHome);
    });
  }
}
