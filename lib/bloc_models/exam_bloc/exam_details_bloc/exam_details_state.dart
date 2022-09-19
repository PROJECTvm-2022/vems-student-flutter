import 'package:vems/bloc_models/base_state.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 7/4/21 at 5:23 PM
///

///loaded
class ExamDetailsLoadedState extends BaseState {
  ExamDetailsLoadedState();

  @override
  String toString() => 'ExamDetailsLoadedState';

  @override
  BaseState getStateCopy() {
    return ExamDetailsLoadedState();
  }
}
