import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/videos_bloc/index.dart';
import 'package:vems/data_models/video_data.dart';
import 'dart:async';
import 'dart:developer' as developer;

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 11/1/21 at 9:56 PM
///

class VideosBloc extends Bloc<VideosEvent, BaseState> {
  static final VideosBloc _videosBlocSingleton = VideosBloc._internal();

  factory VideosBloc() {
    return _videosBlocSingleton;
  }

  VideosBloc._internal() : super(LoadingBaseState());

  List<StudentVideoDatum> videos = [];
  int videoSkip = 0;
  int videoLimit = 20;
  bool shouldLoadMore = true;

  @override
  Future<void> close() async {
    _videosBlocSingleton.close();
    await super.close();
  }

  @override
  Stream<BaseState> mapEventToState(
    VideosEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'VideosBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
