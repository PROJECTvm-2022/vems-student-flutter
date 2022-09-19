import 'package:flutter/material.dart';
import 'package:vems/api_services/question_api_services.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/video_questions_bloc/index.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 14/1/21 at 11:46 PM
///

@immutable
abstract class VideoQuestionsEvent {
  Stream<BaseState> applyAsync(
      {BaseState currentState, VideoQuestionsBloc bloc});
}

class LoadQuestionsEvent extends VideoQuestionsEvent {
  final String videoId;

  LoadQuestionsEvent(this.videoId);

  @override
  String toString() => 'LoadQuestionsEvent';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, VideoQuestionsBloc bloc}) async* {
    try {
      bloc.questions.clear();
      bloc.total = 0;
      yield LoadingBaseState();
      final result = await getVideoQuestions(videoId);

      bloc.total = result.length;
      if (result.isEmpty) {
        yield EmptyBaseState();
      } else {
        bloc.questions = result;
        yield VideoQuestionsLoadedState();
      }
    } catch (_, st) {
      print(st);
      yield ErrorBaseState(_?.toString());
    }
  }
}

// class AnswerAQuestion extends VideoQuestionsEvent {
//   final StudentAnswerDatum tempDatum;
//
//   AnswerAQuestion(this.tempDatum);
//
//   @override
//   String toString() => 'AnswerAQuestion';
//
//   @override
//   Stream<BaseState> applyAsync(
//       {BaseState currentState, VideoQuestionsBloc bloc}) async* {
//     try {
//       QuestionDatum datum = bloc.questions
//           .where((element) => element.id == tempDatum.question)
//           .toList()
//           .first;
//       int index = bloc.questions.indexOf(datum);
//       bloc.questions[index].studentAnswer = tempDatum;
//       yield VideoQuestionsLoadedState();
//       var result = await answerAQuestion(
//           tempDatum.question, tempDatum.attempts.last.answer);
//       bloc.questions[index].studentAnswer = result;
//       yield VideoQuestionsLoadedState();
//     } catch (_) {
//       yield currentState;
//     }
//   }
// }
