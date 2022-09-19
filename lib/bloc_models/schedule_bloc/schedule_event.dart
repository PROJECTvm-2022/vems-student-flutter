import 'package:flutter/material.dart';
import 'package:vems/api_services/schedule_api_services.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/schedule_bloc/index.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 4/2/21 at 2:11 PM
///

@immutable
abstract class ScheduleEvent {
  Stream<BaseState> applyAsync({BaseState currentState, ScheduleBloc bloc});
}

class LoadSchedulesEvent extends ScheduleEvent {
  @override
  String toString() => 'LoadSchedulesEvent';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, ScheduleBloc bloc}) async* {
    try {
      bloc.cells.clear();
      yield LoadingBaseState();
      final result = await getSchedule();

      if (result.isEmpty) {
        yield EmptyBaseState();
      } else {
        bloc.cells = result;
        yield ScheduleLoadedState();
      }
    } catch (_, st) {
      print(st);
      yield ErrorBaseState(_?.toString());
    }
  }
}
