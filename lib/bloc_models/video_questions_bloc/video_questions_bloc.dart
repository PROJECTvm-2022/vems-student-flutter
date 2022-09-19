import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/video_questions_bloc/index.dart';
import 'package:vems/data_models/question_data.dart';
import 'dart:async';
import 'dart:developer' as developer;

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 14/1/21 at 11:46 PM
///

class VideoQuestionsBloc extends Bloc<VideoQuestionsEvent, BaseState> {
  static final VideoQuestionsBloc _videoQuestionsBlocSingleton =
      VideoQuestionsBloc._internal();

  factory VideoQuestionsBloc() {
    return _videoQuestionsBlocSingleton;
  }

  VideoQuestionsBloc._internal() : super(LoadingBaseState());

  int total = 0;
  List<QuestionDatum> questions = [];

  @override
  Future<void> close() async {
    _videoQuestionsBlocSingleton.close();
    await super.close();
  }

  @override
  Stream<BaseState> mapEventToState(
    VideoQuestionsEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'VideoQuestionsBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
