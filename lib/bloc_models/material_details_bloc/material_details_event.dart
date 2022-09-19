import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:vems/api_services/material_services.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/material_details_bloc/index.dart';
import 'package:vems/data_models/material.dart';
import 'package:vems/utils/offline_library_helper.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 05/07/21 at 8:03 pm
///

@immutable
abstract class MaterialsDetailsEvent {
  Stream<BaseState> applyAsync(
      {BaseState currentState, MaterialsDetailsBloc bloc});
}

class LoadDetails extends MaterialsDetailsEvent {
  final MaterialDatum material;

  LoadDetails(this.material);

  @override
  String toString() => 'LoadDetails';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, MaterialsDetailsBloc bloc}) async* {
    try {
      yield LoadingBaseState();
      final offlineData =
          await OfflineLibraryHelper.getOfflineMaterial(material);
      if (offlineData == null) {
        final result = await getMaterialDetails(material.id, material.syllabus);
        if (result != null) {
          bloc.material = result;
          if (bloc.material.type == 2 || bloc.material.type == 3)
            bloc.document = await PDFDocument.fromURL(bloc.material.attachment);
          yield MaterialDetailsLoadedState();
        }
      } else {
        bloc.material = offlineData;
        if (bloc.material.type == 2 || bloc.material.type == 3)
          bloc.document = await PDFDocument.fromFile(File(bloc.material.path));
        yield MaterialDetailsLoadedState();
      }
    } catch (e, st) {
      print(st);

      yield ErrorBaseState(e?.toString());
    }
  }
}

class UpdateDatum extends MaterialsDetailsEvent {
  final MaterialDatum datum;

  UpdateDatum(this.datum);

  @override
  String toString() => 'UpdateDatum';

  @override
  Stream<BaseState> applyAsync(
      {BaseState currentState, MaterialsDetailsBloc bloc}) async* {
    try {
      if (datum != null) {
        bloc.material = datum;
        yield MaterialDetailsLoadedState();
      }
    } catch (_, st) {
      print(st);
      yield ErrorBaseState(_?.toString());
    }
  }
}
