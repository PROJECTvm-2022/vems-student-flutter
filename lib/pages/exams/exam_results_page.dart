import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/exam_bloc/exam_details_bloc/index.dart';
import 'package:vems/config/assets.dart';
import 'package:vems/config/colors.dart';
import 'package:vems/data_models/student_exam_datum.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/exams/widgets/exam_app_bar_content.dart';
import 'package:vems/pages/exams/widgets/exam_score_card.dart';
import 'package:vems/pages/exams/widgets/question_answer_widget.dart';
import 'package:vems/widgets/shimmer_layouts/exam_results_shimmer.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 3/4/21 at 10:18 AM
///

class ExamResultPage extends StatefulWidget {
  static final routeName = '/ExamResultPage';

  @override
  _ExamResultPageState createState() => _ExamResultPageState();
}

class _ExamResultPageState extends State<ExamResultPage> {
  String _examId = '';

  _getBack() {
    // Get.offNamedUntil(DashboardPage.routeName,
    //     (route) => route.settings.name == DashboardPage.routeName);
    Get.back();
  }

  StudentExamDatum get _exam => ExamDetailsBloc().exam;

  @override
  void initState() {
    _examId = Get.arguments ?? '';
    ExamDetailsBloc().add(LoadExamDetails(_examId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _getBack();
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ExamDetailsBloc, BaseState>(
              builder: (context, BaseState state) {
            if (state is ErrorBaseState) {
              return Center(
                child: Text(state.errorMessage),
              );
            }
            if (state is LoadingBaseState) {
              return ExamResultsShimmer();
            }
            if (state is ExamDetailsLoadedState) {
              return RefreshIndicator(
                onRefresh: () async {
                  ExamDetailsBloc().add(LoadExamDetails(_examId));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExamAppBarContent(
                      onBack: _getBack,
                      examDatum: _exam.exam,
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: (_exam.mark == null && _exam.grade == null)
                            ? [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 120),
                                  child: Text(
                                    "Result has not been published yet. \n Kindly wait till the result is published by the institute.",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ]
                            : [
                                if (_exam.mark != null)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: ExamScoreCard(
                                          title: S.of(context).score,
                                          value: '${_exam.mark}',
                                          asset: MyAssets.avgScore,
                                        )),
                                        const SizedBox(width: 12),
                                        Expanded(
                                            child: ExamScoreCard(
                                          title: S.of(context).percentage,
                                          value:
                                              '${((_exam.mark / _exam.exam.mark.total) * 100).toStringAsFixed(2)}%',
                                          asset: MyAssets.percentScore,
                                        )),
                                      ],
                                    ),
                                  ),
                                if (_exam.grade != null &&
                                    _exam.grade != 'No Grade' &&
                                    _exam.grade.isNotEmpty)
                                  ResultTitle("Grade that you got:"),
                                if (_exam.grade != null &&
                                    _exam.grade != 'No Grade' &&
                                    _exam.grade.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Row(
                                      children: [
                                        Text(
                                          "${_exam.grade}",
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          "Grade",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            height: 1.4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                const SizedBox(height: 16),
                                Divider(
                                  height: 0,
                                  thickness: 1,
                                ),
                                Flexible(
                                  child: ListView(
                                    physics: BouncingScrollPhysics(
                                        parent:
                                            AlwaysScrollableScrollPhysics()),
                                    children: [
                                      ResultTitle("Answers:"),
                                      ..._exam.answers
                                          .map((e) => QuestionAnswerWidget(
                                              datum: e,
                                              index: _exam.answers.indexOf(e)))
                                          .toList(),
                                    ],
                                  ),
                                )
                              ],
                      ),
                    )
                  ],
                ),
              );
            }
            return ExamResultsShimmer();
          }),
        ),
      ),
    );
  }
}

class ResultTitle extends StatelessWidget {
  final String text;

  const ResultTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Text(
        text ?? '',
        style: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? MyColors.grey
                : MyColors.darkTextColor.withOpacity(0.6)),
      ),
    );
  }
}
