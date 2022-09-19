import 'package:vems/bloc_models/base_state.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 12/1/21 at 8:40 PM
///

///loaded
class ReplyLoadedState extends BaseState {
  ReplyLoadedState();

  @override
  String toString() => 'ReplyLoadedState';

  @override
  BaseState getStateCopy() {
    return ReplyLoadedState();
  }
}
