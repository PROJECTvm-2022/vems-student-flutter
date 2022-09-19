import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/exam_bloc/exams_bloc/index.dart';
import 'dart:async';
import 'dart:developer' as developer;

import 'package:vems/data_models/student_exam_datum.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 7/4/21 at 10:36 AM
///

class ExamsBloc extends Bloc<ExamsEvent, BaseState> {
  static final ExamsBloc _examsBlocSingleton = ExamsBloc._internal();

  factory ExamsBloc() {
    return _examsBlocSingleton;
  }

  ExamsBloc._internal() : super(LoadingBaseState());

  List<StudentExamDatum> exams = [];
  int examSkip = 0;
  int examLimit = 20;
  bool shouldLoadMore = true;

  @override
  Future<void> close() async {
    _examsBlocSingleton.close();
    await super.close();
  }

  @override
  Stream<BaseState> mapEventToState(
    ExamsEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'ExamsBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
