import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vems/config/index.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/widgets/button.dart';
import 'package:vems/widgets/outlined_button.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 9/4/21 at 4:54 PM
///

class ExamActionWidget extends StatelessWidget {
  final VoidCallback onSkip;
  final VoidCallback onNext;
  final VoidCallback onSubmit;
  final VoidCallback onPrevious;
  final VoidCallback onErase;
  final bool isOnlySubmit;
  final int currentIndex;

  const ExamActionWidget(
      {Key key,
      this.onSkip,
      this.onNext,
      this.onSubmit,
      this.isOnlySubmit = false,
      this.onPrevious,
      this.onErase,
      this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isOnlySubmit
        ? Column(
            children: [
              Row(
                children: [
                  currentIndex == 0
                      ? SizedBox()
                      : Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Get.theme.canvasColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: MyOutlineButton(
                              height: 49,
                              width: 94,
                              text: "Previous",
                              onPressed: onPrevious,
                            ),
                          ),
                        ),
                  currentIndex == 0
                      ? SizedBox()
                      : onErase == null
                          ? SizedBox()
                          : SizedBox(width: 16),
                  if (onErase != null)
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Get.theme.canvasColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: MyOutlineButton(
                          height: 49,
                          width: 94,
                          text: "Erase",
                          onPressed: onErase,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              MyButton(
                child: Text(S.of(context).submit),
                width: double.infinity,
                onPressed: onSubmit,
                color: MyColors.green,
              ),
            ],
          )
        : Column(
            children: [
              Row(
                children: [
                  currentIndex == 0
                      ? SizedBox()
                      : Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Get.theme.canvasColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: MyOutlineButton(
                              height: 49,
                              width: 94,
                              text: "Previous",
                              onPressed: onPrevious,
                            ),
                          ),
                        ),
                  currentIndex == 0
                      ? SizedBox()
                      : onErase == null
                          ? SizedBox()
                          : SizedBox(width: 16),
                  if (onErase != null)
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Get.theme.canvasColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: MyOutlineButton(
                          height: 49,
                          width: 94,
                          text: "Erase",
                          onPressed: onErase,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Get.theme.canvasColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: MyOutlineButton(
                        height: 49,
                        width: 94,
                        text: S.of(context).skip,
                        onPressed: onSkip,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: MyButton(
                      height: 50,
                      child: Text("Save & Next"),
                      onPressed: onNext,
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
