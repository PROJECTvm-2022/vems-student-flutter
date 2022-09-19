import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vems/config/assets.dart';
import 'package:vems/config/colors.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/authentication/login/login_page.dart';
import 'package:vems/pages/authentication/signup/signup_page.dart';
import 'package:vems/widgets/button.dart';
import 'package:vems/widgets/outlined_button.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 4/1/21 at 9:04 PM
///

class WelcomePage extends StatefulWidget {
  static final routeName = '/WelcomePage';

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  double width = Get.width;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              MyAssets.welcomeVector,
              width: width,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 28, 16, 20),
              child: Text(S.of(context).welcomeToJupionClasses,
                  style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).brightness == Brightness.light
                          ? MyColors.darkBlue
                          : MyColors.darkTextColor)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                S.of(context).createAnAccountOrSignInToYourAccountTo,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: MyColors.labelColor),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                      child: MyButton(
                          child: Text(S.of(context).signIn),
                          height: 49,
                          onPressed: () {
                            Get.toNamed(LoginPage.routeName);
                          })),
                  const SizedBox(width: 14),
                  Expanded(
                    child: MyOutlineButton(
                      text: S.of(context).registerNow,
                      onPressed: () {
                        Get.toNamed(SignUpPage.routeName);
                      },
                      height: 49,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24)
          ],
        ),
      ),
    );
  }
}
