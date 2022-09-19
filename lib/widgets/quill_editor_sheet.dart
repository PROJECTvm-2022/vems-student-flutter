import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor/html_editor.dart';
import 'package:vems/widgets/button.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 26/5/21 at 2:25 PM
///

class QuillEditorSheet extends StatefulWidget {
  final Function(String) onSend;

  QuillEditorSheet(this.onSend);

  @override
  _QuillEditorSheetState createState() => _QuillEditorSheetState();
}

class _QuillEditorSheetState extends State<QuillEditorSheet> {
  // final TextEditingController controller = TextEditingController();
  GlobalKey<HtmlEditorState> _editorKey = GlobalKey();

  // @override
  // void initState() {
  //   super.initState();
  //   controller.addListener(() {
  //     setState(() {});
  //   });
  // }

  // @override
  // void dispose() {
  // controller.dispose();
  // super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    return SizedBox(
      height: height / 1.3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: HtmlEditor(
                hint: "Type something...",
                //value: "Initial value",
                key: _editorKey,
                height: 500,
                useBottomSheet: false,
              ),
            ),
            const SizedBox(height: 8),
            MyButton(
              child: Text("Send"),
              onPressed: () async {
                final text = await _editorKey.currentState?.getText();
                if (text.trim().isNotEmpty) {
                  widget.onSend?.call(text);
                  _editorKey.currentState?.setText("");
                }
              },
            ),
            // IconButton(
            //     icon: Icon(Icons.send),
            //     color: Get.theme.primaryColor,
            //     disabledColor: Colors.grey[800],
            //     onPressed: () async {
            //       final text = await _editorKey.currentState?.getText();
            //       if (text.trim().isNotEmpty) {
            //         widget.onSend?.call(text);
            //         _editorKey.currentState?.setText("");
            //       }
            //     }),
          ],
        ),
      ),
    );
  }
}

//
// Get.bottomSheet(SendMessageWidget(onSend),
// shape: RoundedRectangleBorder(
// borderRadius:
// BorderRadius.vertical(top: Radius.circular(12))),
// backgroundColor: Colors.grey[300],
// ignoreSafeArea: false,
// isScrollControlled: true);
