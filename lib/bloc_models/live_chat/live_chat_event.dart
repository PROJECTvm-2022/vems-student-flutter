import 'dart:async';
import 'dart:developer' as developer;
import 'dart:developer';

import 'package:vems/api_services/live_classes_api_services.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/live_chat/index.dart';
import 'package:vems/data_models/live_chat_data.dart';
import 'package:vems/utils/snackbar_helper.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LiveChatEvent {
  Stream<BaseState> applyAsync({BaseState currentState, LiveChatBloc bloc});
}

class UnLiveChatEvent extends LiveChatEvent {
  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, LiveChatBloc bloc}) async* {
    yield UnBaseState();
  }
}

class LoadLiveChatEvent extends LiveChatEvent {
  final String liveClassId;

  LoadLiveChatEvent(this.liveClassId);

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, LiveChatBloc bloc}) async* {
    try {
      yield LoadingBaseState();
      bloc.chats.clear();
      bloc.liveClassId = liveClassId;
      bloc.shouldLoadMore = true;
      bloc.$skip = 0;
      final result =
          await getLiveClassChats(liveClassId, bloc.$skip, bloc.$limit);
      if (result.length < bloc.$limit) bloc.shouldLoadMore = false;

      bloc.chats = result;
      yield LoadedLiveChatState();
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadLiveChatEvent', error: _, stackTrace: stackTrace);
      yield ErrorBaseState(_?.toString());
    }
  }
}

class LoadMoreLiveChatEvent extends LiveChatEvent {
  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, LiveChatBloc bloc}) async* {
    try {
      if (bloc.shouldLoadMore) {
        bloc.$skip = bloc.chats.length;

        final result =
            await getLiveClassChats(bloc.liveClassId, bloc.$skip, bloc.$limit);
        if (result.length < bloc.$limit) bloc.shouldLoadMore = false;
        bloc.chats += result;
        yield LoadedLiveChatState();
      } else {
        yield currentState;
      }
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadMoreLiveChatEvent', error: _, stackTrace: stackTrace);
      yield currentState;
    }
  }
}

class AddLiveChatEvent extends LiveChatEvent {
  final String text;
  final String id;

  AddLiveChatEvent({this.text, this.id});

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, LiveChatBloc bloc}) async* {
    try {
      Map<String, dynamic> body = {
        "type": 1,
        "entityType": "liveClass",
        "entityId": bloc.liveClassId,
        "text": text,
      };
      final data = await sendMessage(body);
      print("${data.entityId}");
    } catch (_, stackTrace) {
      log('$_ $stackTrace');
      SnackBarHelper.show('', _?.toString());
    }
  }
}

class AddLiveChatDatumEvent extends LiveChatEvent {
  final LiveChatDatum data;

  AddLiveChatDatumEvent(this.data);

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, LiveChatBloc bloc}) async* {
    final index = bloc.chats.indexOf(data);
    if (index == -1) {
      bloc.chats.insert(0, data);
    } else {
      bloc.chats[index] = data;
    }
    yield LoadedLiveChatState();
  }
}
