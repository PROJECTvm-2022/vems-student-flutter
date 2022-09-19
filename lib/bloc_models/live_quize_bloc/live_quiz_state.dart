import 'package:vems/bloc_models/base_state.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 3/5/21 at 9:56 PM
///

/// Initialized
class LiveQuizState extends BaseState {
  LiveQuizState();

  @override
  String toString() => 'LiveQuizState';

  @override
  BaseState getStateCopy() {
    return LiveQuizState();
  }
}

///loaded
class LiveQuizLoadedState extends BaseState {
  LiveQuizLoadedState();

  @override
  String toString() => 'LiveQuizLoadedState';

  @override
  BaseState getStateCopy() {
    return LiveQuizLoadedState();
  }
}
