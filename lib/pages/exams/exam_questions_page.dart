import 'dart:async';
import 'dart:developer';

import 'package:vems/pages/authentication/login/login_page.dart';
import 'package:vems/pages/dashboard/pages/exams/exams_page.dart';
import 'package:vems/utils/shared_preference_helper.dart';
import 'package:vems/widgets/shimmer_layouts/exam_questions_shimmer.dart';
import 'package:screen/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:vems/api_services/exam_api_services.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/exam_bloc/exam_details_bloc/index.dart';
import 'package:vems/data_models/exam_datum.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/exams/widgets/disturbance_dialogue.dart';
import 'package:vems/pages/exams/widgets/exam_action_widget.dart';
import 'package:vems/pages/exams/widgets/exam_question_card.dart';
import 'package:vems/pages/exams/widgets/exam_questions_top_bar.dart';
import 'package:vems/pages/exams/widgets/questions_grid_sheet.dart';
import 'package:vems/utils/dialogue_helper.dart';
import 'package:vems/utils/exam_socket_helper.dart';
import 'package:vems/utils/snackbar_helper.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 3/4/21 at 1:03 AM
///

class ExamQuestionsPage extends StatefulWidget {
  static final routeName = '/ExamQuestionsPage';

  @override
  _ExamQuestionsPageState createState() => _ExamQuestionsPageState();
}

