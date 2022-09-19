import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/chapters_bloc/all_chapters_bloc/index.dart';
import 'package:vems/data_models/chapter_data.dart';
import 'dart:developer' as developer;

///
/// Created by Auro (auro@smarttersstudio.com) on 05/07/21 at 4:17 pm
///

class AllChaptersBloc extends Bloc<AllChaptersEvent, BaseState> {
  static final AllChaptersBloc _allChaptersBlocSingleton =
      AllChaptersBloc._internal();

  factory AllChaptersBloc() {
    return _allChaptersBlocSingleton;
  }

  AllChaptersBloc._internal() : super(LoadingBaseState());

  List<ChapterDatum> chapters = [];

  @override
  Future<void> close() async {
    _allChaptersBlocSingleton.close();
    await super.close();
  }

  @override
  Stream<BaseState> mapEventToState(
    AllChaptersEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'AllChaptersBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
