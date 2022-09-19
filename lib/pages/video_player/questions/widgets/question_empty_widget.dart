import 'package:flutter/material.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/widgets/outlined_button.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 15/1/21 at 7:24 PM
///

class QuestionsEmptyWidget extends StatelessWidget {
  final VoidCallback onFinish;

  const QuestionsEmptyWidget({Key key, this.onFinish}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 40),
          Text(S.of(context).noQuestionsAvailable),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MyOutlineButton(
              height: 44,
              width: double.infinity,
              text: S.of(context).back,
              onPressed: onFinish,
            ),
          ),
        ],
      ),
    );
  }
}
