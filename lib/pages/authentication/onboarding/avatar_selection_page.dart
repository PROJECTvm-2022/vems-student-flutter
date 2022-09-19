import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vems/api_services/authentication_api_services.dart';
import 'package:vems/api_services/base_api.dart';
import 'package:vems/config/index.dart';
import 'package:vems/data_models/user.dart';
import 'package:vems/pages/authentication/widgets/auth_text_widgets.dart';
import 'package:vems/utils/auth_helper.dart';
import 'package:vems/utils/shared_preference_helper.dart';
import 'package:vems/utils/snackbar_helper.dart';
import 'package:vems/widgets/back_button.dart';
import 'package:vems/widgets/button.dart';
import 'package:vems/widgets/logout_button.dart';
import 'package:vems/widgets/my_avatar.dart';
import 'package:vems/widgets/outlined_button.dart';
import 'package:vems/widgets/photo_chooser.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 11/09/21 at 10:11 pm
///

class AvatarSelectionPage extends StatefulWidget {
  static final routeName = '/AvatarSelectionPage';

  @override
  _AvatarSelectionPageState createState() => _AvatarSelectionPageState();
}

class _AvatarSelectionPageState extends State<AvatarSelectionPage> {
  bool isLoading = false;
  File selectedFile;
  String defaultUrl =
      "https://jupion-video-lecture-transcode.s3.ap-south-1.amazonaws.com/images/image_blank-profile-picture-973460_1280_1631380587107/1631380587107_blank-profile-picture-973460_1280.png";

  updateAvatar(String url) {
    userOnBoarding(body: {"avatar": url}).then((value) {
      setState(() {
        isLoading = false;
      });
      UserDatum temp = SharedPreferenceHelper.user;
      temp.avatar = url ?? '';
      SharedPreferenceHelper.storeUser(user: temp);
      checkUserLevel();
    }).catchError((err) {
      setState(() {
        isLoading = false;
      });
      SnackBarHelper.show('', err?.toString());
    });
  }

  choosePhoto() async {
    var result = await Get.bottomSheet(PhotoChooser(),
        backgroundColor: MyColors.brightBackgroundColor);
    if (result != null) {
      setState(() {
        selectedFile = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    return Scaffold(
      appBar: AppBar(
        leading: MyBackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [LogoutButton()],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 34, 16, 90),
              children: [
                AuthHeadingText("Choose profile picture"),
                const SizedBox(height: 8),
                Text(
                  "Please choose your profile picture & proceed.",
                  style: TextStyle(
                      color: MyColors.labelColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: height * 0.24),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        child: selectedFile == null
                            ? MyCircleAvatar("$defaultUrl",
                                name: SharedPreferenceHelper.user.name,
                                radius: 54)
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(selectedFile, height: 108),
                              ),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                        ),
                      ),
                      if (isLoading)
                        Positioned(
                          top: 0,
                          right: 0,
                          left: 0,
                          bottom: 0,
                          child: Center(
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: isLoading
                              ? null
                              : () {
                                  choosePhoto();
                                },
                          behavior: HitTestBehavior.translucent,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            child: SvgPicture.asset(MyAssets.photo),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 25,
            right: 16,
            left: 16,
            child: isLoading
                ? Center(
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MyButton(
                        child: Text("Save & Proceed"),
                        width: double.infinity,
                        onPressed: selectedFile == null
                            ? null
                            : () async {
                                try {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  final url = await ApiCall.singleFileUpload(
                                      selectedFile);
                                  updateAvatar(url);
                                } catch (err) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  SnackBarHelper.show('', err?.toString());
                                }
                              },
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: MyOutlineButton(
                          text: 'Skip',
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });
                            updateAvatar(defaultUrl);
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
