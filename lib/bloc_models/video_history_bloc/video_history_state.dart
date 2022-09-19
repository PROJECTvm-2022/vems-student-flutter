import 'package:vems/bloc_models/base_state.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 14/4/21 at 9:10 PM
///

///loaded
class VideoHistoryLoadedState extends BaseState {
  VideoHistoryLoadedState();

  @override
  String toString() => 'VideoHistoryLoadedState';

  @override
  BaseState getStateCopy() {
    return VideoHistoryLoadedState();
  }
}
