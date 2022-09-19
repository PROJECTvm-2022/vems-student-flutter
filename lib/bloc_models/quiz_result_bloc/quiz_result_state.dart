import 'package:vems/bloc_models/base_state.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 14/06/21 at 8:46 PM
///

/// Initialized
class QuizResultState extends BaseState {
  QuizResultState();

  @override
  String toString() => 'QuizResultState';

  @override
  BaseState getStateCopy() {
    return QuizResultState();
  }
}

///loaded
class QuizResultLoadedState extends BaseState {
  QuizResultLoadedState();

  @override
  String toString() => 'QuizResultLoadedState';

  @override
  BaseState getStateCopy() {
    return QuizResultLoadedState();
  }
}
