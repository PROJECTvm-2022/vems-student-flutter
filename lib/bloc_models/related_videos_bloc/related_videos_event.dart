import 'package:flutter/material.dart';
import 'package:vems/api_services/material_services.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/related_videos_bloc/index.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 06/07/21 at 4:13 pm
///

@immutable
abstract class RelatedVideoEvent {
  Stream<BaseState> applyAsync(
      {BaseState currentState, RelatedVideosBloc bloc});
}

class LoadMoreRelatedVideos extends RelatedVideoEvent {
  final String currentVideoId;

  LoadMoreRelatedVideos(this.currentVideoId);

  @override
  String toString() => 'LoadMoreRelatedVideos';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, RelatedVideosBloc bloc}) async* {
    try {
      bloc.materials.clear();
      yield LoadingBaseState();
      final result = await getRelatedVideos(currentVideoId);
      if (result.isEmpty) {
        yield EmptyBaseState();
      } else {
        bloc.materials = result;
        yield AllRelatedVideosLoadedState();
      }
    } catch (_, st) {
      print(st);
      yield ErrorBaseState(_?.toString());
    }
  }
}
