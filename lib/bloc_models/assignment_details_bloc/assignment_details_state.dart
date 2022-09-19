import 'package:vems/bloc_models/base_state.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 07/07/21 at 10:10 pm
///

///loaded
class AssignmentDetailsLoadedState extends BaseState {
  AssignmentDetailsLoadedState();

  @override
  String toString() => 'AssignmentDetailsLoadedState';

  @override
  BaseState getStateCopy() {
    return AssignmentDetailsLoadedState();
  }
}
