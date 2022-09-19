import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:vems/data_models/exam_datum.dart';
import 'package:vems/pages/video_player/questions/widgets/mcq_option_card.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 4/4/21 at 11:16 AM
///

class QuestionAnswerWidget extends StatelessWidget {
  final ExamQuestionDatum datum;
  final int index;

  const QuestionAnswerWidget({Key key, this.datum, this.index = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   "Q.${(index + 1)}: ${datum.question.question}",
          //   style: TextStyle(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w700,
          //   ),
          // ),
          Html(data: 'Q.${(index + 1)}: ${datum.question.question}'),
          const SizedBox(height: 4),
          MCQOptionCard(
            isSelected: true,
            name: '${datum.question.answer.answerOfQuestion.first}',
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
