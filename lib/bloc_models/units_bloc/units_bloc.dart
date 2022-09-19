import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/units_bloc/index.dart';
import 'package:vems/data_models/unit_data.dart';
import 'dart:async';
import 'dart:developer' as developer;

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 11/1/21 at 9:53 PM
///

class UnitsBloc extends Bloc<UnitsEvent, BaseState> {
  static final UnitsBloc _unitsBlocSingleton = UnitsBloc._internal();

  factory UnitsBloc() {
    return _unitsBlocSingleton;
  }

  UnitsBloc._internal() : super(LoadingBaseState());

  List<UnitDatum> units = [];
  int unitSkip = 0;
  int unitLimit = 40;
  bool shouldLoadMore = true;

  @override
  Future<void> close() async {
    _unitsBlocSingleton.close();
    await super.close();
  }

  @override
  Stream<BaseState> mapEventToState(
    UnitsEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'UnitsBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
