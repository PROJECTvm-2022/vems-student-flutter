import 'package:vems/bloc_models/base_state.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 07/07/21 at 9:58 pm
///

///loaded
class AssignmentLoadedState extends BaseState {
  AssignmentLoadedState();

  @override
  String toString() => 'AssignmentLoadedState';

  @override
  BaseState getStateCopy() {
    return AssignmentLoadedState();
  }
}
