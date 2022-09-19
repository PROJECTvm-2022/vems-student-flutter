import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/schedule_bloc/index.dart';
import 'package:vems/data_models/schedule_cell_datum.dart';
import 'dart:async';
import 'dart:developer' as developer;

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 4/2/21 at 2:11 PM
///

class ScheduleBloc extends Bloc<ScheduleEvent, BaseState> {
  static final ScheduleBloc _scheduleBlocSingleton = ScheduleBloc._internal();

  factory ScheduleBloc() {
    return _scheduleBlocSingleton;
  }

  ScheduleBloc._internal() : super(LoadingBaseState());

  List<TimeTableDatum> cells = [];

  @override
  Future<void> close() async {
    _scheduleBlocSingleton.close();
    await super.close();
  }

  @override
  Stream<BaseState> mapEventToState(
    ScheduleEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'ScheduleBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
