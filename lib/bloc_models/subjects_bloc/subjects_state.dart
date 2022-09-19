import 'package:vems/bloc_models/base_state.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 11/1/21 at 9:53 PM
///

/// Initialized
class SubjectState extends BaseState {
  SubjectState();

  @override
  String toString() => 'SubjectState';

  @override
  BaseState getStateCopy() {
    return SubjectState();
  }
}

///loaded
class SubjectLoadedState extends BaseState {
  SubjectLoadedState();

  @override
  String toString() => 'SubjectLoadedState';

  @override
  BaseState getStateCopy() {
    return SubjectLoadedState();
  }
}
