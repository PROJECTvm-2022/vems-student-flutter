import 'package:vems/api_services/base_api.dart';
import 'package:vems/config/api_routes.dart';
import 'package:vems/data_models/material.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 05/07/21 at 12:32 pm
///

Future<List<MaterialDatum>> getMaterials({
  int skip = 0,
  int limit = 5,
  Map<String, dynamic> additionalQuery,
}) async {
  Map<String, dynamic> query = {
    "\$skip": skip,
    "\$limit": limit,
    "\$populate": ["unit", "chapter", 'subject'],
    if (additionalQuery != null) ...additionalQuery,
    "\$sort": {
      "createdAt": -1,
    }
  };

  print("$query");
  final result = await ApiCall.get(ApiRoutes.materials, query: query);
  return List<MaterialDatum>.from(
      result.data['data'].map((x) => MaterialDatum.fromJson(x)));
}

Future<MaterialDatum> getMaterialDetails(
    String materialId, String syllabusId) async {
  Map<String, dynamic> query = {
    "syllabus": syllabusId,
    "\$populate": ["unit", "chapter", 'subject'],
  };

  print("$query");
  final result =
      await ApiCall.get(ApiRoutes.materials, query: query, id: materialId);
  print("${result.data}");
  return MaterialDatum.fromJson(result.data);
}

Future<List<MaterialDatum>> getRelatedVideos(String material) async {
  Map<String, dynamic> query = {
    "materialVideoId": material,
    "\$populate": ["unit", "chapter", 'subject'],
    "\$sort": {
      "createdAt": -1,
    }
  };

  print("$query");
  final result =
      await ApiCall.get(ApiRoutes.relatedMaterialVideo, query: query);
  return List<MaterialDatum>.from(
      result.data['data'].map((x) => MaterialDatum.fromJson(x)));
}
