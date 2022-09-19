import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vems/api_services/exam_api_services.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/exam_bloc/exams_bloc/index.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 7/4/21 at 10:36 AM
///

@immutable
abstract class ExamsEvent {
  Stream<BaseState> applyAsync({BaseState currentState, ExamsBloc bloc});
}

class LoadExamsEvent extends ExamsEvent {
  @override
  String toString() => 'LoadExamsEvent';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, ExamsBloc bloc}) async* {
    try {
      bloc.examSkip = 0;
      bloc.shouldLoadMore = true;
      bloc.exams.clear();
      yield LoadingBaseState();
      final result = await getExams(skip: bloc.examSkip, limit: bloc.examLimit);

      if (result.isEmpty) {
        bloc.examSkip = 0;
        bloc.shouldLoadMore = false;
        yield EmptyBaseState();
      } else {
        if (result.isEmpty || result.length < bloc.examLimit) {
          bloc.shouldLoadMore = false;
        }
        bloc.exams = result;
        yield ExamsLoadedState();
      }
    } catch (e, s) {
      log("Error", error: e, stackTrace: s);
      yield ErrorBaseState(e?.toString());
    }
  }
}

class LoadMoreExams extends ExamsEvent {
  @override
  String toString() => 'LoadMoreExams';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, ExamsBloc bloc}) async* {
    try {
      if (bloc.shouldLoadMore) {
        bloc.examSkip = bloc.exams.length;

        final result =
            await getExams(skip: bloc.examSkip, limit: bloc.examLimit);

        if (result.isEmpty || result.length < bloc.examLimit) {
          bloc.shouldLoadMore = false;
        }
        bloc.exams += result;
        yield ExamsLoadedState();
      } else {
        yield currentState;
      }
    } catch (_) {
      yield currentState;
    }
  }
}
