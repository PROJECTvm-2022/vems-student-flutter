import 'package:flutter/material.dart';
import 'package:vems/bloc_models/video_questions_bloc/index.dart';
import 'package:vems/bloc_models/video_questions_bloc/video_questions_bloc.dart';
import 'package:vems/data_models/question_data.dart';
import 'package:vems/pages/video_player/questions/widgets/mcq_option_card.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 14/1/21 at 8:06 PM
///

class MCQQuestionCard extends StatefulWidget {
  final QuestionDatum datum;
  final List<QuestionAnswerDatum> answers;
  final Function(QuestionAnswerDatum r) onChanged;

  const MCQQuestionCard({Key key, this.datum, this.onChanged, this.answers})
      : super(key: key);

  @override
  _MCQQuestionCardState createState() => _MCQQuestionCardState();
}

class _MCQQuestionCardState extends State<MCQQuestionCard> {
  int selectedIndex = -1;

  VideoQuestionsBloc get _questionBloc => VideoQuestionsBloc();

  initialize() {
    if (widget.answers != null && widget.answers.isNotEmpty) {
      widget.answers.forEach((element) {
        if (element.question == widget.datum.id) {
          selectedIndex = widget.datum.choices.indexOf(element.answer);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Q.${_questionBloc.questions.indexOf(widget.datum) + 1}: ' +
                    widget.datum.question ??
                '',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 60),
              physics: const BouncingScrollPhysics(),
              children: widget.datum.choices.map((e) {
                int index = widget.datum.choices.indexOf(e);
                return MCQOptionCard(
                  name: e,
                  isSelected: index == selectedIndex,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    widget.onChanged(QuestionAnswerDatum(
                      question: widget.datum.id,
                      answer: e,
                    ));
                  },
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
