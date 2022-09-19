///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 4/3/21 at 10:43 AM
///

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showJupionDialogue(
    {String title = '',
    String description,
    String positiveText = 'Ok',
    String negativeText = 'Cancel',
    Function positiveCallback,
    Function negativeCallBack}) {
  if (Platform.isAndroid)
    Get.dialog(AlertDialog(
      title: Text(title),
      content: description != null ? Text(description) : null,
      actions: [
        FlatButton(
          child: Text(negativeText),
          onPressed: negativeCallBack ??
              () {
                Get.back();
              },
        ),
        FlatButton(
          child: Text(positiveText),
          onPressed: positiveCallback ?? () {},
        ),
      ],
    ));
  else
    Get.dialog(CupertinoAlertDialog(
      title: Text(title),
      content: description != null ? Text(description) : null,
      actions: [
        CupertinoDialogAction(
          child: Text('No'),
          onPressed: negativeCallBack ??
              () {
                Get.back();
              },
        ),
        CupertinoDialogAction(
          child: Text('Yes'),
          onPressed: positiveCallback ?? () {},
        ),
      ],
    ));
}
