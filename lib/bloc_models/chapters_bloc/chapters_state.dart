import 'package:vems/bloc_models/base_state.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 11/1/21 at 9:55 PM
///

/// Initialized
class ChapterState extends BaseState {
  ChapterState();

  @override
  String toString() => 'ChapterState';

  @override
  BaseState getStateCopy() {
    return ChapterState();
  }
}

///loaded
class ChaptersLoadedState extends BaseState {
  ChaptersLoadedState();

  @override
  String toString() => 'ChaptersLoadedState';

  @override
  BaseState getStateCopy() {
    return ChaptersLoadedState();
  }
}
