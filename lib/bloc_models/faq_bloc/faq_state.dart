import 'package:vems/bloc_models/base_state.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 22/4/21 at 9:03 PM
///

///loaded
class FAQLoadedState extends BaseState {
  FAQLoadedState();

  @override
  String toString() => 'FAQLoadedState';

  @override
  BaseState getStateCopy() {
    return FAQLoadedState();
  }
}
