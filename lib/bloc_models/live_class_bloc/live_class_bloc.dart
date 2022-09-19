import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/live_class_bloc/index.dart';
import 'package:vems/data_models/live_class_data.dart';
import 'dart:async';
import 'dart:developer' as developer;

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 9/3/21 at 9:49 PM
///

class LiveClassBloc extends Bloc<LiveClassEvent, BaseState> {
  static final LiveClassBloc _liveCLassBlocSingleton =
      LiveClassBloc._internal();

  factory LiveClassBloc() {
    return _liveCLassBlocSingleton;
  }

  LiveClassBloc._internal() : super(LoadingBaseState());

  List<LiveClassDatum> classes = [];

  @override
  Future<void> close() async {
    _liveCLassBlocSingleton.close();
    await super.close();
  }

  @override
  Stream<BaseState> mapEventToState(
    LiveClassEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LiveClassBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
