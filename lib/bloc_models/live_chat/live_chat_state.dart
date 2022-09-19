import 'package:vems/bloc_models/base_state.dart';

class LoadedLiveChatState extends BaseState {
  @override
  String toString() => 'LoadedLiveChatState';

  @override
  BaseState getStateCopy() => LoadedLiveChatState();
}
