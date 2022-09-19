import 'package:vems/bloc_models/base_state.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 05/07/21 at 4:17 pm
///

/// Initialized
class AllChaptersState extends BaseState {
  AllChaptersState();

  @override
  String toString() => 'AllChaptersState';

  @override
  BaseState getStateCopy() {
    return AllChaptersState();
  }
}

///loaded
class AllChaptersLoadedState extends BaseState {
  AllChaptersLoadedState();

  @override
  String toString() => 'AllChaptersLoadedState';

  @override
  BaseState getStateCopy() {
    return AllChaptersLoadedState();
  }
}
