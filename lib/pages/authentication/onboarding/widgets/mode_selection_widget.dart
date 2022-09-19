import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vems/config/index.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 27/2/21 at 10:20 PM
///

class ModeSelectionWidget extends StatefulWidget {
  final String errorText;
  final List<String> data;
  final Function(String r) onChanged;
  final String hintText;

  ModeSelectionWidget(
      {this.onChanged, this.errorText, this.hintText, this.data});

  @override
  _ModeSelectionWidgetState createState() => _ModeSelectionWidgetState();
}

class _ModeSelectionWidgetState extends State<ModeSelectionWidget> {
  String _selectedValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ModeSelectionWidget oldWidget) {
    setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      dropdownColor: Theme.of(context).brightness == Brightness.light
          ? MyColors.lightTFColor
          : MyColors.darkTFColor,
      icon: Icon(
        Icons.arrow_drop_down,
        color: Get.theme.primaryColor,
      ),
      decoration: MyDecorations.textFieldDecoration(context),
      style: TextStyle(
          fontSize: 12,
          color: Get.theme.primaryColor,
          fontWeight: FontWeight.w500),
      hint: Text(
        widget.hintText,
        style: TextStyle(color: Colors.grey, fontSize: 13),
      ),
      value: _selectedValue,
      validator: (val) {
        return _selectedValue == null ? "Mode is required" : null;
      },
      onChanged: (value) {
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          _selectedValue = value;
          widget.onChanged(value);
        });
      },
      items: widget.data
          .map((e) => DropdownMenuItem(
              value: e,
              child: Text(
                e,
                style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white),
              )))
          .toList(),
    );
  }
}
