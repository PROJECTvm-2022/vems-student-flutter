import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:vems/api_services/question_api_services.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/video_questions_bloc/index.dart';
import 'package:vems/bloc_models/videos_bloc/index.dart';
import 'package:vems/config/index.dart';
import 'package:vems/data_models/question_data.dart';
import 'package:vems/data_models/video_data.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/video_player/questions/widgets/mcq_question_card.dart';
import 'package:vems/pages/video_player/questions/widgets/question_actions_widget.dart';
import 'package:vems/pages/video_player/questions/widgets/question_empty_widget.dart';
import 'package:vems/pages/video_player/questions/widgets/video_questions_success_widget.dart';
import 'package:vems/pages/video_player/questions/widgets/view_result_widget.dart';
import 'package:vems/utils/snackbar_helper.dart';
import 'package:vems/widgets/back_button.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 14/1/21 at 6:20 PM
///

class QuestionsWidget extends StatefulWidget {
  final VoidCallback onFinish;
  final VoidCallback onBack;
  final StudentVideoDatum studentVideoDatum;

  const QuestionsWidget(
      {Key key, this.onFinish, this.studentVideoDatum, this.onBack})
      : super(key: key);

  @override
  _QuestionsWidgetState createState() => _QuestionsWidgetState();
}

class _QuestionsWidgetState extends State<QuestionsWidget> {
  PageController _pageController;
  int currentIndex = 0;
  bool _isCompleted = false;
  bool _viewResult = false;
  bool _isLoading = false;
  List<QuestionAnswerDatum> answers = [];
  StudentVideoAnswers answerResponse;

  VideoQuestionsBloc get _questionBloc => VideoQuestionsBloc();

  List<QuestionDatum> get _questions => VideoQuestionsBloc().questions;

  VideoDatum get videoDatum => widget.studentVideoDatum.videoId;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    _questionBloc.add(LoadQuestionsEvent(videoDatum.id));
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    return Container(
      height: height / 1.65,
      width: double.infinity,
      color: Theme.of(context).canvasColor,
      child: BlocBuilder<VideoQuestionsBloc, BaseState>(
          builder: (context, BaseState state) {
        if (state is ErrorBaseState) {
          return Center(
            child: Text(state.errorMessage),
          );
        }
        if (state is EmptyBaseState) {
          return QuestionsEmptyWidget(
            onFinish: widget.onFinish,
          );
        }
        if (state is LoadingBaseState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is VideoQuestionsLoadedState) {
          return _isCompleted
              ? AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  child: _viewResult
                      ? ViewResultWidget(
                          questions: _questions,
                          answers: answerResponse.answers,
                          onNext: widget.onFinish,
                          onBack: () {
                            setState(() {
                              _viewResult = false;
                            });
                          },
                        )
                      : VideoQuestionsSuccessPage(
                          onViewResult: () {
                            setState(() {
                              _viewResult = true;
                            });
                          },
                          onFinish: widget.onFinish,
                        ),
                )
              : Stack(
                  children: [
                    Positioned.fill(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppBar(
                            leading: MyBackButton(
                              onTap: widget.onBack,
                            ),
                            centerTitle: true,
                            title: Text(
                              "${_questionBloc.total - currentIndex - 1} / ${_questionBloc.total} questions left",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: MyColors.hardGrey,
                              ),
                            ),
                            titleSpacing: 0,
                            elevation: 1,
                            backgroundColor:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.white
                                    : MyColors.darkTFColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                            child: Text(
                              videoDatum.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: MyColors.hardGrey,
                              ),
                            ),
                          ),
                          Expanded(
                            child: PageView(
                              controller: _pageController,
                              physics: NeverScrollableScrollPhysics(),
                              onPageChanged: (index) {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                              children: _questions
                                  .map((datum) => MCQQuestionCard(
                                        answers: answers,
                                        datum: datum,
                                        onChanged: (value) {
                                          setState(() {
                                            if (answers.contains(value)) {
                                              answers.remove(value);
                                              answers.add(value);
                                            } else {
                                              answers.add(value);
                                            }
                                          });
                                        },
                                      ))
                                  .toList(),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      right: 16,
                      left: 16,
                      bottom: 10,
                      child: _isLoading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [CircularProgressIndicator()],
                            )
                          : QuestionActionsWidget(
                              isOnlyNext: currentIndex == 0,
                              isOnlyFinish:
                                  currentIndex == _questionBloc.total - 1,
                              onBack: () {
                                _pageController.previousPage(
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.linear);
                              },
                              onNext: !answers.contains(QuestionAnswerDatum(
                                question: _questions[currentIndex].id,
                              ))
                                  ? null
                                  : () {
                                      if (currentIndex ==
                                          _questionBloc.total - 1) {
                                        List<Map<String, String>> _answers = [];
                                        answers.forEach((element) {
                                          _answers.add({
                                            "question": element.question,
                                            "answer": element.answer
                                          });
                                        });
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        answerVideoQuestion({
                                          "answers": _answers,
                                          "studentVideo":
                                              widget.studentVideoDatum.id,
                                        }).then((value) {
                                          // success
                                          setState(() {
                                            _isLoading = false;
                                            _isCompleted = true;
                                            answerResponse = value;
                                          });

                                          /// unlock video locally
                                          VideosBloc().add(UnlockVideo(
                                              value.videoTobeUnlocked));
                                        }).catchError((err, s) {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          SnackBarHelper.show(
                                              S.of(context).error,
                                              err?.toString());
                                        });
                                      } else {
                                        _pageController.nextPage(
                                            duration:
                                                Duration(milliseconds: 200),
                                            curve: Curves.linear);
                                      }
                                    },
                            ),
                    )
                  ],
                );
        }
        return SizedBox();
      }),
    );
  }
}
