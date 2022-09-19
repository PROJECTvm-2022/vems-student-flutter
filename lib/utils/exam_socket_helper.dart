import 'dart:async';
import 'dart:developer';

import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:flutter/material.dart';
import 'package:vems/bloc_models/exam_bloc/exam_details_bloc/exam_details_bloc.dart';
import 'package:vems/bloc_models/exam_bloc/exam_details_bloc/exam_details_event.dart';
import 'package:vems/config/api_routes.dart';
import 'package:vems/utils/shared_preference_helper.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 6/4/21 at 9:23 AM
///

mixin ExamSocketHelper {
  static const String EXAM_JOIN = 'v1/student-exam::patch';
  static const String EXAM_PATCHED = 'v1/student-exam patched';

  static SocketIO socket;
  static final SocketIOManager manager = SocketIOManager();

  static initSocket() async {
    socket = await manager.createInstance(SocketOptions(ApiRoutes.baseUrl,
        namespace: "/",
        query: {"Authorization": SharedPreferenceHelper.accessToken},
        enableLogging: false,
        transports: [Transports.webSocket]));
    _initListeners();
    _connectToSocket();
  }

  static _connectToSocket() async {
    if (await socket.isConnected()) {
      manager?.clearInstance(socket);
    }
    socket.onConnect.listen((data) async {
      debugPrint("Socket Connected");

      /// Authenticate event
      socket.emitWithAck("authenticate", [
        {
          "accessToken": SharedPreferenceHelper.accessToken,
          "strategy": "jwt",
          "fcmId": "212121",
        }
      ]).then((value) {
        debugPrint("Authenticate : $value");
      }).catchError((error) {
        debugPrint('Authenticate error : $error');
      });
    });
    socket.onConnectError.listen((data) {
      debugPrint('Connect error $data');
    });
    socket.connect();
  }

  static StreamSubscription _examPatched;
  static void _initListeners() {
    _examPatched = socket.on(EXAM_PATCHED).listen((data) {
      try {
        log("EXAM_PATCH ${DateTime.now().toIso8601String()} $data");
        final d = data is List ? data[0] : data;
        if (d['status'] != null) {
          ExamDetailsBloc().add(ExamStatusChange(d["status"]));
        }
      } catch (e, s) {
        log('$e $s');
      }
    });
  }

  static Future joinExamination(String examId) async {
    print(examId);
    return socket.emitWithAck(EXAM_JOIN, [
      examId,
      {"attendanceStatus": 2}
    ]).then((value) {
      print("on exam joined then " + value.toString());
    }).catchError((err) {
      print("error catched joining examination");
      print(err?.toString());
    }).onError((error, stackTrace) {
      print("on error occurred during examination");
      print(error?.toString());
    });
  }

  static disposeSocket() async {
    _disposeListeners();
    if (await socket.isConnected()) {
      manager?.clearInstance(socket);
    }
    debugPrint("Socket Disconnected");
  }

  static _disposeListeners() {
    _examPatched.cancel();
    //socket?.off(CHAT_CREATED);
  }
}
