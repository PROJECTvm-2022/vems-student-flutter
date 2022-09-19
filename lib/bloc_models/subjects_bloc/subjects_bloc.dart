import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/subjects_bloc/index.dart';
import 'package:vems/data_models/subject_data.dart';
import 'dart:async';
import 'dart:developer' as developer;

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 11/1/21 at 9:52 PM
///

class SubjectsBloc extends Bloc<SubjectsEvent, BaseState> {
  static final SubjectsBloc _subjectsBlocSingleton = SubjectsBloc._internal();

  factory SubjectsBloc() {
    return _subjectsBlocSingleton;
  }

  SubjectsBloc._internal() : super(LoadingBaseState());

  List<StudentSubjectData> subjects = [];

  @override
  Future<void> close() async {
    _subjectsBlocSingleton.close();
    await super.close();
  }

  @override
  Stream<BaseState> mapEventToState(
    SubjectsEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'SubjectsBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
