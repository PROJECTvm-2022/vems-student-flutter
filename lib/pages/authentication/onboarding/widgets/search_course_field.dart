import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vems/api_services/courses_api_services.dart';
import 'package:vems/config/assets.dart';
import 'package:vems/config/index.dart';
import 'package:vems/data_models/course_data.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/utils/my_form_validators.dart';
import 'package:vems/widgets/custom_textfield.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 6/1/21 at 11:19 AM
///

class SearchCourseField extends StatefulWidget {
  final Function(String text) onChanged;
  final Function(CourseDatum d) onSuggestionSelected;
  final String instituteId;

  SearchCourseField(
      {this.onChanged, this.onSuggestionSelected, this.instituteId});

  @override
  _SearchCourseFieldState createState() => _SearchCourseFieldState();
}

class _SearchCourseFieldState extends State<SearchCourseField> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyCustomFormField(
      onSuggestionSelected: (data) {
        CourseDatum datum = data;
        setState(() {
          _textEditingController.text = datum.name;
        });
        widget.onSuggestionSelected(datum);
      },
      itemBuilder: (ctx, data) {
        //ServiceOnProduct datum = data;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 15),
            child: Text(
              data.name,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : MyColors.darkTextColor,
              ),
            ),
          ),
          decoration: BoxDecoration(
            border:
                Border(top: BorderSide(color: Colors.grey.withOpacity(0.2))),
          ),
        );
      },
      suggestionsBoxVerticalOffset: 0,
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      suggestionsCallback: (pattern) async {
        var result = await getCourses(
          courseName: _textEditingController.text.trim(),
          instituteId: widget.instituteId,
          skip: 0,
          limit: 30,
        );
        return result;
      },
      validator: (value) {
        return MyFormValidators.validateEmpty(value.trim());
      },
      noItemsFoundBuilder: (ctx) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(S.of(context).noCoursesFound),
      ),
      hideOnEmpty: false,
      textFieldConfiguration: TextFieldConfiguration(
        controller: _textEditingController,
        onChanged: (value) {
          widget.onChanged(value);
        },
        decoration: MyDecorations.textFieldDecoration(context).copyWith(
          hintText: S.of(context).searchForCourses,
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: SvgPicture.asset(MyAssets.search),
          ),
        ),
      ),
    );
  }
}
