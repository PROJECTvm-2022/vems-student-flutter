import 'package:vems/api_services/base_api.dart';
import 'package:vems/config/api_routes.dart';
import 'package:vems/data_models/chapter_data.dart';
import 'package:vems/data_models/subject_data.dart';
import 'package:vems/data_models/unit_data.dart';
import 'package:vems/data_models/video_data.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 11/1/21 at 8:46 PM
///

/// Get All Subjects assigned to the ems
Future<List<StudentSubjectData>> getSubjects() async {
  Map<String, dynamic> query = {
    r"$populate": "subject",
  };

  final result = await ApiCall.get(ApiRoutes.subject, query: query);

  return List<StudentSubjectData>.from(
      result.data.map((x) => StudentSubjectData.fromJson(x)));
}

/// Get all units of a subject
Future<List<UnitDatum>> getUnits(
  String syllabus, {
  int skip = 0,
  int limit = 40,
}) async {
  Map<String, dynamic> query = {
    "syllabus": syllabus,
    if (limit != -1) "\$skip": skip,
    "\$limit": limit,
  };

  final result = await ApiCall.get(ApiRoutes.unit, query: query);
  return List<UnitDatum>.from(
    limit != -1
        ? result.data['data'].map((x) => UnitDatum.fromJson(x))
        : result.data.map((x) => UnitDatum.fromJson(x)),
  );
}

/// Get all chapters of a unit
Future<List<ChapterDatum>> getChapters(
  String id, {
  int skip = 0,
  int limit = 40,
}) async {
  Map<String, dynamic> query = {
    "unit": id,
    if (limit != -1) "\$skip": skip,
    "\$limit": limit,
  };

  final result = await ApiCall.get(ApiRoutes.chapter, query: query);
  return List<ChapterDatum>.from(
    limit != -1
        ? result.data['data'].map((x) => ChapterDatum.fromJson(x))
        : result.data.map((x) => ChapterDatum.fromJson(x)),
  );
}

/// Get all videos of a chapter
Future<List<StudentVideoDatum>> getVideos(
  String chapter, {
  int skip = 0,
  int limit = 40,
  String title = '',
}) async {
  Map<String, dynamic> query = {
    "chapter": chapter,
    "\$populate": ['videoId', 'unit', 'chapter', 'instituteBatchVideo'],
    "\$skip": skip,
    "\$limit": limit,
    "\$sort[scheduledOn]": 1,
  };

  final result = await ApiCall.get(ApiRoutes.video, query: query);
  return List<StudentVideoDatum>.from(
      result.data['data'].map((x) => StudentVideoDatum.fromJson(x)));
}
