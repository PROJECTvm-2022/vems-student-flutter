import 'package:flutter/material.dart';
import 'package:vems/api_services/lecture_api_services.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/chapters_bloc/all_chapters_bloc/index.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 05/07/21 at 4:17 pm
///

@immutable
abstract class AllChaptersEvent {
  Stream<BaseState> applyAsync({BaseState currentState, AllChaptersBloc bloc});
}

class LoadAllChaptersEvent extends AllChaptersEvent {
  final String unitId;

  LoadAllChaptersEvent(this.unitId);

  @override
  String toString() => 'LoadAllChaptersEvent ';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, AllChaptersBloc bloc}) async* {
    try {
      bloc.chapters.clear();
      yield LoadingBaseState();
      final result = await getChapters(unitId, limit: -1);

      if (result.isEmpty) {
        yield EmptyBaseState();
      } else {
        bloc.chapters = result;
        yield AllChaptersLoadedState();
      }
    } catch (_, st) {
      print(st);
      yield ErrorBaseState(_?.toString());
    }
  }
}
