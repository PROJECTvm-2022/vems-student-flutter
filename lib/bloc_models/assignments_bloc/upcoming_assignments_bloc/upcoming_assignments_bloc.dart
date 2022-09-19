import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/assignments_bloc/upcoming_assignments_bloc/index.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/data_models/asssignment.dart';
import 'dart:developer' as developer;

///
/// Created by Auro (auro@smarttersstudio.com) on 08/07/21 at 9:12 am
///

class UpcomingAssignmentBloc extends Bloc<UpcomingAssignmentEvent, BaseState> {
  static final UpcomingAssignmentBloc _upcomingAssignmentBlocSingleton =
      UpcomingAssignmentBloc._internal();

  factory UpcomingAssignmentBloc() {
    return _upcomingAssignmentBlocSingleton;
  }

  UpcomingAssignmentBloc._internal() : super(LoadingBaseState());

  List<StudentAssignment> assignments = [];

  @override
  Future<void> close() async {
    _upcomingAssignmentBlocSingleton.close();
    await super.close();
  }

  @override
  Stream<BaseState> mapEventToState(
    UpcomingAssignmentEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'UpcomingAssignmentBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
