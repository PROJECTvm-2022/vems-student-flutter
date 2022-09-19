import 'package:flutter/material.dart';
import 'package:vems/api_services/assignment_services.dart';
import 'package:vems/bloc_models/assignment_details_bloc/index.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/data_models/asssignment.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 07/07/21 at 10:10 pm
///

@immutable
abstract class AssignmentDetailsEvent {
  Stream<BaseState> applyAsync(
      {BaseState currentState, AssignmentDetailsBloc bloc});
}

class LoadDetails extends AssignmentDetailsEvent {
  final String assignmentId;

  LoadDetails(this.assignmentId);

  @override
  String toString() => 'LoadDetails';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, AssignmentDetailsBloc bloc}) async* {
    try {
      yield LoadingBaseState();
      final result = await getAssignmentDetails(assignmentId);
      if (result != null) {
        bloc.assignment = result;
        yield AssignmentDetailsLoadedState();
      }
    } catch (_, st) {
      print(st);
      yield ErrorBaseState(_?.toString());
    }
  }
}

class UpdateDatum extends AssignmentDetailsEvent {
  final StudentAssignment datum;

  UpdateDatum(this.datum);

  @override
  String toString() => 'UpdateDatum';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, AssignmentDetailsBloc bloc}) async* {
    try {
      yield LoadingBaseState();
      if (datum != null) {
        bloc.assignment.status = datum.status;
        bloc.assignment.answers = datum.answers;
        bloc.assignment.submittedAt = datum.submittedAt;
        yield AssignmentDetailsLoadedState();
      }
    } catch (_, st) {
      print(st);
      yield currentState;
    }
  }
}
