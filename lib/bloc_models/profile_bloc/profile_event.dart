import 'package:flutter/material.dart';
import 'package:vems/api_services/profile_api_services.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/profile_bloc/index.dart';
import 'package:vems/data_models/user.dart';
import 'package:vems/utils/shared_preference_helper.dart';

@immutable
abstract class ProfileEvent {
  Stream<BaseState> applyAsync({BaseState currentState, ProfileBloc bloc});
}

class LoadUserEvent extends ProfileEvent {
  @override
  String toString() => 'LoadUserEvent';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, ProfileBloc bloc}) async* {
    try {
      yield LoadingBaseState();
      final result = await getMyProfile();

      if (result != null) {
        bloc.user = result;
        yield ProfileLoadedState();
      } else {
        yield currentState;
      }
    } catch (_, st) {
      print(st);
      yield ErrorBaseState(_?.toString());
    }
  }
}

class EditUserEvent extends ProfileEvent {
  final UserDatum datum;

  EditUserEvent(this.datum);

  @override
  String toString() => 'EditUserEvent';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, ProfileBloc bloc}) async* {
    try {
      if (datum != null) {
        bloc.user = datum;
        SharedPreferenceHelper.storeUser(user: datum);
        yield ProfileLoadedState();
      } else {
        yield currentState;
      }
    } catch (_, st) {
      print(st);
      yield currentState;
    }
  }
}

class RefreshEvent extends ProfileEvent {
  @override
  String toString() => 'RefreshEvent';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, ProfileBloc bloc}) async* {
    try {
      yield ProfileLoadedState();
    } catch (_, st) {
      print(st);
    }
  }
}
