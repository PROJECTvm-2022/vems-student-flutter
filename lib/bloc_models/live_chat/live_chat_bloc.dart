import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/live_chat/index.dart';
import 'package:vems/data_models/live_chat_data.dart';

class LiveChatBloc extends Bloc<LiveChatEvent, BaseState> {
  LiveChatBloc(BaseState initialState) : super(initialState);

  int $limit = 30;
  int $skip = 0;
  bool shouldLoadMore = true;
  List<LiveChatDatum> chats = [];

  String liveClassId;

  @override
  Stream<BaseState> mapEventToState(
    LiveChatEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LiveChatBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
