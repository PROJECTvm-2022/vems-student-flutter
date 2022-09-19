import 'package:flutter/material.dart';
import 'package:vems/api_services/exam_api_services.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/exam_bloc/exam_details_bloc/index.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 7/4/21 at 5:22 PM
///

@immutable
abstract class ExamDetailsEvent {
  Stream<BaseState> applyAsync({BaseState currentState, ExamDetailsBloc bloc});
}

class LoadExamDetails extends ExamDetailsEvent {
  final String examId;

  LoadExamDetails(this.examId);

  @override
  String toString() => 'LoadExamDetails';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, ExamDetailsBloc bloc}) async* {
    try {
      yield LoadingBaseState();
      final result = await getExamDetails(examId);

      if (result != null) {
        bloc.exam = result;
        yield ExamDetailsLoadedState();

        bloc.exam.answers.forEach((element1) {
          element1.question.myChoice = element1.answer ?? '';
        });
      } else {
        yield currentState;
      }
    } catch (_, st) {
      print(st);
      yield ErrorBaseState(_?.toString());
    }
  }
}

class AnswerAQuestion extends ExamDetailsEvent {
  final String questionId;
  final String choice;

  AnswerAQuestion(this.questionId, this.choice);

  @override
  String toString() => 'AnswerAQuestion';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, ExamDetailsBloc bloc}) async* {
    try {
      bloc.exam.answers
          .where((element) => element.question.id == questionId)
          .toList()[0]
          .question
          .myChoice = choice;
      bloc.exam.answers
          .where((element) => element.question.id == questionId)
          .toList()[0]
          .question
          .colorIndex = 2;
      yield ExamDetailsLoadedState();
    } catch (_, st) {
      print(st);
      yield currentState;
    }
  }
}

class ViewQuestion extends ExamDetailsEvent {
  final String questionId;

  ViewQuestion(this.questionId);

  @override
  String toString() => 'ViewQuestion';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, ExamDetailsBloc bloc}) async* {
    try {
      bloc.exam.answers
          .where((element) => element.question.id == questionId)
          .toList()[0]
          .question
          .colorIndex = 1;
      yield ExamDetailsLoadedState();
    } catch (_, st) {
      print(st);
      yield currentState;
    }
  }
}

class ExamStatusChange extends ExamDetailsEvent {
  final int status;

  ExamStatusChange(this.status);

  @override
  String toString() => 'ViewQuestion';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, ExamDetailsBloc bloc}) async* {
    try {
      if (status != null) {
        bloc.exam.status = status;
        print("status in bloc $status ::::: ${bloc.exam.status}");
        yield ExamDetailsLoadedState();
      }
    } catch (_, st) {
      print(st);
      yield currentState;
    }
  }
}
