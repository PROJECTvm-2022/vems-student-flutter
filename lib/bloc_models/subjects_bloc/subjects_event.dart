import 'package:flutter/material.dart';
import 'package:vems/api_services/lecture_api_services.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/subjects_bloc/index.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 11/1/21 at 9:52 PM
///

@immutable
abstract class SubjectsEvent {
  Stream<BaseState> applyAsync({BaseState currentState, SubjectsBloc bloc});
}

class LoadSubjectsEvent extends SubjectsEvent {
  @override
  String toString() => 'LoadSubjectsEvent ';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, SubjectsBloc bloc}) async* {
    try {
      bloc.subjects.clear();
      yield LoadingBaseState();
      final result = await getSubjects();

      if (result.isEmpty) {
        yield EmptyBaseState();
      } else {
        bloc.subjects = result;
        yield SubjectLoadedState();
      }
    } catch (_, st) {
      print(st);
      yield ErrorBaseState(_?.toString());
    }
  }
}
