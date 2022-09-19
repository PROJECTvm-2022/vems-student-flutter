import 'package:flutter/material.dart';
import 'package:vems/api_services/comment_api_services.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/comments_bloc/index.dart';
import 'package:vems/bloc_models/videos_bloc/index.dart';
import 'package:vems/data_models/comment_data.dart';
import 'package:vems/utils/snackbar_helper.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 11/1/21 at 11:36 PM
///

@immutable
abstract class CommentsEvent {
  Stream<BaseState> applyAsync({BaseState currentState, CommentsBloc bloc});
}

class LoadCommentsEvent extends CommentsEvent {
  final String videoId;

  LoadCommentsEvent(this.videoId);

  @override
  String toString() => 'LoadCommentsEvent ';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, CommentsBloc bloc}) async* {
    try {
      bloc.commentSkip = 0;
      bloc.shouldLoadMore = true;
      bloc.comments.clear();
      yield LoadingBaseState();
      final result = await getComments(videoId,
          skip: bloc.commentSkip, limit: bloc.commentLimit);

      if (result.isEmpty) {
        bloc.commentSkip = 0;
        bloc.shouldLoadMore = false;
        yield EmptyBaseState();
      } else {
        if (result.isEmpty || result.length < bloc.commentLimit) {
          bloc.shouldLoadMore = false;
        }
        bloc.comments = result;
        yield CommentsLoadedState();
      }
    } catch (_, st) {
      print(st);
      yield ErrorBaseState(_?.toString());
    }
  }
}

class LoadMoreComments extends CommentsEvent {
  final String videoId;

  LoadMoreComments(this.videoId);

  @override
  String toString() => 'LoadMoreComments';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, CommentsBloc bloc}) async* {
    try {
      if (bloc.shouldLoadMore) {
        bloc.commentSkip = bloc.comments.length;

        final result = await getComments(videoId,
            skip: bloc.commentSkip, limit: bloc.commentLimit);

        if (result.isEmpty || result.length < bloc.commentLimit) {
          bloc.shouldLoadMore = false;
        }
        bloc.comments += result;
        yield CommentsLoadedState();
      } else {
        yield currentState;
      }
    } catch (_) {
      yield currentState;
    }
  }
}

class AddCommentEvent extends CommentsEvent {
  final CommentDatum tempDatum;

  AddCommentEvent(this.tempDatum);

  @override
  String toString() => 'AddComment';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, CommentsBloc bloc}) async* {
    try {
      bloc.comments.insert(0, tempDatum);
      yield CommentsLoadedState();
      VideosBloc().add(UpdateCommentCount(
        videoId: tempDatum.entityId,
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
      bloc.comments.remove(tempDatum);
      bloc.comments.insert(0, datum);
      yield CommentsLoadedState();
    } catch (_, st) {
      print(st);
      SnackBarHelper.show("ERROR", _?.toString());
      VideosBloc().add(UpdateCommentCount(
        videoId: tempDatum.entityId,
        isDecrement: true,
      ));
      bloc.comments.remove(tempDatum);
      yield CommentsLoadedState();
    }
  }
}

class UpdateReplyCount extends CommentsEvent {
  final String commentId;
  final bool isDecrement;

  UpdateReplyCount({this.commentId = '', this.isDecrement = false});

  @override
  String toString() => 'UpdateReplyCount';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, CommentsBloc bloc}) async* {
    try {
      CommentDatum tempDatum =
          bloc.comments.where((element) => element.id == commentId).first;
      int index = bloc.comments.indexOf(tempDatum);
      bloc.comments.remove(tempDatum);
      if (isDecrement) {
        tempDatum.commentCount -= 1;
      } else {
        tempDatum.commentCount += 1;
      }
      bloc.comments.insert(index, tempDatum);
      yield CommentsLoadedState();
    } catch (_, st) {
      print(st);
      yield currentState;
    }
  }
}
