import 'package:flutter/material.dart';
import 'package:vems/api_services/lecture_api_services.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/units_bloc/index.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 11/1/21 at 9:54 PM
///

@immutable
abstract class UnitsEvent {
  Stream<BaseState> applyAsync({BaseState currentState, UnitsBloc bloc});
}

class LoadUnitsEvent extends UnitsEvent {
  final String syllabus;

  LoadUnitsEvent(this.syllabus);

  @override
  String toString() => 'LoadUnitsEvent';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, UnitsBloc bloc}) async* {
    try {
      bloc.unitSkip = 0;
      bloc.shouldLoadMore = true;
      bloc.units.clear();
      yield LoadingBaseState();
      final result =
          await getUnits(syllabus, skip: bloc.unitSkip, limit: bloc.unitLimit);

      if (result.isEmpty) {
        bloc.unitSkip = 0;
        bloc.shouldLoadMore = false;
        yield EmptyBaseState();
      } else {
        if (result.isEmpty || result.length < bloc.unitLimit) {
          bloc.shouldLoadMore = false;
        }
        bloc.units = result;
        yield UnitsLoadedState();
      }
    } catch (_, st) {
      print(st);
      yield ErrorBaseState(_?.toString());
    }
  }
}

class LoadMoreUnits extends UnitsEvent {
  final String syllabus;

  LoadMoreUnits(this.syllabus);

  @override
  String toString() => 'LoadMoreUnits';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, UnitsBloc bloc}) async* {
    try {
      if (bloc.shouldLoadMore) {
        bloc.unitSkip = bloc.units.length;

        final result = await getUnits(syllabus,
            skip: bloc.unitSkip, limit: bloc.unitLimit);

        if (result.isEmpty || result.length < bloc.unitLimit) {
          bloc.shouldLoadMore = false;
        }
        bloc.units += result;
        yield UnitsLoadedState();
      } else {
        yield currentState;
      }
    } catch (_) {
      yield currentState;
    }
  }
}
