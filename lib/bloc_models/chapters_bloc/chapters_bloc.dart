import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/chapters_bloc/index.dart';
import 'dart:async';
import 'dart:developer' as developer;

import 'package:vems/data_models/chapter_data.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 11/1/21 at 9:55 PM
///

class ChaptersBloc extends Bloc<ChaptersEvent, BaseState> {
  static final ChaptersBloc _chaptersBlocSingleton = ChaptersBloc._internal();

  factory ChaptersBloc() {
    return _chaptersBlocSingleton;
  }

  ChaptersBloc._internal() : super(LoadingBaseState());

  List<ChapterDatum> chapters = [];
  int chapterSkip = 0;
  int chapterLimit = 20;
  bool shouldLoadMore = true;

  @override
  Future<void> close() async {
    _chaptersBlocSingleton.close();
    await super.close();
  }

  @override
  Stream<BaseState> mapEventToState(
    ChaptersEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'ChaptersBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
