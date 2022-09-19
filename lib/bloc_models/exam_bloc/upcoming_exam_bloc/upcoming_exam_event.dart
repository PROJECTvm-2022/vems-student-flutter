import 'package:flutter/material.dart';
import 'package:vems/api_services/exam_api_services.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/exam_bloc/upcoming_exam_bloc/index.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 14/4/21 at 7:34 PM
///

@immutable
abstract class UpcomingExamsEvent {
  Stream<BaseState> applyAsync(
      {BaseState currentState, UpcomingExamsBloc bloc});
}

class LoadUpcomingExamsEvent extends UpcomingExamsEvent {
  @override
  String toString() => 'LoadUpcomingExamsEvent';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, UpcomingExamsBloc bloc}) async* {
    try {
      bloc.examSkip = 0;
      bloc.exams.clear();
      yield LoadingBaseState();
      final result =
          await getUpcomingExams(skip: bloc.examSkip, limit: bloc.examLimit);

      if (result.isEmpty) {
        bloc.examSkip = 0;
        yield EmptyBaseState();
      } else {
        bloc.exams = result;
        yield UpcomingExamsLoadedState();
      }
    } catch (_, st) {
      print(st);
      yield ErrorBaseState(_?.toString());
    }
  }
}
