import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class CheckPermissions {
  static Future requestStorage() async {
    var status = await Permission.storage.status;
    if (status.isRestricted) {
      var result = await Permission.storage.request();
      print(result.toString());
      if (result.isGranted) {}
      if (result.isDenied) {
        throw 'Please Allow Storage permission to continue';
      }
      if (result.isPermanentlyDenied) {
        // AppSettings.openAppSettings();
        throw 'Please Allow Storage permission to continue';
      }
    }
  }

  static Future<bool> checkStoragePermission() async {
    if (await Permission.storage.isGranted) {
      return true;
    } else {
      final res = await Permission.storage.request();
      if (res.isGranted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
