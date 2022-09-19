import 'package:vems/bloc_models/base_state.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 3/3/21 at 9:07 PM
///

/// Initialized
class ProfileState extends BaseState {
  ProfileState();

  @override
  String toString() => 'ProfileState';

  @override
  BaseState getStateCopy() {
    return ProfileState();
  }
}

///loaded
class ProfileLoadedState extends BaseState {
  ProfileLoadedState();

  @override
  String toString() => 'ProfileLoadedState';

  @override
  BaseState getStateCopy() {
    return ProfileLoadedState();
  }
}
