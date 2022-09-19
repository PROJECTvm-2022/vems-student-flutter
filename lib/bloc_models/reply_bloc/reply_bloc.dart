import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/reply_bloc/index.dart';
import 'package:vems/data_models/comment_data.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 12/1/21 at 8:40 PM
///

class ReplyBloc extends Bloc<ReplyEvent, BaseState> {
  static List<ReplyBloc> replyBlocs = [];

  ReplyBloc() : super(LoadingBaseState());

  String commentId = '';
  List<CommentDatum> replies = [];
  int replySkip = 0;
  int replyLimit = 6;
  bool shouldLoadMore = true;

  @override
  Stream<BaseState> mapEventToState(
    ReplyEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_) {
      yield state;
    }
  }
}
