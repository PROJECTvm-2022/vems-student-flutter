import 'package:flutter/material.dart';
import 'package:vems/config/index.dart';
import 'package:vems/data_models/question_data.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/exams/widgets/html_view.dart';
import 'package:vems/pages/video_player/questions/widgets/mcq_option_card.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 3/4/21 at 8:52 AM
///

class ExamQuestionCard extends StatefulWidget {
  final QuestionDatum datum;
  final int index;
  final Function(String i) onChanged;
  final String answer;
  const ExamQuestionCard(
      {Key key, this.datum, this.index, this.onChanged, this.answer})
      : super(key: key);

  @override
  State<ExamQuestionCard> createState() => _ExamQuestionCardState();
}

class _ExamQuestionCardState extends State<ExamQuestionCard> {
  TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: widget.datum.myChoice);
  }

  @override
  void didUpdateWidget(covariant ExamQuestionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.answer == "") {
      textEditingController.clear();
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _foregroundColor = Theme.of(context).brightness == Brightness.light
        ? MyColors.lightTextColor
        : Colors.white.withOpacity(0.8);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 80),
      children: [
        // Text(
        //   "Q.${(widget.index + 1)}:  ${_datum.question}",
        //   style: TextStyle(
        //     fontSize: 16,
        //     fontWeight: FontWeight.w700,
        //   ),
        // ),
        HtmlView('Q.${(widget.index + 1)}: ${widget.datum.question}',
            color: _foregroundColor),
        // Html(data: 'Q.${(widget.index + 1)}: ${_datum.question}'),
        const SizedBox(height: 10),
        widget.datum.answerType == 2
            ? Padding(
                padding: const EdgeInsets.only(top: 8),
                child: TextField(
                    controller: textEditingController,
                    onChanged: (val) {
                      widget.onChanged(val.trim());
                    },
                    autofocus: true,
                    decoration:
                        MyDecorations.textFieldDecoration(context).copyWith(
                      hintText: S.of(context).enterYourAnswer,
                    )),
              )
            : Column(
                children: [
                  ...widget.datum.choices.map((e) {
                    return MCQOptionCard(
                      isSelected: widget.datum.myChoice == e,
                      isExam: true,
                      name: '$e',
                      onTap: () {
                        widget.onChanged(e);
                        // setState(() {
                        //   answer = e;
                        //   widget.onChanged(e);
                        // });
                      },
                    );
                  }).toList()
                ],
              ),
      ],
    );
  }
}
