///
/// Created by Auro (auro@smarttersstudio.com) on 08/07/21 at 8:23 am
///

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class TimelineDots {
  TimelineDots({@required this.context});

  BuildContext context;

  factory TimelineDots.of(BuildContext context) {
    return TimelineDots(context: context);
  }

  Widget get simple {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        image: null,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget get borderDot {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          image: null,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          border: Border.all()),
    );
  }

  Widget get icon {
    return Icon(Icons.event);
  }

  Widget get section {
    return Container(
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: Colors.black,
        image: null,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget get circleIcon {
    return Container(
      width: 24,
      height: 24,
      child: Icon(
        Icons.event,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.all(
            Radius.circular(64),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.lightBlueAccent,
                blurRadius: 16,
                offset: Offset(0, 4))
          ]),
    );
  }

  Widget get sectionHighlighted {
    return Container(
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        image: null,
        shape: BoxShape.circle,
      ),
    );
  }
}

enum IndicatorPosition { top, center, bottom }

extension Mapper on IndicatorPosition {
  Alignment get asAlignment {
    switch (this) {
      case IndicatorPosition.top:
        return Alignment.topCenter;
      case IndicatorPosition.center:
        return Alignment.center;
      case IndicatorPosition.bottom:
        return Alignment.bottomCenter;
    }
  }
}

class TimelineEventDisplay {
  TimelineEventDisplay({
    @required this.child,
    this.indicator,
    this.indicatorSize,
    this.forceLineDrawing = false,
    this.anchor,
    this.indicatorOffset = const Offset(0, 0),
  });

  final Widget child;

  /// if not provided, use the default indicator size
  final double indicatorSize;
  final Widget indicator;

  /// enables indicator line drawing even no indicator is passed.
  final bool forceLineDrawing;

  /// [anchor] overrides the default IndicatorPosition
  final IndicatorPosition anchor;
  final Offset indicatorOffset;

  bool get hasIndicator {
    return indicator != null;
  }

  @override
  String toString() {
    return "Instance of TimelineEventDisplay:: indicator size = $indicatorSize";
  }
}

class TimelineEventCard extends StatelessWidget {
  final Widget title;
  final Widget content;

  TimelineEventCard({@required this.title, @required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: new BorderRadius.all(new Radius.circular(2.0)),
        ),
        child: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 16, top: 12, right: 16, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(context),
            SizedBox(
              height: 8,
            ),
            _description(context),
          ],
        ));
  }

  Widget _title(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.subtitle1 ?? TextStyle(),
      child: title,
    );
  }

  Widget _description(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.overline ?? TextStyle(),
      child: content,
    );
  }
}

class TimelineSectionDivider extends StatelessWidget {
  final Widget content;

  factory TimelineSectionDivider.byDate(DateTime date) {
    return TimelineSectionDivider(
      content: Text("$date"),
    );
  }

  const TimelineSectionDivider({Key key, @required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _content(context);
  }

  Widget _content(BuildContext context) {
    return AnimatedDefaultTextStyle(
        child: content,
        style: Theme.of(context).textTheme.headline5 ?? TextStyle(),
        duration: kThemeChangeDuration);
  }
}
