import 'package:flutter/material.dart';
import 'package:vems/api_services/live_classes_api_services.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/live_quize_bloc/index.dart';
import 'package:vems/data_models/live_chat_data.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 3/5/21 at 9:56 PM
///

@immutable
abstract class LiveQuizEvent {
  Stream<BaseState> applyAsync({BaseState currentState, LiveQuizBloc bloc});
}

class AddCurrentQuiz extends LiveQuizEvent {
  final LiveChatDatum datum;

  AddCurrentQuiz(this.datum);

  @override
  String toString() => 'AddCurrentQuiz';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, LiveQuizBloc bloc}) async* {
    try {
      bloc.currentQuiz = datum;
      yield LiveQuizLoadedState();
    } catch (_, st) {
      print(st);
      yield currentState;
    }
  }
}

class AddQuizAnswer extends LiveQuizEvent {
  final LiveChatDatum datum;

  AddQuizAnswer(this.datum);

  @override
  String toString() => 'AddQuizAnswer';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, LiveQuizBloc bloc}) async* {
    try {
      bloc.currentQuiz.entityId = datum;
      yield LiveQuizLoadedState();
    } catch (_, st) {
      print(st);
      yield currentState;
    }
  }
}

class LoadQuiz extends LiveQuizEvent {
  final String liveClass;

  LoadQuiz(this.liveClass);

  @override
  String toString() => 'LoadQuiz';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, LiveQuizBloc bloc}) async* {
    try {
      bloc.quizSkip = 0;
      bloc.shouldLoadMore = true;
      bloc.quizList.clear();
      yield LoadingBaseState();
      final result =
          await getQuiz(liveClass, skip: bloc.quizSkip, limit: bloc.quizLimit);

      if (result.isEmpty) {
        bloc.quizSkip = 0;
        bloc.shouldLoadMore = false;
        yield EmptyBaseState();
      } else {
        if (result.length < bloc.quizLimit) {
          bloc.shouldLoadMore = false;
        }
        bloc.quizList = result;
        yield LiveQuizLoadedState();
      }
    } catch (_, st) {
      print(st);
      yield ErrorBaseState(_?.toString());
    }
  }
}

class LoadMoreQuiz extends LiveQuizEvent {
  final String liveClass;

  LoadMoreQuiz(this.liveClass);

  @override
  String toString() => 'LoadMoreQuiz';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, LiveQuizBloc bloc}) async* {
    try {
      if (bloc.shouldLoadMore) {
        bloc.quizSkip = bloc.quizList.length;

        final result = await getQuiz(liveClass,
            skip: bloc.quizSkip, limit: bloc.quizLimit);

        if (result.isEmpty || result.length < bloc.quizLimit) {
          bloc.shouldLoadMore = false;
        }
        bloc.quizList += result;
        yield LiveQuizLoadedState();
      } else {
        yield currentState;
      }
    } catch (_) {
      yield currentState;
    }
  }
}

/// to store the current screen state
class SetScreenState extends LiveQuizEvent {
  final bool isLandscape;

  SetScreenState(this.isLandscape);

  @override
  String toString() => 'SetScreenState';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, LiveQuizBloc bloc}) async* {
    try {
      bloc.isLandscape = isLandscape;
    } catch (_) {
      yield currentState;
    }
  }
}
