import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vems/config/assets.dart';
import 'package:vems/config/decorations.dart';
import 'package:vems/data_models/schedule_cell_datum.dart';
import 'package:timeago/timeago.dart' as time_ago;

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 6/1/21 at 12:17 AM
///

/// Get duration in mm:ss
String getDurationInMinutesAndSeconds(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "$twoDigitMinutes:$twoDigitSeconds";
}

String obscuredMail(String mail) {
  if (GetUtils.isEmail(mail)) {
    List<String> spans = mail.split('@');
    String oldSpan = spans[0];
    int startFrom = (oldSpan.length / 2).floor();
    String newSpan = oldSpan.replaceRange(
        startFrom, oldSpan.length, '*' * (oldSpan.length - startFrom));
    return newSpan + '@' + spans[1];
  } else {
    return mail;
  }
}

String compactCount(int count) {
  return NumberFormat.compact().format(count);
}

String timeInAgoShort(DateTime dateTime) {
  return time_ago.format(dateTime, locale: 'en_short', allowFromNow: true);
}

String timeInAgoFull(DateTime dateTime) {
  return time_ago.format(dateTime, locale: 'en', allowFromNow: true);
}

String scheduleTimeFormat(TimeDatum datum, [bool singleLine = true]) {
  if (singleLine) {
    return '${timeInAMPM(datum.startingTime)} - ${timeInAMPM(datum.endingTime)}';
  } else {
    return '${timeInAMPM(datum.startingTime)} - \n ${timeInAMPM(datum.endingTime)}';
  }
}

String timeInAMPM(int time) {
  if (time / 60 == 12) {
    return "12 : 00 PM";
  } else if (time / 60 > 12) {
    return "${(time / 60 - 12).truncate().toString().padLeft(2, "0")} : ${(time % 60).toString().padLeft(2, "0")} PM";
    // return "${(time / 60 - 12).toStringAsFixed(2)} PM";
  } else {
    return "${(time / 60).truncate().toString().padLeft(2, "0")} : ${(time % 60).toString().padLeft(2, "0")} AM";
    // return "${(time / 60).toStringAsFixed(2)} AM";
  }
}

String countDownTimeFormatFromSeconds(int seconds,
    {bool isShort = false,
    bool isHrMin = false,
    bool hhMMss = false,
    bool mmSS = false}) {
  Duration(seconds: seconds);

  String result = '';
  int year = (Duration(seconds: seconds).inDays / 365).truncate();
  int month = (Duration(seconds: seconds).inDays / 30).truncate() - year * 12;
  int day = Duration(seconds: seconds).inDays - month * 30 - year * 365;
  int hour = Duration(seconds: seconds).inHours -
      day * 24 -
      month * 30 * 24 -
      year * 365 * 24;
  int minute = Duration(seconds: seconds).inMinutes -
      hour * 60 -
      day * 24 * 60 -
      month * 30 * 24 * 60 -
      year * 365 * 30 * 24 * 60;
  int second = seconds -
      minute * 60 -
      hour * 60 * 60 -
      day * 24 * 60 * 60 -
      month * 30 * 24 * 60 * 60 -
      year * 365 * 24 * 60 * 60;
  if (year > 0) {
    result += '$year Yr : ';
  }
  if (month > 0) {
    result += '$month Mon : ';
  }
  if (day > 0) {
    result += '${day.toString().padLeft(2, '0')} D : ';
  }
  if (mmSS) {
    return "${minute.toString().padLeft(2, '0')}m : ${second.toString().padLeft(2, '0')}s";
  }
  if (isShort) {
    return "${hour.toString().padLeft(2, '0')}h : ${minute.toString().padLeft(2, '0')}m : ${second.toString().padLeft(2, '0')}s";
  }
  if (hhMMss) {
    String temp = hour > 0 ? '${hour.toString().padLeft(2, '0')}' : '';
    return temp +
        "${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}";
  }
  if (isHrMin) {
    return "${hour.toString().padLeft(2, '0')} : ${minute.toString().padLeft(2, '0')} Hr";
  }
  return result +
      '${hour.toString().padLeft(2, '0')} Hr : ${minute.toString().padLeft(2, '0')} Min : ${second.toString().padLeft(2, '0')} Sec';
}

String wish() {
  DateTime date = DateTime.now();
  if (date.hour >= 5 && date.hour < 12) {
    return 'Good Morning';
  } else if (date.hour >= 12 && date.hour <= 17) {
    return 'Good Afternoon';
  } else if (date.hour > 17 && date.hour < 20) {
    return 'Good Evening';
  } else {
    return 'Good Night';
  }
}

String wishAsset() {
  DateTime date = DateTime.now();
  if (date.hour >= 5 && date.hour < 12) {
    return MyAssets.morning;
  } else if (date.hour >= 12 && date.hour <= 17) {
    return MyAssets.afternoon;
  } else if (date.hour > 17 && date.hour < 20) {
    return MyAssets.evening;
  } else {
    return MyAssets.night;
  }
}

LinearGradient dynamicDashboardGradient(BuildContext context) {
  DateTime date = DateTime.now();
  if (date.hour >= 5 && date.hour < 12) {
    return MyDecorations.morningGradient(context);
  } else if (date.hour >= 12 && date.hour <= 17) {
    return MyDecorations.afternoonGradient(context);
  } else if (date.hour > 17 && date.hour < 20) {
    return MyDecorations.eveningGradient(context);
  } else {
    return MyDecorations.nightGradient(context);
  }
}

String nth(val) {
  if (val == 11) {
    return 'th';
  }
  List<String> d = val.toString().split('');
  String last = d[d.length - 1];
  int digit = int.parse(last);
  if (digit > 3 && digit < 21) {
    return "th";
  }
  switch (digit) {
    case 1:
      return "st";
    case 2:
      return "nd";
    case 3:
      return "rd";
    default:
      return "th";
  }
}
