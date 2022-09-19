import 'package:vems/bloc_models/base_state.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 7/4/21 at 10:36 AM
///

/// Initialized
class ExamsState extends BaseState {
  ExamsState();

  @override
  String toString() => 'ExamsState';

  @override
  BaseState getStateCopy() {
    return ExamsState();
  }
}

///loaded
class ExamsLoadedState extends BaseState {
  ExamsLoadedState();

  @override
  String toString() => 'ExamsLoadedState';

  @override
  BaseState getStateCopy() {
    return ExamsLoadedState();
  }
}
