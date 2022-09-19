import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vems/bloc_models/exam_bloc/exam_details_bloc/index.dart';
import 'package:vems/config/functions.dart';
import 'package:vems/config/index.dart';
import 'package:vems/pages/exams/widgets/times_up_dialogue.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 3/4/21 at 8:33 AM
///

class ExamQuestionsTopBar extends StatefulWidget {
  final VoidCallback onTap;
  final String examId;

  const ExamQuestionsTopBar({
    Key key,
    this.onTap,
    this.examId,
  }) : super(key: key);

  @override
  _ExamQuestionsTopBarState createState() => _ExamQuestionsTopBarState();
}

class _ExamQuestionsTopBarState extends State<ExamQuestionsTopBar> {
  Timer _timer;

  int get _secondsLeft => ExamDetailsBloc()
      .exam
      .exam
      .scheduledOn
      .add(Duration(minutes: _examDurationInMinutes))
      .difference(DateTime.now())
      .inSeconds;

  int get _examDurationInMinutes => ExamDetailsBloc().exam.exam.duration;

  void _startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(
          () {
            if (_secondsLeft < 1) {
              // when the exam times up
              timer.cancel();
              Get.dialog(TimesUpDialogue(examId: widget.examId));
            }
          },
        );
      },
    );
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Material(
            color: Get.theme.primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    ExamDetailsBloc().exam.studentName,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  )),
                  Text(
                    ExamDetailsBloc().exam.studentExamRoll,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              const SizedBox(width: 16),
              SvgPicture.asset(Theme.of(context).brightness == Brightness.light
                  ? MyAssets.clockBlack
                  : MyAssets.clockGrey),
              const SizedBox(width: 4),
              Text(
                "${countDownTimeFormatFromSeconds(_secondsLeft, isShort: true)}",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Spacer(),
              TextButton(
                onPressed: widget.onTap,
                child: Text("View Questions"),
              ),
              const SizedBox(width: 6),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: MyColors.borderGrey)),
      ),
    );
  }
}
