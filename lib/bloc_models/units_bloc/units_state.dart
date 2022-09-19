import 'package:vems/bloc_models/base_state.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 11/1/21 at 9:54 PM
///

/// Initialized
class UnitState extends BaseState {
  UnitState();

  @override
  String toString() => 'UnitState';

  @override
  BaseState getStateCopy() {
    return UnitState();
  }
}

///loaded
class UnitsLoadedState extends BaseState {
  UnitsLoadedState();

  @override
  String toString() => 'UnitsLoadedState';

  @override
  BaseState getStateCopy() {
    return UnitsLoadedState();
  }
}
