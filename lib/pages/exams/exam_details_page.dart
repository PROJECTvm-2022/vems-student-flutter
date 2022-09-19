import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/exam_bloc/exam_details_bloc/index.dart';
import 'package:vems/config/assets.dart';
import 'package:vems/config/colors.dart';
import 'package:vems/config/functions.dart';
import 'package:vems/data_models/exam_datum.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/dashboard/pages/exams/widgets/exam_card.dart';
import 'package:vems/pages/exams/exam_questions_page.dart';
import 'package:vems/pages/exams/widgets/exam_app_bar_content.dart';
import 'package:vems/utils/exam_socket_helper.dart';
import 'package:vems/utils/shared_preference_helper.dart';
import 'package:vems/utils/snackbar_helper.dart';
import 'package:vems/widgets/button.dart';
import 'package:vems/widgets/shimmer_layouts/exam_details_shimmer.dart';

import 'widgets/html_view.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 2/4/21 at 8:32 PM
///

class ExamDetailsPage extends StatefulWidget {
  static final routeName = '/ExamDetailsPage';

  @override
  _ExamDetailsPageState createState() => _ExamDetailsPageState();
}

class _ExamDetailsPageState extends State<ExamDetailsPage> {
  final _buttonKey = GlobalKey<MyButtonState>();
  Timer _timer;
  String _examId = '';

  ExamDatum get _exam => ExamDetailsBloc().exam.exam;

  int get _secondsLeft =>
      _exam.scheduledOn.difference(DateTime.now()).inSeconds;

  void _startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_exam != null) {
          setState(
            () {
              if (_secondsLeft < 1) {
                timer.cancel();
              }
            },
          );
        }
      },
    );
  }

  @override
  void initState() {
    _examId = Get.arguments ?? '';
    ExamDetailsBloc().add(LoadExamDetails(_examId));
    _startTimer();
    ExamSocketHelper.initSocket();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    ExamSocketHelper.disposeSocket();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ExamDetailsBloc, BaseState>(
          builder: (context, BaseState state) {
        if (state is ErrorBaseState) {
          return Center(
            child: Text(state.errorMessage),
          );
        }
        if (state is LoadingBaseState) {
          return ExamDetailsShimmer();
        }
        if (state is ExamDetailsLoadedState) {
          return Stack(
            children: [
              Positioned.fill(
                child: RefreshIndicator(
                  onRefresh: () async {
                    ExamDetailsBloc().add(LoadExamDetails(_examId));
                  },
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 70),
                    children: [
                      ExamAppBarContent(examDatum: _exam),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                                Theme.of(context).brightness == Brightness.light
                                    ? MyAssets.questionBlack
                                    : MyAssets.questionMarkGrey),
                            const SizedBox(width: 4),
                            Text(
                              "${_exam.questionCount} Questions",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            SvgPicture.asset(
                                Theme.of(context).brightness == Brightness.light
                                    ? MyAssets.clockBlack
                                    : MyAssets.clockGrey),
                            const SizedBox(width: 4),
                            Text(
                              "${countDownTimeFormatFromSeconds(_exam.duration * 60, isHrMin: true)}",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 0,
                        thickness: 1,
                      ),
                      const SizedBox(height: 16),
                      ExamTitleText(S.of(context).description),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text("${_exam.description}",
                            style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? MyColors.grey
                                    : MyColors.darkTextColor.withOpacity(0.6))),
                      ),
                      const SizedBox(height: 16),
                      Divider(
                        height: 0,
                        thickness: 1,
                      ),
                      const SizedBox(height: 16),
                      ExamTitleText(S.of(context).guidelines),
                      const SizedBox(height: 8),
                      ..._exam.instructions
                          .map((e) => GuideLineText(e))
                          .toList(),
                    ],
                  ),
                ),
              ),
              if (_exam.questionCount > 0)
                Positioned(
                  bottom: 20,
                  right: 16,
                  left: 16,
                  child: MyButton(
                    key: _buttonKey,
                    width: double.infinity,
                    child: Text(ExamDetailsBloc().exam.status == 3
                        ? S.of(context).startExam
                        : ExamDetailsBloc().exam.status == 4
                            ? "Exam Ended"
                            : "${countDownTimeFormatFromSeconds(_secondsLeft)} "),
                    onPressed: ExamDetailsBloc().exam.status != 3
                        ? null
                        : () {
                            if (ExamDetailsBloc().exam.attendanceStatus == 1) {
                              _buttonKey.currentState.showLoader();

                              ExamSocketHelper.joinExamination(
                                      ExamDetailsBloc().exam.id)
                                  .then((value) {
                                _buttonKey.currentState.hideLoader();
                                Get.toNamed(ExamQuestionsPage.routeName,
                                    arguments: ExamDetailsBloc().exam.id);
                              }).catchError((err) {
                                print("catch error in details page " +
                                    err?.toString());
                                _buttonKey.currentState.hideLoader();
                              }).onError((error, stackTrace) {
                                print("on error occurred in details page" +
                                    error?.toString());
                                _buttonKey.currentState.hideLoader();
                              });
                            } else {
                              SnackBarHelper.show("Oops",
                                  "Your answers already have been submitted. If some interruptions occurred during examination then kindly contact the administration.");
                            }
                          },
                  ),
                )
            ],
          );
        }
        return ExamDetailsShimmer();
      }),
    );
  }
}

class ExamTitleText extends StatelessWidget {
  final String text;

  const ExamTitleText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class GuideLineText extends StatelessWidget {
  final String text;

  const GuideLineText(this.text);

  @override
  Widget build(BuildContext context) {
    final _foregroundColor = Theme.of(context).brightness == Brightness.light
        ? MyColors.lightTextColor
        : Colors.white.withOpacity(0.8);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: HtmlView(text, color: _foregroundColor),
    );
    // return text.isEmpty
    //     ? SizedBox()
    //     : Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    //         child: Row(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.only(top: 5),
    //               child: Dot(
    //                   radius: 10,
    //                   color: Theme.of(context).brightness == Brightness.light
    //                       ? MyColors.grey
    //                       : MyColors.darkTextColor.withOpacity(0.6)),
    //             ),
    //             const SizedBox(width: 16),
    //             Expanded(
    //                 child: Text(
    //               text ?? '',
    //               style: TextStyle(
    //                   color: Theme.of(context).brightness == Brightness.light
    //                       ? MyColors.grey
    //                       : MyColors.darkTextColor.withOpacity(0.6)),
    //             )),
    //           ],
    //         ),
    //       );
  }
}
