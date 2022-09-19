import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/units_bloc/all_units_bloc/index.dart';
import 'package:vems/data_models/unit_data.dart';
import 'dart:developer' as developer;

///
/// Created by Auro (auro@smarttersstudio.com) on 05/07/21 at 3:57 pm
///

class AllUnitsBloc extends Bloc<AllUnitsEvent, BaseState> {
  static final AllUnitsBloc _allUnitsBlocSingleton = AllUnitsBloc._internal();

  factory AllUnitsBloc() {
    return _allUnitsBlocSingleton;
  }

  AllUnitsBloc._internal() : super(LoadingBaseState());

  List<UnitDatum> units = [];

  @override
  Future<void> close() async {
    _allUnitsBlocSingleton.close();
    await super.close();
  }

  @override
  Stream<BaseState> mapEventToState(
    AllUnitsEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'AllUnitsBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
