import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/quiz_result_bloc/index.dart';
import 'package:vems/data_models/live_chat_data.dart';
import 'dart:developer' as developer;

///
/// Created by Auro (auro@smarttersstudio.com) on 14/06/21 at 8:46 PM
///

class QuizResultBloc extends Bloc<QuizResultEvent, BaseState> {
  static final QuizResultBloc _quizResultBlocSingleton =
      QuizResultBloc._internal();

  factory QuizResultBloc() {
    return _quizResultBlocSingleton;
  }

  QuizResultBloc._internal() : super(LoadingBaseState());

  List<LiveChatDatum> results = [];
  int resultSkip = 0;
  int resultLimit = 20;
  bool shouldLoadMore = true;

  int indexOfMyAnswer = 0;

  @override
  Future<void> close() async {
    _quizResultBlocSingleton.close();
    await super.close();
  }

  @override
  Stream<BaseState> mapEventToState(
    QuizResultEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'QuizResultBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
