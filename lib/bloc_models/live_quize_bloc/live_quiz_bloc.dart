import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/live_quize_bloc/index.dart';
import 'package:vems/data_models/live_chat_data.dart';
import 'dart:async';
import 'dart:developer' as developer;

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 3/5/21 at 9:55 PM
///

class LiveQuizBloc extends Bloc<LiveQuizEvent, BaseState> {
  static final LiveQuizBloc _liveQuizBlocSingleton = LiveQuizBloc._internal();

  factory LiveQuizBloc() {
    return _liveQuizBlocSingleton;
  }

  LiveQuizBloc._internal() : super(LoadingBaseState());

  LiveChatDatum currentQuiz = LiveChatDatum();
  List<LiveChatDatum> quizList = [];
  int quizSkip = 0;
  int quizLimit = 15;
  bool shouldLoadMore = true;

  /// to store the current screen state
  bool isLandscape = false;

  @override
  Future<void> close() async {
    _liveQuizBlocSingleton.close();
    await super.close();
  }

  @override
  Stream<BaseState> mapEventToState(
    LiveQuizEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LiveQuizBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
