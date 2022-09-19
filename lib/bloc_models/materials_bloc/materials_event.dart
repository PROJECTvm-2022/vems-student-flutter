import 'package:flutter/material.dart';
import 'package:vems/api_services/material_services.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/materials_bloc/index.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 05/07/21 at 12:30 pm
///

@immutable
abstract class MaterialsEvent {
  Stream<BaseState> applyAsync({BaseState currentState, MaterialsBloc bloc});
}

class LoadMaterialsEvent extends MaterialsEvent {
  final Map<String, dynamic> query;

  LoadMaterialsEvent(this.query);

  @override
  String toString() => 'LoadMaterialsEvent';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, MaterialsBloc bloc}) async* {
    try {
      bloc.materialSkip = 0;
      bloc.shouldLoadMore = true;
      bloc.materials.clear();
      yield LoadingBaseState();
      final result = await getMaterials(
          skip: bloc.materialSkip,
          limit: bloc.materialLimit,
          additionalQuery: query);

      if (result.isEmpty) {
        bloc.materialSkip = 0;
        bloc.shouldLoadMore = false;
        yield EmptyBaseState();
      } else {
        if (result.isEmpty || result.length < bloc.materialLimit) {
          bloc.shouldLoadMore = false;
        }
        bloc.materials = result;
        yield MaterialsLoadedState();
      }
    } catch (_, st) {
      print(st);
      yield ErrorBaseState(_?.toString());
    }
  }
}

class LoadMoreMaterialsEvent extends MaterialsEvent {
  final Map<String, dynamic> query;

  LoadMoreMaterialsEvent(this.query);

  @override
  String toString() => 'LoadMoreMaterialsEvent';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, MaterialsBloc bloc}) async* {
    try {
      if (bloc.shouldLoadMore) {
        bloc.materialSkip = bloc.materials.length;

        final result = await getMaterials(
            skip: bloc.materialSkip,
            limit: bloc.materialLimit,
            additionalQuery: query);

        if (result.isEmpty || result.length < bloc.materialLimit) {
          bloc.shouldLoadMore = false;
        }
        bloc.materials += result;
        yield MaterialsLoadedState();
      } else {
        yield currentState;
      }
    } catch (_) {
      yield currentState;
    }
  }
}
