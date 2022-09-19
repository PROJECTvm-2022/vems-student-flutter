import 'package:vems/bloc_models/base_state.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 05/07/21 at 3:57 pm
///

/// Initialized
class AllUnitsState extends BaseState {
  AllUnitsState();

  @override
  String toString() => 'AllUnitsState';

  @override
  BaseState getStateCopy() {
    return AllUnitsState();
  }
}

///loaded
class AllUnitsLoadedState extends BaseState {
  AllUnitsLoadedState();

  @override
  String toString() => 'AllUnitsLoadedState';

  @override
  BaseState getStateCopy() {
    return AllUnitsLoadedState();
  }
}
