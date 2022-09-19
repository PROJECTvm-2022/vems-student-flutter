import 'package:flutter/material.dart';
import 'package:vems/api_services/assignment_services.dart';
import 'package:vems/bloc_models/assignments_bloc/upcoming_assignments_bloc/index.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/data_models/asssignment.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 08/07/21 at 9:13 am
///

@immutable
abstract class UpcomingAssignmentEvent {
  Stream<BaseState> applyAsync(
      {BaseState currentState, UpcomingAssignmentBloc bloc});
}

class LoadAssignments extends UpcomingAssignmentEvent {
  @override
  String toString() => 'LoadAssignments';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, UpcomingAssignmentBloc bloc}) async* {
    try {
      bloc.assignments.clear();
      yield LoadingBaseState();
      final result = await getAssignments(status: [2]);
      if (result.isEmpty) {
        yield EmptyBaseState();
      } else {
        bloc.assignments = result;
        yield UpcomingAssignmentLoadedState();
      }
    } catch (_, st) {
      print(st);
      print("$_ : $st");
      yield ErrorBaseState(_?.toString());
    }
  }
}

class SubmitHomeAnswer extends UpcomingAssignmentEvent {
  final StudentAssignment datum;

  SubmitHomeAnswer(this.datum);

  @override
  String toString() => 'SubmitAnswer';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, UpcomingAssignmentBloc bloc}) async* {
    try {
      if (datum != null && bloc.assignments.contains(datum)) {
        int index = bloc.assignments.indexOf(datum);
        if (index != -1) {
          StudentAssignment temp = bloc.assignments[index];
          temp.status = datum.status;
          temp.answers = datum.answers;
          bloc.assignments.removeAt(index);
          bloc.assignments.insert(index, temp);
          yield UpcomingAssignmentLoadedState();
        }
      }
    } catch (_, st) {
      print(st);
      yield currentState;
    }
  }
}
