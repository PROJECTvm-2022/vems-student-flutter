import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/exam_bloc/exam_details_bloc/index.dart';
import 'package:vems/data_models/student_exam_datum.dart';
import 'dart:async';
import 'dart:developer' as developer;

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 7/4/21 at 5:22 PM
///

class ExamDetailsBloc extends Bloc<ExamDetailsEvent, BaseState> {
  static final ExamDetailsBloc _examDetailsBlocSingleton =
      ExamDetailsBloc._internal();

  factory ExamDetailsBloc() {
    return _examDetailsBlocSingleton;
  }

  ExamDetailsBloc._internal() : super(LoadingBaseState());

  StudentExamDatum exam = StudentExamDatum();

  @override
  Future<void> close() async {
    _examDetailsBlocSingleton.close();
    await super.close();
  }

  @override
  Stream<BaseState> mapEventToState(
    ExamDetailsEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'ExamDetailsBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
