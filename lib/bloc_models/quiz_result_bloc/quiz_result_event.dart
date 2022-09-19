import 'package:flutter/material.dart';
import 'package:vems/api_services/live_classes_api_services.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/quiz_result_bloc/index.dart';
import 'package:vems/utils/shared_preference_helper.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 14/06/21 at 8:46 PM
///

@immutable
abstract class QuizResultEvent {
  Stream<BaseState> applyAsync({BaseState currentState, QuizResultBloc bloc});
}

class LoadResults extends QuizResultEvent {
  final String chatId;
  final String answer;

  LoadResults({@required this.chatId, @required this.answer});

  @override
  String toString() => 'LoadQuiz';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, QuizResultBloc bloc}) async* {
    try {
      bloc.resultSkip = 0;
      bloc.shouldLoadMore = true;
      bloc.results.clear();
      yield LoadingBaseState();
      final result = await getQuizResults(chatId, answer,
          skip: bloc.resultSkip, limit: bloc.resultLimit);

      if (result.isEmpty) {
        bloc.resultSkip = 0;
        bloc.shouldLoadMore = false;
        yield EmptyBaseState();
      } else {
        /// search for my answer
        int index = result.indexWhere((element) =>
            element.createdBy.id == SharedPreferenceHelper.user.id);
        if (index != -1) {
          bloc.indexOfMyAnswer = index;
        }
        bloc.results = result;
        yield QuizResultLoadedState();
      }
    } catch (_, st) {
      print(st);
      yield ErrorBaseState(_?.toString());
    }
  }
}
//
// class LoadMoreResults extends QuizResultEvent {
//   final String chatId;
//   final String answer;
//
//   LoadMoreResults({@required this.chatId, @required this.answer});
//
//   @override
//   String toString() => 'LoadMoreQuiz';
//
//   @override
//   Stream<BaseState> applyAsync(
//       {BaseState currentState, QuizResultBloc bloc}) async* {
//     try {
//       if (bloc.shouldLoadMore) {
//         bloc.resultSkip = bloc.results.length;
//
//         final result = await getQuizResults(chatId, answer,
//             skip: bloc.resultSkip, limit: bloc.resultLimit);
//
//         if (result.isEmpty || result.length < bloc.resultSkip) {
//           bloc.shouldLoadMore = false;
//         }
//         bloc.results += result;
//         yield QuizResultLoadedState();
//       } else {
//         yield currentState;
//       }
//     } catch (_) {
//       yield currentState;
//     }
//   }
// }
