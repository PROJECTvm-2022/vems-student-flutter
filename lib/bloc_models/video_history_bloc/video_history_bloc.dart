import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/video_history_bloc/index.dart';
import 'package:vems/data_models/video_data.dart';
import 'dart:async';
import 'dart:developer' as developer;

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 14/4/21 at 9:10 PM
///

class VideoHistoryBloc extends Bloc<VideoHistoryEvent, BaseState> {
  static final VideoHistoryBloc _videoHistoryBlocSingleton =
      VideoHistoryBloc._internal();

  factory VideoHistoryBloc() {
    return _videoHistoryBlocSingleton;
  }

  VideoHistoryBloc._internal() : super(LoadingBaseState());

  List<StudentVideoDatum> videos = [];

  @override
  Future<void> close() async {
    _videoHistoryBlocSingleton.close();
    await super.close();
  }

  @override
  Stream<BaseState> mapEventToState(
    VideoHistoryEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'VideoHistoryBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
