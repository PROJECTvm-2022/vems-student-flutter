import 'package:flutter/material.dart';
import 'package:vems/api_services/comment_api_services.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/comments_bloc/comments_bloc.dart';
import 'package:vems/bloc_models/comments_bloc/comments_event.dart';
import 'package:vems/bloc_models/reply_bloc/index.dart';
import 'package:vems/data_models/comment_data.dart';
import 'package:vems/utils/snackbar_helper.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 12/1/21 at 8:40 PM
///

@immutable
abstract class ReplyEvent {
  Stream<BaseState> applyAsync({BaseState currentState, ReplyBloc bloc});
}

class LoadRepliesEvent extends ReplyEvent {
  final String commentId;

  LoadRepliesEvent(this.commentId);

  @override
  String toString() => 'LoadRepliesEvent';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, ReplyBloc bloc}) async* {
    try {
      bloc.replySkip = 0;
      bloc.shouldLoadMore = true;
      bloc.replies.clear();
      yield LoadingBaseState();
      final result = await getComments(commentId,
          skip: bloc.replySkip, limit: bloc.replyLimit);

      if (result.isEmpty) {
        bloc.replySkip = 0;
        bloc.shouldLoadMore = false;
        yield EmptyBaseState();
      } else {
        if (result.isEmpty || result.length < bloc.replyLimit) {
          bloc.shouldLoadMore = false;
        }
        bloc.replies = result;
        yield ReplyLoadedState();
      }
    } catch (_) {
      yield ErrorBaseState(_?.toString());
    }
  }
}

class LoadMoreRepliesEvent extends ReplyEvent {
  final String commentId;

  LoadMoreRepliesEvent(this.commentId);

  @override
  String toString() => 'LoadMoreRepliesEvent';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, ReplyBloc bloc}) async* {
    try {
      if (bloc.shouldLoadMore) {
        bloc.commentId = commentId;
        bloc.replySkip = bloc.replies.length;

        final result = await getComments(commentId,
            skip: bloc.replySkip, limit: bloc.replyLimit);

        if (result.isEmpty || result.length < bloc.replyLimit) {
          bloc.shouldLoadMore = false;
        }
        bloc.replies += result;
        yield ReplyLoadedState();
      } else {
        yield currentState;
      }
    } catch (_) {
      yield currentState;
    }
  }
}

class AddReplyEvent extends ReplyEvent {
  final CommentDatum tempDatum;

  AddReplyEvent(this.tempDatum);

  @override
  String toString() => 'AddReplyEvent';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, ReplyBloc bloc}) async* {
    try {
      bloc.replies.insert(0, tempDatum);
      yield ReplyLoadedState();
      CommentsBloc().add(UpdateReplyCount(
        commentId: tempDatum.entityId,
        isDecrement: false,
      ));
      var datum = await addComment({
        "comment": tempDatum.comment,
        "entityType": tempDatum.entityType,
        "entityId": tempDatum.entityId,
        "parentEntityType": tempDatum.parentEntityType,
        "parentEntityId": tempDatum.parentEntityId,
        "type": tempDatum.type,
      });
      bloc.replies.remove(tempDatum);
      bloc.replies.insert(0, datum);
      yield ReplyLoadedState();
    } catch (_, st) {
      print(st);
      SnackBarHelper.show("ERROR", _?.toString());
      CommentsBloc().add(UpdateReplyCount(
        commentId: tempDatum.entityId,
        isDecrement: true,
      ));
      bloc.replies.remove(tempDatum);
      yield ReplyLoadedState();
    }
  }
}
