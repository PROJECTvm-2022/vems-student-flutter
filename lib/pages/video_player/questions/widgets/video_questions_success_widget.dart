import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vems/config/colors.dart';
import 'package:vems/config/index.dart';
import 'package:vems/widgets/button.dart';
import 'package:vems/widgets/outlined_button.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 15/1/21 at 7:25 PM
///

class VideoQuestionsSuccessPage extends StatelessWidget {
  final VoidCallback onFinish;
  final VoidCallback onViewResult;

  const VideoQuestionsSuccessPage({Key key, this.onFinish, this.onViewResult})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Spacer(),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "Congratulations",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: MyColors.darkBlue),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            color: Colors.white,
            child: Text(
              "New Video unlocked !!",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: MyColors.darkBlue),
            ),
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Get.theme.canvasColor,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: MyOutlineButton(
              height: 44,
              width: double.infinity,
              text: "View results",
              textStyle: TextStyle(
                fontSize: 16,
                color: MyColors.primaryBlue,
              ),
              onPressed: onViewResult,
              border: BorderSide(color: MyColors.primaryBlue),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: MyButton(
              height: 44,
              width: double.infinity,
              child: Text("Next video"),
              onPressed: onFinish,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
              'https://i.pinimg.com/originals/38/c4/92/38c492c1973da3210ac7afc1998d9495.png'),
        ),
      ),
    );
  }
}
