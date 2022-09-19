import 'package:flutter/material.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/video_history_bloc/index.dart';
import 'package:vems/data_models/video_data.dart';
import 'package:vems/utils/shared_preference_helper.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 14/4/21 at 9:10 PM
///

@immutable
abstract class VideoHistoryEvent {
  Stream<BaseState> applyAsync({BaseState currentState, VideoHistoryBloc bloc});
}

class LoadVideoHistory extends VideoHistoryEvent {
  @override
  String toString() => 'LoadVideoHistory';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, VideoHistoryBloc bloc}) async* {
    try {
      yield LoadingBaseState();
      final result = SharedPreferenceHelper.storedVideos;

      if (result != null) {
        if (result.isEmpty) {
          bloc.videos.clear();
          yield EmptyBaseState();
        } else {
          bloc.videos = result;
          yield VideoHistoryLoadedState();
        }
      } else {
        yield currentState;
      }
    } catch (_, st) {
      print(st);
      yield ErrorBaseState(_?.toString());
    }
  }
}

class AddVideoToHistory extends VideoHistoryEvent {
  final StudentVideoDatum video;

  AddVideoToHistory(this.video);

  @override
  String toString() => 'AddVideoToHistory';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, VideoHistoryBloc bloc}) async* {
    try {
      if (video != null) {
        if (bloc.videos.contains(video)) {
          bloc.videos.remove(video);
        }
        if (bloc.videos.length >= 4) {
          bloc.videos.removeLast();
          bloc.videos.insert(0, video);
        } else {
          bloc.videos.insert(0, video);
        }
        SharedPreferenceHelper.storeVideoHistory(bloc.videos);
        yield VideoHistoryLoadedState();
      }
    } catch (_, st) {
      print(st);
      yield currentState;
    }
  }
}

class SaveVideoWatchTime extends VideoHistoryEvent {
  final String videoId;
  final int seconds;

  SaveVideoWatchTime({this.videoId = '', this.seconds = 0});

  @override
  String toString() => 'SaveVideoWatchTime';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, VideoHistoryBloc bloc}) async* {
    try {
      if (videoId != null && seconds != null) {
        bloc.videos.forEach((element) {
          int index = bloc.videos.indexOf(element);
          if (element.id == videoId) {
            StudentVideoDatum datum = bloc.videos[index];
            datum.videoId.secondsWatched = seconds;
            bloc.videos[index].videoId.secondsWatched = seconds;
            bloc.add(AddVideoToHistory(datum));
          }
        });
        yield VideoHistoryLoadedState();
      }
    } catch (_, st) {
      print(st);
      yield currentState;
    }
  }
}
