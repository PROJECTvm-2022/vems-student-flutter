import 'package:flutter/material.dart';
import 'package:vems/config/colors.dart';
import 'package:vems/data_models/question_data.dart';
import 'package:vems/pages/video_player/questions/widgets/result_tile.dart';
import 'package:vems/widgets/back_button.dart';
import 'package:vems/widgets/button.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 1/3/21 at 1:05 AM
///

class ViewResultWidget extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  final List<QuestionDatum> questions;
  final List<QuestionAnswerDatum> answers;

  const ViewResultWidget(
      {Key key, this.onNext, this.onBack, this.questions, this.answers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<QuestionAnswerDatum> qns = [];
    questions.forEach((element) {
      qns.add(QuestionAnswerDatum(
          question: element.question,
          answer: answers.where((e) => e.question == element.id).first.answer,
          correctAnswer: answers
              .where((e) => e.question == element.id)
              .first
              .correctAnswer,
          status: answers.where((e) => e.question == element.id).first.status));
    });
    return Column(
      children: [
        AppBar(
          leading: MyBackButton(
            onTap: onBack,
          ),
          centerTitle: true,
          title: Text(
            "Score : ${qns.where((element) => element.status == 1).length} / ${qns.length}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: MyColors.hardGrey,
            ),
          ),
          titleSpacing: 0,
          elevation: 1,
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : MyColors.darkTFColor,
        ),
        Expanded(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: qns.map((qaDatum) {
              int index = qns.indexOf(qaDatum);
              return index == -1
                  ? SizedBox()
                  : ResultTile(
                      index: index + 1,
                      qaDatum: qaDatum,
                    );
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: MyButton(
            height: 44,
            width: double.infinity,
            child: Text("Next video"),
            onPressed: onNext,
          ),
        ),
      ],
    );
  }
}
