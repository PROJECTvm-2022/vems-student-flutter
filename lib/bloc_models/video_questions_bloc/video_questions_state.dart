import 'package:vems/bloc_models/base_state.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 14/1/21 at 11:46 PM
///

/// Initialized
class VideoQuestionsState extends BaseState {
  VideoQuestionsState();

  @override
  String toString() => 'VideoQuestionsState';

  @override
  BaseState getStateCopy() {
    return VideoQuestionsState();
  }
}

///loaded
class VideoQuestionsLoadedState extends BaseState {
  VideoQuestionsLoadedState();

  @override
  String toString() => 'VideoQuestionsLoadedState';

  @override
  BaseState getStateCopy() {
    return VideoQuestionsLoadedState();
  }
}
