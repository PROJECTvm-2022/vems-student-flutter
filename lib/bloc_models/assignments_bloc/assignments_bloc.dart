import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/assignments_bloc/index.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/data_models/asssignment.dart';
import 'dart:developer' as developer;

///
/// Created by Auro (auro@smarttersstudio.com) on 07/07/21 at 9:57 pm
///

class AssignmentBloc extends Bloc<AssignmentEvent, BaseState> {
  static final AssignmentBloc _assignmentBlocSingleton =
      AssignmentBloc._internal();

  factory AssignmentBloc() {
    return _assignmentBlocSingleton;
  }

  AssignmentBloc._internal() : super(LoadingBaseState());

  List<StudentAssignment> assignments = [];

  @override
  Future<void> close() async {
    _assignmentBlocSingleton.close();
    await super.close();
  }

  @override
  Stream<BaseState> mapEventToState(
    AssignmentEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'AssignmentBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
