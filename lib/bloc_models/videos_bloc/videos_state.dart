import 'package:vems/bloc_models/base_state.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 11/1/21 at 9:57 PM
///

/// Initialized
class VideosState extends BaseState {
  VideosState();

  @override
  String toString() => 'VideosState';

  @override
  BaseState getStateCopy() {
    return VideosState();
  }
}

///loaded
class VideosLoadedState extends BaseState {
  VideosLoadedState();

  @override
  String toString() => 'VideosLoadedState';

  @override
  BaseState getStateCopy() {
    return VideosLoadedState();
  }
}
