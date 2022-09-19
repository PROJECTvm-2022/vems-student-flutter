import 'package:vems/bloc_models/base_state.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 05/07/21 at 12:30 pm
///

/// Initialized
class MaterialState extends BaseState {
  MaterialState();

  @override
  String toString() => 'MaterialState';

  @override
  BaseState getStateCopy() {
    return MaterialState();
  }
}

///loaded
class MaterialsLoadedState extends BaseState {
  MaterialsLoadedState();

  @override
  String toString() => 'MaterialsLoadedState';

  @override
  BaseState getStateCopy() {
    return MaterialsLoadedState();
  }
}
