import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/profile_stats_bloc/index.dart';
import 'package:vems/config/assets.dart';
import 'package:vems/config/colors.dart';
import 'package:vems/config/decorations.dart';
import 'package:vems/data_models/user.dart';
import 'package:vems/pages/authentication/login/login_page.dart';
import 'package:vems/pages/authentication/welcome/welcome_page.dart';
import 'package:vems/pages/dashboard/pages/profile/profile_page.dart';
import 'package:vems/pages/dashboard/pages/profile/widgets/dp_update_widget.dart';
import 'package:vems/pages/dashboard/pages/profile/widgets/profile_edit_sheet.dart';
import 'package:vems/pages/dashboard/pages/profile/widgets/profile_stats_widget.dart';
import 'package:vems/utils/dialogue_helper.dart';
import 'package:vems/utils/shared_preference_helper.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 3/3/21 at 10:24 PM
///

class ProfileTopSection extends StatelessWidget {
  final UserDatum datum;
  final bool isProfilePage;
  final bool isRootPage;

  const ProfileTopSection(
      {Key key,
      this.datum,
      this.isProfilePage = false,
      this.isRootPage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 16, 15, 22),
      child: Column(
        children: [
          if (isProfilePage || isRootPage)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
                if (!isRootPage)
                  PopupMenuButton<int>(
                    onSelected: (val) {
                      if (val == 1) {
                        Get.bottomSheet(ProfileEditSheet(),
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor);
                      } else {
                        showJupionDialogue(
                            title: 'Log Out',
                            description: 'Are you sure you want to log out ?',
                            positiveCallback: () {
                              SharedPreferenceHelper.logOut();
                              Get.offAllNamed(LoginPage.routeName);
                            },
                            positiveText: 'Yes',
                            negativeText: 'No');
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SvgPicture.asset(MyAssets.dotMenu),
                    ),
                    itemBuilder: (c) => [
                      const PopupMenuItem<int>(
                        value: 1,
                        child: Text('Edit',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600)),
                      ),
                      const PopupMenuItem<int>(
                        value: 2,
                        child: Text(
                          'Log Out',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.red),
                        ),
                      ),
                    ],
                  )
              ],
            ),
          DPUpdateWidget(isProfilePage: isProfilePage),
          const SizedBox(height: 12),
          Text(
            "${datum.name}",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "${datum.institute.name}, ${datum.institute.city} ",
            style: TextStyle(
                color: MyColors.lightSky, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 23),
          isProfilePage
              ? BlocBuilder<ProfileStatsBloc, BaseState>(
                  builder: (context, BaseState state) {
                  if (state is ProfileStatsLoadedState) {
                    return ProfileStatsWidget(datum: ProfileStatsBloc().stats);
                  }
                  return SizedBox();
                })
              : Material(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(ProfilePage.routeName);
                    },
                    borderRadius: BorderRadius.circular(6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Text(
                        "View profile",
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                    ),
                  ),
                ),
        ],
      ),
      decoration: BoxDecoration(
        gradient: MyDecorations.profileGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
    );
  }
}
