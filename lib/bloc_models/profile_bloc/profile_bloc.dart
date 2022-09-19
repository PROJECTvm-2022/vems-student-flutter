import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/profile_bloc/index.dart';
import 'package:vems/data_models/user.dart';
import 'dart:async';
import 'dart:developer' as developer;

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 3/3/21 at 9:07 PM
///

class ProfileBloc extends Bloc<ProfileEvent, BaseState> {
  static final ProfileBloc _profileBlocSingleton = ProfileBloc._internal();

  factory ProfileBloc() {
    return _profileBlocSingleton;
  }

  ProfileBloc._internal() : super(LoadingBaseState());

  UserDatum user = UserDatum();

  @override
  Future<void> close() async {
    _profileBlocSingleton.close();
    await super.close();
  }

  @override
  Stream<BaseState> mapEventToState(
    ProfileEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'ProfileBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
