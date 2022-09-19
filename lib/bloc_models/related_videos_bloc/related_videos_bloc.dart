import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/related_videos_bloc/index.dart';
import 'package:vems/data_models/material.dart';
import 'dart:developer' as developer;

///
/// Created by Auro (auro@smarttersstudio.com) on 06/07/21 at 4:13 pm
///

class RelatedVideosBloc extends Bloc<RelatedVideoEvent, BaseState> {
  static final RelatedVideosBloc _relatedVideosBlocSingleton =
      RelatedVideosBloc._internal();

  factory RelatedVideosBloc() {
    return _relatedVideosBlocSingleton;
  }

  RelatedVideosBloc._internal() : super(LoadingBaseState());

  List<MaterialDatum> materials = [];

  @override
  Future<void> close() async {
    _relatedVideosBlocSingleton.close();
    await super.close();
  }

  @override
  Stream<BaseState> mapEventToState(
    RelatedVideoEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'RelatedVideosBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
