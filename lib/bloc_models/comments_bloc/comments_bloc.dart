import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/comments_bloc/index.dart';
import 'package:vems/data_models/comment_data.dart';
import 'dart:async';
import 'dart:developer' as developer;

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 11/1/21 at 11:36 PM
///

class CommentsBloc extends Bloc<CommentsEvent, BaseState> {
  static final CommentsBloc _subjectsBlocSingleton = CommentsBloc._internal();

  factory CommentsBloc() {
    return _subjectsBlocSingleton;
  }

  CommentsBloc._internal() : super(LoadingBaseState());

  List<CommentDatum> comments = [];
  int commentSkip = 0;
  int commentLimit = 100;
  bool shouldLoadMore = true;

  @override
  Future<void> close() async {
    _subjectsBlocSingleton.close();
    await super.close();
  }

  @override
  Stream<BaseState> mapEventToState(
    CommentsEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'CommentsBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
