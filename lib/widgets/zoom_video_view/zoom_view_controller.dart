import 'package:flutter/services.dart';
import 'package:vems/widgets/zoom_video_view/data_models.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 10/3/21 at 5:20 PM
///

class ZoomViewController {
  MethodChannel _channel;
  EventChannel _eventChannel;

  ZoomViewController.init(int id) {
    _channel = MethodChannel('vems/zoom');
    _eventChannel = EventChannel('vems/zoom_event_stream');
  }

  Future<List> initialize(ZoomOptions options) async {
    assert(options != null);

    return _channel.invokeMethod('init', {
      'jwtToken': options.jwtToken,
      'appKey': options.appKey,
      'appSecret': options.appSecret,
      'domain': options.domain,
    });
  }

  Future<bool> joinMeeting(
      String displayName, String meetingId, String meetingPassword) async {
    return _channel.invokeMethod('joinMeeting', {
      'displayName': displayName,
      'meetingId': meetingId,
      'meetingPassword': meetingPassword,
    });
  }

  Future<void> leaveMeeting() async {
    _channel.invokeMethod('leaveMeeting');
  }

  Future<void> handleMic(bool mute) async {
    _channel.invokeMethod('handleMic', {
      "mute": mute,
    });
  }

  Future<void> handleRaiseHand(bool raiseHand) async {
    _channel.invokeMethod('handleRaiseHand', {
      "raiseHand": raiseHand,
    });
  }

  Future<List> meetingStatus(String meetingId) async {
    assert(meetingId != null);

    var optionMap = new Map<String, String>();
    optionMap.putIfAbsent("meetingId", () => meetingId);

    return _channel.invokeMethod('meeting_status', optionMap);
  }

  Stream<dynamic> get zoomStatusEvents {
    return _eventChannel.receiveBroadcastStream();
  }
}
