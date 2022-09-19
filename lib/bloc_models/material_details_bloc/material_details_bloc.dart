import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/material_details_bloc/index.dart';
import 'package:vems/data_models/material.dart';
import 'dart:developer' as developer;

///
/// Created by Auro (auro@smarttersstudio.com) on 05/07/21 at 8:02 pm
///

class MaterialsDetailsBloc extends Bloc<MaterialsDetailsEvent, BaseState> {
  static final MaterialsDetailsBloc _materialDetailsBlocSingleton =
      MaterialsDetailsBloc._internal();

  factory MaterialsDetailsBloc() {
    return _materialDetailsBlocSingleton;
  }

  MaterialsDetailsBloc._internal() : super(LoadingBaseState());

  MaterialDatum material = MaterialDatum();
  PDFDocument document = PDFDocument();

  @override
  Future<void> close() async {
    _materialDetailsBlocSingleton.close();
    await super.close();
  }

  @override
  Stream<BaseState> mapEventToState(
    MaterialsDetailsEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'MaterialsDetailsBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
