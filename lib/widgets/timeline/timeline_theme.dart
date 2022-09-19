///
/// Created by Auro (auro@smarttersstudio.com) on 08/07/21 at 8:22 am
///

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vems/widgets/timeline/timeline_utils.dart';

/// Controls the default color, opacity, and size of timeline in a widget subtree.
/// The timeline theme is honored by [Timeline] widgets.
class TimelineTheme extends InheritedTheme {
  final TimelineThemeData data;
  final Widget child;

  /// Creates an timeline theme that controls the styles of descendant widgets.
  /// Both [data] and [child] arguments must not be null.
  const TimelineTheme({Key key, @required this.data, @required this.child})
      : super(key: key, child: child);

  static TimelineThemeData of(BuildContext context) {
    final TimelineThemeData timelineThemeData =
        _getInheritedTimelineThemeData(context).resolve(context);
    return timelineThemeData;
  }

  static TimelineThemeData _getInheritedTimelineThemeData(
      BuildContext context) {
    final TimelineTheme timelineTheme =
        context.dependOnInheritedWidgetOfExactType<TimelineTheme>();
    return timelineTheme?.data ?? TimelineThemeData.fallback();
  }

  @override
  bool updateShouldNotify(TimelineTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    final TimelineTheme timelineTheme =
        context.findAncestorWidgetOfExactType<TimelineTheme>();
    return identical(this, timelineTheme)
        ? child
        : TimelineTheme(data: data, child: child);
  }
}

/// [TimelineThemeData] is passed through [TimelineTheme], works like general flutter theme object.
class TimelineThemeData with Diagnosticable {
  TimelineThemeData({
    this.gutterSpacing = 12.0,
    this.itemGap = 24.0,
    this.lineGap = 0.0,
    this.strokeWidth = 4.0,
    this.strokeCap = StrokeCap.butt,
    this.lineColor = Colors.lightBlueAccent,
    this.style = PaintingStyle.stroke,
    this.indicatorPosition = IndicatorPosition.center,
  })  : assert(itemGap >= 0),
        assert(lineGap >= 0);

  final Color lineColor;
  final double lineGap;
  final StrokeCap strokeCap;
  final double strokeWidth;
  final PaintingStyle style;
  final double itemGap;
  final double gutterSpacing;

  /// the position of the indicator. this affects the placing of the indicator, and following line measurement
  final IndicatorPosition indicatorPosition;

  /// Creates an timeline them with some reasonable default values.
  ///
  /// The [color] is black, the [opacity] is 1.0, and the [size] is 24.0.
  const TimelineThemeData.fallback()
      : lineColor = Colors.lightBlueAccent,
        lineGap = 0.0,
        strokeCap = StrokeCap.butt,
        strokeWidth = 4.0,
        style = PaintingStyle.stroke,
        itemGap = 24.0,
        gutterSpacing = 12.0,
        indicatorPosition = IndicatorPosition.center;

  TimelineThemeData copyWith(
      {Color lineColor, StrokeCap strokeCap, double strokeWidth}) {
    return TimelineThemeData(
      lineColor: lineColor ?? this.lineColor,
      strokeCap: strokeCap ?? this.strokeCap,
      strokeWidth: strokeWidth ?? this.strokeWidth,
    );
  }

  TimelineThemeData resolve(BuildContext context) => this;
}
