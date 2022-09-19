import 'package:vems/bloc_models/base_state.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 4/2/21 at 2:11 PM
///

/// Initialized
class ScheduleState extends BaseState {
  ScheduleState();

  @override
  String toString() => 'ScheduleState';

  @override
  BaseState getStateCopy() {
    return ScheduleState();
  }
}

///loaded
class ScheduleLoadedState extends BaseState {
  ScheduleLoadedState();

  @override
  String toString() => 'ScheduleLoadedState';

  @override
  BaseState getStateCopy() {
    return ScheduleLoadedState();
  }
}
