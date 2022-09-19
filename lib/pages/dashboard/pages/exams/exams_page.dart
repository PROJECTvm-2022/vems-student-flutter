import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/exam_bloc/exams_bloc/index.dart';
import 'package:vems/config/index.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/dashboard/pages/exams/widgets/exam_card.dart';
import 'package:vems/pages/exams/exam_details_page.dart';
import 'package:vems/widgets/button.dart';
import 'package:vems/widgets/logout_button.dart';
import 'package:vems/widgets/shimmer_layouts/exam_list_shimmer.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 8/1/21 at 1:38 AM
///
///

class ExamsPage extends StatefulWidget {
  static final routeName = '/exams';

  @override
  _ExamsPageState createState() => _ExamsPageState();
}

class _ExamsPageState extends State<ExamsPage> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    ExamsBloc().add(LoadExamsEvent());
    _scrollController.addListener(() {
      final maxGeneralScroll = _scrollController.position.maxScrollExtent;
      final currentGeneralScroll = _scrollController.position.pixels;
      if (maxGeneralScroll <= currentGeneralScroll) {
        ExamsBloc().add(LoadMoreExams());
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: MyBackButton(),
        // titleSpacing: 0,
        title: Text(
          "All Exams",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).brightness == Brightness.light
                ? MyColors.appBarTextColorLight
                : MyColors.darkTextColor,
          ),
        ),
        actions: [LogoutButton()],
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : MyColors.darkTFColor,
      ),
      body: Column(
        children: [
          // ExamTypeBar(
          //   isScheduledExams: isScheduledExams,
          //   onChanged: (val) {
          //     setState(() {
          //       isScheduledExams = val;
          //       ExamsBloc().add(LoadExamsEvent(isScheduledExams));
          //     });
          //   },
          // ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                ExamsBloc().add(LoadExamsEvent());
              },
              child: BlocBuilder<ExamsBloc, BaseState>(
                  builder: (context, BaseState state) {
                if (state is ErrorBaseState) {
                  return EmptyErrorWidget(
                    message: state.errorMessage,
                    onTap: () {
                      ExamsBloc().add(LoadExamsEvent());
                    },
                  );
                }
                if (state is EmptyBaseState) {
                  return EmptyErrorWidget(
                    message: S.of(context).noExamsAvailable,
                    onTap: () {
                      ExamsBloc().add(LoadExamsEvent());
                    },
                  );
                }
                if (state is LoadingBaseState) {
                  return ExamListShimmer(scrollDirection: Axis.vertical);
                }
                if (state is ExamsLoadedState) {
                  return ListView.builder(
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    itemCount: ExamsBloc().shouldLoadMore
                        ? ExamsBloc().exams.length + 1
                        : ExamsBloc().exams.length,
                    itemBuilder: (context, index) {
                      if (index >= ExamsBloc().exams.length) {
                        return ExamsBloc().shouldLoadMore
                            ? Center(child: CircularProgressIndicator())
                            : SizedBox();
                      } else {
                        return ExamCard(
                          datum: ExamsBloc().exams[index],
                          onTap: () {
                            // if (ExamsBloc().exams[index].exam.status == 4) {
                            //   Get.toNamed(ExamResultPage.routeName,
                            //       arguments: ExamsBloc().exams[index].id);
                            // } else {
                            Get.toNamed(ExamDetailsPage.routeName,
                                arguments: ExamsBloc().exams[index].id);
                            // }
                          },
                        );
                      }
                    },
                  );
                }
                return ExamListShimmer(scrollDirection: Axis.vertical);
              }),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            color: MyColors.brightPrimary,
            child: Text(
              "© 2021-2022 Vernacular Medium Educational Services Private Limited. All Rights Reserved.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

class EmptyErrorWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String message;

  const EmptyErrorWidget({this.onTap, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$message"),
          const SizedBox(height: 10),
          SizedBox(
            width: 90,
            child: MyButton(
              height: 40,
              child: Text(
                "Refresh",
                style: TextStyle(fontSize: 14),
              ),
              onPressed: onTap,
            ),
          ),
        ],
      ),
    );
  }
}
