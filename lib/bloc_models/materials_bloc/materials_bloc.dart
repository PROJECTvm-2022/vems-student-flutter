import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/materials_bloc/index.dart';
import 'package:vems/data_models/material.dart';
import 'dart:developer' as developer;

///
/// Created by Auro (auro@smarttersstudio.com) on 05/07/21 at 12:30 pm
///

class MaterialsBloc extends Bloc<MaterialsEvent, BaseState> {
  static final MaterialsBloc _materialsBlocSingleton =
      MaterialsBloc._internal();

  factory MaterialsBloc() {
    return _materialsBlocSingleton;
  }

  MaterialsBloc._internal() : super(LoadingBaseState());

  List<MaterialDatum> materials = [];
  int materialSkip = 0;
  int materialLimit = 20;
  bool shouldLoadMore = true;

  @override
  Future<void> close() async {
    _materialsBlocSingleton.close();
    await super.close();
  }

  @override
  Stream<BaseState> mapEventToState(
    MaterialsEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'MaterialsBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
