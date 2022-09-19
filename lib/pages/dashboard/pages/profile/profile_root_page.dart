import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/profile_bloc/index.dart';
import 'package:vems/config/index.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/about_us/about_us_page.dart';
import 'package:vems/pages/authentication/login/login_page.dart';
import 'package:vems/pages/authentication/welcome/welcome_page.dart';
import 'package:vems/pages/class_schedule/class_schedule_page.dart';
import 'package:vems/pages/contact_us/contact_us_page.dart';
import 'package:vems/pages/dashboard/pages/profile/widgets/profile_top_section.dart';
import 'package:vems/pages/faq/faqs_page.dart';
import 'package:vems/pages/privacy_policy/privacy_policy_page.dart';
import 'package:vems/pages/terms_conditions/terms_conditions_page.dart';
import 'package:vems/utils/dialogue_helper.dart';
import 'package:vems/utils/shared_preference_helper.dart';
import 'package:vems/utils/snackbar_helper.dart';
import 'package:url_launcher/url_launcher.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 20/4/21 at 6:07 PM
///

class ProfileRootPage extends StatefulWidget {
  static final routeName = '/profile-root';

  @override
  _ProfileRootPageState createState() => _ProfileRootPageState();
}

class _ProfileRootPageState extends State<ProfileRootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          BlocBuilder<ProfileBloc, BaseState>(
              builder: (context, BaseState state) {
            if (state is ErrorBaseState) {
              return SizedBox(
                height: 300,
                child: Center(
                  child: Text(state.errorMessage),
                ),
              );
            }
            if (state is LoadingBaseState) {
              return SizedBox(
                height: 300,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is ProfileLoadedState) {
              return ProfileTopSection(
                datum: ProfileBloc().user,
                isRootPage: true,
              );
            }
            return SizedBox();
          }),
          const SizedBox(height: 10),
          ProfileTile(
            name: S.of(context).timetable,
            asset: MyAssets.timetable,
            onTap: () {
              Get.toNamed(ClassSchedulePage.routeName);
            },
          ),
          ProfileTile(
            name: "Offline files",
            asset: MyAssets.timetable,
            onTap: () {},
          ),
          ProfileTile(
            name: S.of(context).aboutUs,
            asset: MyAssets.aboutUs,
            onTap: () {
              Get.toNamed(AboutUsPage.routeName);
            },
          ),
          ProfileTile(
            name: S.of(context).contactUs,
            asset: MyAssets.contactUs,
            onTap: () {
              Get.toNamed(ContactUsPage.routeName);
            },
          ),
          ProfileTile(
            name: S.of(context).termsConditions,
            asset: MyAssets.timetable,
            onTap: () {
              Get.toNamed(TermsConditionsPage.routeName);
            },
          ),
          ProfileTile(
            name: S.of(context).privacyPolicy,
            asset: MyAssets.privacyPolicy,
            onTap: () {
              Get.toNamed(PrivacyPolicyPage.routeName);
            },
          ),
          ProfileTile(
            name: S.of(context).faqs,
            asset: MyAssets.timetable,
            onTap: () {
              Get.toNamed(FAQsPage.routeName);
            },
          ),
          ProfileTile(
            name: S.of(context).rateUs,
            asset: MyAssets.rateUs,
            onTap: () async {
              String url =
                  'https://play.google.com/store/apps/details?id=com.vernacularmedium.ems';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                SnackBarHelper.show("Oops", "Error launching playstore.");
              }
            },
          ),
          ProfileTile(
            name: S.of(context).logout,
            asset: MyAssets.logOut,
            style: TextStyle(
              color: MyColors.red,
              fontSize: 15,
            ),
            onTap: () {
              showJupionDialogue(
                  title: 'Log Out',
                  description: 'Are you sure you want to log out ?',
                  positiveCallback: () {
                    SharedPreferenceHelper.logOut();
                    Get.offAllNamed(LoginPage.routeName);
                  },
                  positiveText: 'Yes',
                  negativeText: 'No');
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  final String name;
  final String asset;
  final VoidCallback onTap;
  final TextStyle style;

  const ProfileTile({Key key, this.name, this.asset, this.onTap, this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: SvgPicture.asset(
          asset ?? '',
          color: Theme.of(context).brightness == Brightness.light
              ? MyColors.lightTextColor
              : MyColors.darkTextColor,
        ),
      ),
      minLeadingWidth: 0,
      onTap: onTap,
      title: Text(
        name ?? '',
        style: style ??
            TextStyle(
              fontSize: 15,
            ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 18),
    );
  }
}
