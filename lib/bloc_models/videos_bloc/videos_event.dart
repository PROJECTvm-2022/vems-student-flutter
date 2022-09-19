import 'package:flutter/material.dart';
import 'package:vems/api_services/lecture_api_services.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/videos_bloc/index.dart';
import 'package:vems/data_models/video_data.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 11/1/21 at 9:56 PM
///

@immutable
abstract class VideosEvent {
  Stream<BaseState> applyAsync({BaseState currentState, VideosBloc bloc});
}

class LoadVideosEvent extends VideosEvent {
  final String chapter;
  final String query;

  LoadVideosEvent(this.chapter, {this.query = ''});

  @override
  String toString() => 'LoadVideosEvent';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, VideosBloc bloc}) async* {
    try {
      bloc.videoSkip = 0;
      bloc.shouldLoadMore = true;
      bloc.videos.clear();
      yield LoadingBaseState();
      final result = await getVideos(
        chapter,
        skip: bloc.videoSkip,
        limit: bloc.videoLimit,
        title: query,
      );

      if (result.isEmpty) {
        bloc.videoSkip = 0;
        bloc.shouldLoadMore = false;
        yield EmptyBaseState();
      } else {
        if (result.isEmpty || result.length < bloc.videoLimit) {
          bloc.shouldLoadMore = false;
        }
        bloc.videos = result;
        yield VideosLoadedState();
      }
    } catch (_, st) {
      print(st);
      yield ErrorBaseState(_?.toString());
    }
  }
}

class LoadMoreVideos extends VideosEvent {
  final String chapter;
  final String query;

  LoadMoreVideos(this.chapter, {this.query = ''});

  @override
  String toString() => 'LoadMoreVideos';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, VideosBloc bloc}) async* {
    try {
      if (bloc.shouldLoadMore) {
        bloc.videoSkip = bloc.videos.length;

        final result = await getVideos(
          chapter,
          limit: bloc.videoLimit,
          skip: bloc.videoSkip,
          title: query,
        );

        if (result.isEmpty || result.length < bloc.videoLimit) {
          bloc.shouldLoadMore = false;
        }
        bloc.videos += result;
        yield VideosLoadedState();
      } else {
        yield currentState;
      }
    } catch (_) {
      yield currentState;
    }
  }
}

class UpdateCommentCount extends VideosEvent {
  final String videoId;
  final bool isDecrement;

  UpdateCommentCount({this.videoId = '', this.isDecrement = false});

  @override
  String toString() => 'UpdateCommentCount';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, VideosBloc bloc}) async* {
    try {
      StudentVideoDatum tempDatum = bloc.videos
          .where((element) => element.instituteBatchVideo.id == videoId)
          .first;
      int index = bloc.videos.indexOf(tempDatum);
      bloc.videos.remove(tempDatum);
      if (isDecrement) {
        tempDatum.instituteBatchVideo.publicCommentCount -= 1;
      } else {
        tempDatum.instituteBatchVideo.publicCommentCount += 1;
      }
      bloc.videos.insert(index, tempDatum);
      yield VideosLoadedState();
    } catch (_, st) {
      print(st);
      yield currentState;
    }
  }
}

class AddVideosToBloc extends VideosEvent {
  final List<StudentVideoDatum> videos;

  AddVideosToBloc(this.videos);

  @override
  String toString() => 'LoadMoreVideos';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, VideosBloc bloc}) async* {
    try {
      if (videos != null) {
        if (videos.isEmpty || videos.length < bloc.videoLimit) {
          bloc.shouldLoadMore = false;
        }
        bloc.videos += videos;
        yield VideosLoadedState();
      } else {
        yield currentState;
      }
    } catch (_) {
      yield currentState;
    }
  }
}

class UnlockVideo extends VideosEvent {
  final String videoId;

  UnlockVideo(this.videoId);

  @override
  String toString() => 'LoadMoreVideos';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, VideosBloc bloc}) async* {
    try {
      if (videoId.isNotEmpty) {
        StudentVideoDatum tempDatum = bloc.videos
            .where((element) => element.instituteBatchVideo.id == videoId)
            .first;
        int index = bloc.videos.indexOf(tempDatum);
        bloc.videos.remove(tempDatum);
        tempDatum.status = 1;
        bloc.videos.insert(index, tempDatum);
        yield VideosLoadedState();
      } else {
        yield currentState;
      }
    } catch (_) {
      yield currentState;
    }
  }
}

class ClearVideos extends VideosEvent {
  @override
  String toString() => 'ClearVideos';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, VideosBloc bloc}) async* {
    try {
      bloc.videos.clear();
      bloc.videoSkip = 0;
      bloc.videoLimit = 10;
    } catch (_) {
      yield currentState;
    }
  }
}
