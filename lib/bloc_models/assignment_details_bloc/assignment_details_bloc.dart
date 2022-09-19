import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/assignment_details_bloc/index.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/data_models/asssignment.dart';
import 'dart:developer' as developer;

///
/// Created by Auro (auro@smarttersstudio.com) on 07/07/21 at 10:10 pm
///

class AssignmentDetailsBloc extends Bloc<AssignmentDetailsEvent, BaseState> {
  static final AssignmentDetailsBloc _assignmentDetailsBlocSingleton =
      AssignmentDetailsBloc._internal();

  factory AssignmentDetailsBloc() {
    return _assignmentDetailsBlocSingleton;
  }

  AssignmentDetailsBloc._internal() : super(LoadingBaseState());

  StudentAssignment assignment = StudentAssignment();

  @override
  Future<void> close() async {
    _assignmentDetailsBlocSingleton.close();
    await super.close();
  }

  @override
  Stream<BaseState> mapEventToState(
    AssignmentDetailsEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'AssignmentDetailsBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
