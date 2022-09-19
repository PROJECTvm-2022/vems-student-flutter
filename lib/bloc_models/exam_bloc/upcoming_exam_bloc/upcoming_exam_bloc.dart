import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/exam_bloc/upcoming_exam_bloc/index.dart';
import 'package:vems/data_models/student_exam_datum.dart';
import 'dart:async';
import 'dart:developer' as developer;

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 14/4/21 at 7:34 PM
///

class UpcomingExamsBloc extends Bloc<UpcomingExamsEvent, BaseState> {
  static final UpcomingExamsBloc _upcomingExamsBlocSingleton =
      UpcomingExamsBloc._internal();

  factory UpcomingExamsBloc() {
    return _upcomingExamsBlocSingleton;
  }

  UpcomingExamsBloc._internal() : super(LoadingBaseState());

  List<StudentExamDatum> exams = [];
  int examSkip = 0;
  int examLimit = 5;

  @override
  Future<void> close() async {
    _upcomingExamsBlocSingleton.close();
    await super.close();
  }

  @override
  Stream<BaseState> mapEventToState(
    UpcomingExamsEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'UpcomingExamsBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
