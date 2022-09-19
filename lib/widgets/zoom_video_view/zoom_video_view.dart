import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 10/3/21 at 5:19 PM
///

class ZoomVideoView extends StatelessWidget {
  final Function(int id) onPlatformViewCreated;

  static const viewId = 'vems/zoom_view';

  const ZoomVideoView({Key key, this.onPlatformViewCreated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AndroidView(
      viewType: viewId,
      gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
      hitTestBehavior: PlatformViewHitTestBehavior.opaque,
      onPlatformViewCreated: onPlatformViewCreated,
    );
  }
}
