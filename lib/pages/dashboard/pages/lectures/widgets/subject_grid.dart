import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/subjects_bloc/index.dart';
import 'package:vems/data_models/subject_data.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/dashboard/pages/lectures/widgets/subject_card.dart';
import 'package:vems/widgets/shimmer_layouts/subjects_grid_shimmer.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 9/1/21 at 1:21 PM
///

class SubjectsGrid extends StatefulWidget {
  SubjectsGrid({Key key}) : super(key: key);

  @override
  SubjectsGridState createState() => SubjectsGridState();
}

class SubjectsGridState extends State<SubjectsGrid> {
  String query = '';

  List<StudentSubjectData> get _subjectList => SubjectsBloc()
      .subjects
      .where((element) =>
          element.subject.name.toLowerCase().contains(query.toLowerCase()))
      .toList();

  void refresh(String q) {
    setState(() {
      query = q;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        SubjectsBloc().add(LoadSubjectsEvent());
      },
      child: BlocBuilder<SubjectsBloc, BaseState>(
          builder: (context, BaseState state) {
        if (state is ErrorBaseState) {
          return Center(
            child: Text(state.errorMessage),
          );
        }
        if (state is EmptyBaseState) {
          return Center(
            child: Text(S.of(context).noSubjectsAvailable),
          );
        }
        if (state is LoadingBaseState) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(top: 70),
              child: SubjectsGridShimmer(itemCount: 12),
            ),
          );
        }
        if (state is SubjectLoadedState) {
          return _subjectList.length < 1
              ? Center(
                  child: Text(S.of(context).noSubjectsAvailable),
                )
              : GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 86, 16, 18),
                  itemCount: _subjectList.length,
                  physics: AlwaysScrollableScrollPhysics(),
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
                    );
                  },
                );
        }
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 70),
            child: SubjectsGridShimmer(itemCount: 12),
          ),
        );
      }),
    );
  }
}
