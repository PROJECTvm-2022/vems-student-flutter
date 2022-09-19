import 'package:vems/bloc_models/base_state.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 9/3/21 at 9:49 PM
///

/// Initialized
class LiveClassState extends BaseState {
  LiveClassState();

  @override
  String toString() => 'LiveClassState';

  @override
  BaseState getStateCopy() {
    return LiveClassState();
  }
}

///loaded
class LiveClassLoadedState extends BaseState {
  LiveClassLoadedState();

  @override
  String toString() => 'LiveClassLoadedState';

  @override
  BaseState getStateCopy() {
    return LiveClassLoadedState();
  }
}
