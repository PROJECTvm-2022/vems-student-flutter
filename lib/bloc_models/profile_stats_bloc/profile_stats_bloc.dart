import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/profile_stats_bloc/index.dart';
import 'package:vems/data_models/profile_stats_datum.dart';
import 'dart:async';
import 'dart:developer' as developer;

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 15/4/21 at 6:24 PM
///

class ProfileStatsBloc extends Bloc<ProfileStatsEvent, BaseState> {
  static final ProfileStatsBloc _profileStatsBlocSingleton =
      ProfileStatsBloc._internal();

  factory ProfileStatsBloc() {
    return _profileStatsBlocSingleton;
  }

  ProfileStatsBloc._internal() : super(LoadingBaseState());

  ProfileStatsDatum stats = ProfileStatsDatum();

  @override
  Future<void> close() async {
    _profileStatsBlocSingleton.close();
    await super.close();
  }

  @override
  Stream<BaseState> mapEventToState(
    ProfileStatsEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'ProfileStatsBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
