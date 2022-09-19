import 'package:flutter/material.dart';
import 'package:vems/api_services/lecture_api_services.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/units_bloc/all_units_bloc/index.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 05/07/21 at 3:57 pm
///

@immutable
abstract class AllUnitsEvent {
  Stream<BaseState> applyAsync({BaseState currentState, AllUnitsBloc bloc});
}

class LoadAllUnitsEvent extends AllUnitsEvent {
  final String syllabus;

  LoadAllUnitsEvent(this.syllabus);

  @override
  String toString() => 'LoadAllUnitsEvent ';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, AllUnitsBloc bloc}) async* {
    try {
      bloc.units.clear();
      yield LoadingBaseState();
      final result = await getUnits(syllabus, limit: -1);

      if (result.isEmpty) {
        yield EmptyBaseState();
      } else {
        bloc.units = result;
        yield AllUnitsLoadedState();
      }
    } catch (_, st) {
      print(st);
      yield ErrorBaseState(_?.toString());
    }
  }
}
