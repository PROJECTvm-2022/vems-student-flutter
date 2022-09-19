import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/exam_bloc/exam_details_bloc/index.dart';
import 'package:vems/config/index.dart';
import 'package:vems/data_models/exam_datum.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/exams/widgets/question_grid_card.dart';
import 'package:vems/widgets/button.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 3/4/21 at 9:34 AM
///

class QuestionsGridSheet extends StatefulWidget {
  final int currentIndex;
  final Function(int i) onChanged;
  final VoidCallback onSubmit;

  const QuestionsGridSheet(
      {Key key, this.currentIndex, this.onChanged, this.onSubmit})
      : super(key: key);

  @override
  _QuestionsGridSheetState createState() => _QuestionsGridSheetState();
}

class _QuestionsGridSheetState extends State<QuestionsGridSheet> {
  int _currentIndex = 0;

  List<ExamQuestionDatum> get _questions => ExamDetailsBloc().exam.answers;

  @override
  void initState() {
    _currentIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notVisitedColor = Colors.grey[400];
    final skippedColor = Colors.redAccent;
    final answeredColor = MyColors.green;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 5, 0, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).questions,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              IconButton(
                  icon: SvgPicture.asset(MyAssets.cross),
                  onPressed: () => Get.back())
            ],
          ),
        ),
        const Divider(
          height: 0,
          thickness: 1,
        ),
        Expanded(
          child: BlocBuilder<ExamDetailsBloc, BaseState>(
              builder: (context, BaseState state) {
            if (state is ErrorBaseState) {
              return Center(
                child: Text(state.errorMessage),
              );
            }
            if (state is LoadingBaseState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ExamDetailsLoadedState) {
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _questions.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.25),
                itemBuilder: (context, index) => QuestionGridCard(
                  index: index,
                  colorIndex: _questions[index].question.colorIndex,
                  isCurrentQuestion: index == _currentIndex,
                  onTap: () {
                    setState(() {
                      _currentIndex = index;
                    });
                    widget.onChanged(index);
                  },
                ),
              );
            }
            return SizedBox();
          }),
        ),
        const Divider(
          height: 0,
          thickness: 1,
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              QuestionColorWidget(
                name: 'Answered',
                color: answeredColor,
              ),
              QuestionColorWidget(
                name: 'Skipped',
                color: skippedColor,
              ),
              QuestionColorWidget(
                name: 'Not Visited',
                color: notVisitedColor,
              ),
              QuestionColorWidget(
                name: 'Current',
                color: MyColors.currentColor,
              ),
            ],
          ),
        ),
        MyButton(
          child: Text(S.of(context).submit),
          width: double.infinity,
          onPressed: widget.onSubmit,
          color: MyColors.green,
        )
      ],
    );
  }
}

class QuestionColorWidget extends StatelessWidget {
  final Color color;
  final String name;

  const QuestionColorWidget({Key key, this.color, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        SizedBox(width: 5),
        Text(
          name ?? '',
          style: TextStyle(
            fontSize: 12,
            color: MyColors.grey,
          ),
        ),
      ],
    );
  }
}
