import 'package:vems/bloc_models/base_state.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 05/07/21 at 8:03 pm
///

///loaded
class MaterialDetailsLoadedState extends BaseState {
  MaterialDetailsLoadedState();

  @override
  String toString() => 'MaterialDetailsLoadedState';

  @override
  BaseState getStateCopy() {
    return MaterialDetailsLoadedState();
  }
}
