import 'package:flutter/material.dart';
import 'package:vems/api_services/lecture_api_services.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/chapters_bloc/index.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 11/1/21 at 9:55 PM
///

@immutable
abstract class ChaptersEvent {
  Stream<BaseState> applyAsync({BaseState currentState, ChaptersBloc bloc});
}

class LoadChaptersEvent extends ChaptersEvent {
  final String unit;

  LoadChaptersEvent(this.unit);

  @override
  String toString() => 'LoadChaptersEvent';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, ChaptersBloc bloc}) async* {
    try {
      bloc.chapterSkip = 0;
      bloc.shouldLoadMore = true;
      bloc.chapters.clear();
      yield LoadingBaseState();
      final result = await getChapters(unit,
          skip: bloc.chapterSkip, limit: bloc.chapterLimit);

      if (result.isEmpty) {
        bloc.chapterSkip = 0;
        bloc.shouldLoadMore = false;
        yield EmptyBaseState();
      } else {
        if (result.isEmpty || result.length < bloc.chapterLimit) {
          bloc.shouldLoadMore = false;
        }
        bloc.chapters = result;
        yield ChaptersLoadedState();
      }
    } catch (_, st) {
      print(st);
      yield ErrorBaseState(_?.toString());
    }
  }
}

class LoadMoreChapters extends ChaptersEvent {
  final String unit;

  LoadMoreChapters(this.unit);

  @override
  String toString() => 'LoadMoreChapters';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, ChaptersBloc bloc}) async* {
    try {
      if (bloc.shouldLoadMore) {
        bloc.chapterSkip = bloc.chapters.length;

        final result = await getChapters(unit,
            skip: bloc.chapterSkip, limit: bloc.chapterLimit);

        if (result.isEmpty || result.length < bloc.chapterLimit) {
          bloc.shouldLoadMore = false;
        }
        bloc.chapters += result;
        yield ChaptersLoadedState();
      } else {
        yield currentState;
      }
    } catch (_) {
      yield currentState;
    }
  }
}
