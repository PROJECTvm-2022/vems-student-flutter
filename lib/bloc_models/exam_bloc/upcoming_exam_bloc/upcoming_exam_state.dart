import 'package:vems/bloc_models/base_state.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 14/4/21 at 7:34 PM
///

///loaded
class UpcomingExamsLoadedState extends BaseState {
  UpcomingExamsLoadedState();

  @override
  String toString() => 'UpcomingExamsLoadedState';

  @override
  BaseState getStateCopy() {
    return UpcomingExamsLoadedState();
  }
}
