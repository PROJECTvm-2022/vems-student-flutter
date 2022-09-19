import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vems/config/decorations.dart';
import 'package:vems/config/index.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/dashboard/pages/lectures/widgets/subject_grid.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 8/1/21 at 1:40 AM
///

class LecturesPage extends StatefulWidget {
  @override
  _LecturesPageState createState() => _LecturesPageState();
}

class _LecturesPageState extends State<LecturesPage> {
  final _gridKey = GlobalKey<SubjectsGridState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SubjectsGrid(
          key: _gridKey,
        ),
        Positioned(
          top: 18,
          left: 16,
          right: 16,
          child: TextFormField(
            onChanged: (query) {
              _gridKey.currentState.refresh(query);
            },
            decoration: MyDecorations.textFieldDecoration(context).copyWith(
              hintText: S.of(context).searchForLectures,
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: SvgPicture.asset(MyAssets.search),
              ),
            ),
          ),
        )
      ],
    );
  }
}
