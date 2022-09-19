import 'package:flutter/material.dart';
import 'package:vems/api_services/live_classes_api_services.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/live_class_bloc/index.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 9/3/21 at 9:49 PM
///

@immutable
abstract class LiveClassEvent {
  Stream<BaseState> applyAsync({BaseState currentState, LiveClassBloc bloc});
}

class LoadClassesEvent extends LiveClassEvent {
  @override
  String toString() => 'LoadClassesEvent';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, LiveClassBloc bloc}) async* {
    try {
      bloc.classes.clear();
      yield LoadingBaseState();
      final result = await getLiveClasses(isScheduled: false);

      if (result.isEmpty) {
        yield EmptyBaseState();
      } else {
        bloc.classes = result;
        yield LiveClassLoadedState();
      }
    } catch (_, st) {
      print(st);
      yield ErrorBaseState(_?.toString());
    }
  }
}

class LoadUpcomingClasses extends LiveClassEvent {
  @override
  String toString() => 'LoadUpcomingClasses';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, LiveClassBloc bloc}) async* {
    try {
      bloc.classes.clear();
      yield LoadingBaseState();
      final result = await getLiveClasses(isScheduled: true);

      if (result.isEmpty) {
        yield EmptyBaseState();
      } else {
        bloc.classes = result;
        yield LiveClassLoadedState();
      }
    } catch (_, st) {
      print(st);
      yield ErrorBaseState(_?.toString());
    }
  }
}
