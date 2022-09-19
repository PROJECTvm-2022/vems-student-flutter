import 'package:flutter/material.dart';
import 'package:vems/config/index.dart';
import 'package:vems/data_models/question_data.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 1/3/21 at 1:11 AM
///

class ResultTile extends StatelessWidget {
  final int index;

  final QuestionAnswerDatum qaDatum;

  const ResultTile({Key key, this.index, this.qaDatum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Text("$index"),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).brightness == Brightness.light
                        ? MyColors.lightTFColor
                        : MyColors.darkTFColor),
              ),
              const SizedBox(height: 5),
              Icon(
                qaDatum.status == 1 ? Icons.check_box : Icons.cancel,
                color: qaDatum.status == 1 ? Colors.green : Colors.red,
              )
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  qaDatum.question ?? '',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text("Answer : ${qaDatum.answer}"),
                if (qaDatum.status == 2)
                  Text(
                      "Correct answer : ${(qaDatum.correctAnswer.isEmpty ? '' : qaDatum.correctAnswer.first)}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