class _ExamQuestionsPageState extends State<ExamQuestionsPage>
    with WidgetsBindingObserver {
  int _currentIndex = 0;
  String _answer = '';
  PageController _pageController;
  bool _isLoading = false;
  String _examId = '';

  /// socket deadline timer
  Timer _timer;
  int _socketConnectionDeadLineCounter = 60;
  bool isPaused = false;

  List<ExamQuestionDatum> get _questions => ExamDetailsBloc().exam.answers;

  _jumpToQuestion(int index) {
    print("_jumpToQuestion $index");
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.linear);
    if (_questions[index].question.colorIndex != 2) {
      /// if not answered yet then view event is called
      ExamDetailsBloc().add(ViewQuestion(_questions[index].question.id));
    }
  }

  _answerSubmission({bool isSubmit = false}) {
    Get.focusScope.unfocus();
    if (_answer.isNotEmpty) {
      ExamDetailsBloc()
          .add(AnswerAQuestion(_questions[_currentIndex].question.id, _answer));
      setState(() {
        _isLoading = true;
      });
      answerQuestion(
        examId: ExamDetailsBloc().exam?.id,
        questionId: _questions[_currentIndex]?.question?.id,
        answer: _answer,
      ).then((value) {
        setState(() {
          _isLoading = false;
        });
        if (_currentIndex < _questions.length - 1) {
          _jumpToQuestion(_currentIndex + 1);
        }
        if (isSubmit) {
          // on submit
          _submitExam();
        }
      }).catchError((err, s) {
        log("ERROR", error: err, stackTrace: s);
        setState(() {
          _isLoading = false;
        });
        SnackBarHelper.show(S.of(context).oops, err?.toString());
      });
    } else {
      if (_currentIndex < _questions.length - 1) {
        _jumpToQuestion(_currentIndex + 1);
      }
      if (isSubmit) {
        // on submit
        _submitExam();
      }
    }
  }

  _submitExam() {
    showJupionDialogue(
      title: 'Do you really want to submit ?',
      description:
          "Questions answered : ${_questions.where((element) => element.question.colorIndex == 2).length} \nQuestions skipped : ${_questions.where((element) => element.question.colorIndex == 1).length} \nQuestions left : ${_questions.where((element) => element.question.colorIndex == 0).length}",
      positiveCallback: () {
        SharedPreferenceHelper.logOut();
        Get.offAllNamed(LoginPage.routeName);
        SnackBarHelper.show("Success",
            "Answers submitted successfully. Result will be published soon.");
      },
    );
  }

  /// if some interruptions occur then user will be given 1 min to comeback otherwise will be disconnected
  void _socketConnectionDeadlineTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_socketConnectionDeadLineCounter < 0) {
          // when socket connection deadline exceeds
          ExamSocketHelper.disposeSocket();
          if (_timer != null) {
            _timer.cancel();
            _timer = null;
          }
        } else {
          _socketConnectionDeadLineCounter--;
        }
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        // app comes from background to normal state
        // return to app after mastani dialogue will be shown
        if (_socketConnectionDeadLineCounter < 0) {
          Get.dialog(DisturbanceDialogue());
        }
        if (_timer != null) {
          _timer.cancel();
          _timer = null;
        }
        _socketConnectionDeadLineCounter = 60;
        isPaused = false;
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        // when app goes to background state mane exam time re mastani au
        if (isPaused == false) {
          _socketConnectionDeadlineTimer();
          isPaused = true;
        }
        break;
      case AppLifecycleState.detached:
    }
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0, keepPage: false);
    _examId = Get.arguments ?? '';
    ExamDetailsBloc().add(LoadExamDetails(_examId));
    if (_questions.length > 0) {
      ExamDetailsBloc().add(ViewQuestion(_questions[0].question.id));
    }
    Screen.keepOn(true);

    /// switch to full screen mode
    SystemChrome.setEnabledSystemUIOverlays([]); // enable full-screen mode
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _pageController.dispose();
    ExamSocketHelper.disposeSocket();
    WidgetsBinding.instance.removeObserver(this);
    Screen.keepOn(false);
    SystemChrome.setEnabledSystemUIOverlays(
        SystemUiOverlay.values); // disable full-screen mode
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showJupionDialogue(
          title: 'Do you really want to abort the examination ?',
          description:
              "All your answers will be discarded and won't be submitted",
          positiveCallback: () {
            Get.offNamedUntil(ExamsPage.routeName,
                (route) => route.settings.name == ExamsPage.routeName);
          },
        );
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
              return ExamQuestionsShimmer();
            }
            if (state is ExamDetailsLoadedState) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: Column(
                      children: [
                        ExamQuestionsTopBar(
                          examId: _examId,
                          onTap: () {
                            Get.focusScope.unfocus();
                            Get.bottomSheet(
                                QuestionsGridSheet(
                                  currentIndex: _currentIndex,
                                  onChanged: (val) {
                                    setState(() {
                                      _currentIndex = val;
                                      print("$_currentIndex");
                                      _jumpToQuestion(val);
                                      Get.back();
                                    });
                                  },
                                  onSubmit: _submitExam,
                                ),
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor);
                          },
                        ),
                        Expanded(
                          child: PageView(
                            controller: _pageController,
                            physics: NeverScrollableScrollPhysics(),
                            onPageChanged: (index) {
                              setState(() {
                                _currentIndex = index;
                                _answer = '';
                              });
                            },
                            children: _questions
                                .map((e) => ExamQuestionCard(
                                      datum: e.question,
                                      key: ValueKey(e.question.id),
                                      index: _questions.indexOf(e),
                                      answer: _answer,
                                      onChanged: (val) {
                                        _answer = val;
                                        _questions[_currentIndex].answer = val;
                                        _questions[_currentIndex]
                                            .question
                                            .myChoice = val;
                                        setState(() {});
                                      },
                                    ))
                                .toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 16,
                    left: 16,
                    child: _isLoading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                            ],
                          )
                        : ExamActionWidget(
                            currentIndex: _currentIndex,
                            isOnlySubmit:
                                _currentIndex == _questions.length - 1,
                            onSkip: () {
                              Get.focusScope.unfocus();
                              if (_currentIndex < _questions.length - 1) {
                                _jumpToQuestion(_currentIndex + 1);
                              }
                            },
                            onNext: () {
                              _answerSubmission();
                            },
                            onSubmit: () {
                              _answerSubmission(isSubmit: true);
                            },
                            onErase: _questions[_currentIndex]
                                        .question
                                        .myChoice
                                        ?.isEmpty ??
                                    true
                                ? null
                                : () {
                                    setState(() {
                                      _answer = '';
                                      _questions[_currentIndex].answer = null;
                                      _questions[_currentIndex]
                                          .question
                                          .myChoice = null;
                                    });
                                  },
                            onPrevious: () {
                              print("current ind $_currentIndex");
                              if (_currentIndex == 0) {
                                return;
                              } else if (_currentIndex < _questions.length) {
                                _jumpToQuestion(_currentIndex - 1);
                              }
                            },
                          ),
                  )
                ],
              );
            }
            return ExamQuestionsShimmer();
          }),
        ),
      ),
    );
  }
}
