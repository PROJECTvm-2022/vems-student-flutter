import 'package:flutter/material.dart';
import 'package:vems/api_services/assignment_services.dart';
import 'package:vems/bloc_models/assignments_bloc/index.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/data_models/asssignment.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 07/07/21 at 9:57 pm
///

@immutable
abstract class AssignmentEvent {
  Stream<BaseState> applyAsync({BaseState currentState, AssignmentBloc bloc});
}

class LoadAssignments extends AssignmentEvent {
  final List<int> types;

  LoadAssignments(this.types);

  @override
  String toString() => 'LoadAssignments';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, AssignmentBloc bloc}) async* {
    try {
      bloc.assignments.clear();
      yield LoadingBaseState();
      final result = await getAssignments(status: types);
      if (result.isEmpty) {
        yield EmptyBaseState();
      } else {
        bloc.assignments = result;
        yield AssignmentLoadedState();
      }
    } catch (_, st) {
      print(st);
      yield ErrorBaseState(_?.toString());
    }
  }
}

class SubmitAnswer extends AssignmentEvent {
  final StudentAssignment datum;

  SubmitAnswer(this.datum);

  @override
  String toString() => 'SubmitAnswer';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, AssignmentBloc bloc}) async* {
    try {
      if (datum != null && bloc.assignments.contains(datum)) {
        int index = bloc.assignments.indexOf(datum);
        if (index != -1) {
          StudentAssignment temp = bloc.assignments[index];
          temp.status = datum.status;
          temp.answers = datum.answers;
          bloc.assignments.removeAt(index);
          bloc.assignments.insert(index, temp);
          yield AssignmentLoadedState();
        }
      }
    } catch (_, st) {
      print(st);
      yield currentState;
    }
  }
}
