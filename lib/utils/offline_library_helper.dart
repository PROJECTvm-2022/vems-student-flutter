import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:vems/data_models/chapter_data.dart';
import 'package:vems/data_models/material.dart';
import 'package:vems/data_models/subject_data.dart';
import 'package:vems/data_models/unit_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class OfflineLibraryHelper {
  static const DB_NAME = 'jupion.db';

  static Database db;

  static Future<void> openDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/" + OfflineLibraryHelper.DB_NAME;
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table library ( 
  id integer primary key autoincrement, 
  _id text not null,
  title text not null,
  description text not null,
  type integer not null,
  chapter String not null,
  unit String not null,
  subject String not null,
  path String not null,
  thumbnailPath String not null,
  duration integer
  )
''');
    });
  }

  static Future<void> storeMaterial(
      MaterialDatum material, String subjectName, String subjectId) async {
    if ((await getOfflineMaterial(material)) == null)
      await db.insert(
          'library',
          {
            'title': material.title,
            '_id': material.id,
            'description': material.description,
            'type': material.type,
            'chapter': json.encode(
                {'id': material.chapter.id, 'name': material.chapter.name}),
            'unit': json
                .encode({'id': material.unit.id, 'name': material.unit.name}),
            'subject': json.encode({'id': subjectId, 'name': subjectName}),
            'path': material.path,
            'thumbnailPath': material.thumbnailPath,
            'duration': material.duration
          },
          conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> removeMaterial(MaterialDatum material) async {
    await db.delete('library', where: '_id = ?', whereArgs: [material.id]);
  }

  static Future<List<MaterialDatum>> getAllMaterials() async {
    List<Map<String, dynamic>> list = await db.query('library');
    return list.map((e) => MaterialDatum.fromSqlJson(e)).toList();
  }

  static Future<MaterialDatum> getOfflineMaterial(
      MaterialDatum material) async {
    List<Map<String, dynamic>> list =
        await db.query('library', where: '_id = ?', whereArgs: [material.id]);
    if (list.isEmpty) return null;
    return MaterialDatum.fromSqlJson(list.first);
  }

  static Future<List<SubjectDatum>> getOfflineSubjects() async {
    List<Map<String, dynamic>> list =
        await db.query('library', distinct: true, columns: ['subject']);

    return list
        .map((e) => SubjectDatum(
              id: json.decode(e['subject'])['id'],
              name: json.decode(e['subject'])['name'],
            ))
        .toList();
  }

  static Future<List<UnitDatum>> getOfflineUnits(SubjectDatum subject) async {
    List<Map<String, dynamic>> list = await db.query(
      'library',
      distinct: true,
      columns: ['unit'],
      where: subject == null ? null : 'subject = ?',
      whereArgs: subject == null
          ? []
          : [
              json.encode({'id': subject.id, 'name': subject.name})
            ],
    );

    return list
        .map((e) => UnitDatum(
              id: json.decode(e['unit'])['id'],
              name: json.decode(e['unit'])['name'],
            ))
        .toList();
  }

  static Future<List<ChapterDatum>> getOfflineChapters(UnitDatum unit) async {
    List<Map<String, dynamic>> list = await db.query(
      'library',
      distinct: true,
      columns: ['chapter'],
      where: unit == null ? null : 'unit = ?',
      whereArgs: unit == null
          ? []
          : [
              json.encode({'id': unit.id, 'name': unit.name})
            ],
    );

    return list
        .map((e) => ChapterDatum(
              id: json.decode(e['chapter'])['id'],
              name: json.decode(e['chapter'])['name'],
            ))
        .toList();
  }

  static Future<bool> deleteDb() async {
    bool databaseDeleted = false;

    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path =
          documentsDirectory.path + "/" + OfflineLibraryHelper.DB_NAME;
      await deleteDatabase(path).whenComplete(() {
        databaseDeleted = true;
      }).catchError((onError) {
        databaseDeleted = false;
      });
    } on DatabaseException catch (error) {
      print(error);
    } catch (error) {
      print(error);
    }

    return databaseDeleted;
  }

  static Future<void> deleteMaterial(MaterialDatum data) async {
    try {
      await db.rawDelete('DELETE FROM library WHERE _id = ?', [data.id]);
    } catch (e) {
      log("deleteMaterial", error: e);
    }
  }
}
