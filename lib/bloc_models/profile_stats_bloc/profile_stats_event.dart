import 'package:flutter/material.dart';
import 'package:vems/api_services/profile_api_services.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/profile_stats_bloc/index.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 15/4/21 at 6:24 PM
///

@immutable
abstract class ProfileStatsEvent {
  Stream<BaseState> applyAsync({BaseState currentState, ProfileStatsBloc bloc});
}

class LoadStatsEvent extends ProfileStatsEvent {
  @override
  String toString() => 'LoadStatsEvent';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, ProfileStatsBloc bloc}) async* {
    try {
      yield LoadingBaseState();
      final result = await getProfileStats();

      if (result != null) {
        bloc.stats = result;
        yield ProfileStatsLoadedState();
      } else {
        yield currentState;
      }
    } catch (_, st) {
      print(st);
      yield ErrorBaseState(_?.toString());
    }
  }
}
