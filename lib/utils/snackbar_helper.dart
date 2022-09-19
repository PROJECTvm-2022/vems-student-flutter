import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SnackBarHelper {
  static Future<void> show(String title, String message,
      {isLong = false}) async {
    Fluttertoast.showToast(
        msg: message,
        toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showLoader(Future onProgress,
      {String title, String message}) async {
    Get.snackbar(title ?? '', message ?? '',
        showProgressIndicator: onProgress != null,
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
        animationDuration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.all(16));
    onProgress.catchError((e) {}).whenComplete(() {
      if (Get.isSnackbarOpen) Get.back();
    });
  }
}
