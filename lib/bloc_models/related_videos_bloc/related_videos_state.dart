import 'package:vems/bloc_models/base_state.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 06/07/21 at 4:14 pm
///

///loaded
class AllRelatedVideosLoadedState extends BaseState {
  AllRelatedVideosLoadedState();

  @override
  String toString() => 'AllRelatedVideosLoadedState';

  @override
  BaseState getStateCopy() {
    return AllRelatedVideosLoadedState();
  }
}
