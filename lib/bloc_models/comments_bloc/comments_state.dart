import 'package:vems/bloc_models/base_state.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 11/1/21 at 11:37 PM
///

/// Initialized
class CommentState extends BaseState {
  CommentState();

  @override
  String toString() => 'CommentState';

  @override
  BaseState getStateCopy() {
    return CommentState();
  }
}

///loaded
class CommentsLoadedState extends BaseState {
  CommentsLoadedState();

  @override
  String toString() => 'CommentsLoadedState';

  @override
  BaseState getStateCopy() {
    return CommentsLoadedState();
  }
}
