import 'package:vems/bloc_models/base_state.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 08/07/21 at 9:13 am
///

///loaded
class UpcomingAssignmentLoadedState extends BaseState {
  UpcomingAssignmentLoadedState();

  @override
  String toString() => 'UpcomingAssignmentLoadedState';

  @override
  BaseState getStateCopy() {
    return UpcomingAssignmentLoadedState();
  }
}
