import 'package:vems/bloc_models/base_state.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 15/4/21 at 6:25 PM
///

///loaded
class ProfileStatsLoadedState extends BaseState {
  ProfileStatsLoadedState();

  @override
  String toString() => 'ProfileStatsLoadedState';

  @override
  BaseState getStateCopy() {
    return ProfileStatsLoadedState();
  }
}
