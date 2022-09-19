import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vems/config/assets.dart';
import 'package:vems/config/colors.dart';
import 'package:vems/pages/dashboard/dashboard_page.dart';
import 'package:vems/pages/dashboard/pages/exams/exams_page.dart';
import 'package:vems/pages/dashboard/pages/profile/profile_root_page.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 8/1/21 at 1:28 AM
///

class BottomNavBar extends StatelessWidget {
  final bool extended;
  final Function(int) onPageChange;
  final Function(bool) onExtendedChange;

  const BottomNavBar(
      {this.onPageChange, this.extended = false, this.onExtendedChange});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: navBarIndexNotifier,
        builder: (ctx, value, _) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (extended)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        NavItem(
                          label: "Exams",
                          onTap: () {
                            onExtendedChange(false);
                            Get.toNamed(ExamsPage.routeName);
                          },
                          asset: MyAssets.exams,
                        ),
                        NavItem(
                            label: "Profile",
                            onTap: () {
                              onExtendedChange(false);
                              Get.toNamed(ProfileRootPage.routeName);
                            },
                            asset: MyAssets.profileEnabled),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Get.theme.bottomAppBarColor
                          : Color(0xffEFF7FF),
                      border: Theme.of(context).brightness == Brightness.light
                          ? null
                          : Border(
                              top: BorderSide(
                                color: Colors.white.withOpacity(0.2),
                                width: 1.5,
                              ),
                            ),
                    ),
                  ),
                Container(
                  height: 66,
                  decoration: BoxDecoration(
                    border: Theme.of(context).brightness == Brightness.light
                        ? null
                        : Border(
                            top: BorderSide(
                              color: Colors.white.withOpacity(0.2),
                              width: 1.5,
                            ),
                          ),
                    boxShadow:
                        Theme.of(context).brightness == Brightness.light &&
                                !extended
                            ? [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 9,
                                  spreadRadius: 0,
                                  offset: Offset(0, -4),
                                )
                              ]
                            : null,
                  ),
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    currentIndex: navBarIndexNotifier.value,
                    selectedItemColor: MyColors.primaryBlue,
                    onTap: onPageChange,
                    elevation: 0,
                    selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
                    unselectedLabelStyle:
                        TextStyle(fontWeight: FontWeight.w600),
                    selectedFontSize: 12,
                    unselectedFontSize: 12,
                    items: [
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 3),
                          child: SvgPicture.asset(navBarIndexNotifier.value == 0
                              ? MyAssets.dashboardEnabled
                              : MyAssets.dashboardDisabled),
                        ),
                        label: 'Dashboard',
                      ),
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 1.5),
                          child: SvgPicture.asset(navBarIndexNotifier.value == 1
                              ? MyAssets.lectureEnabled
                              : MyAssets.lectureDisabled),
                        ),
                        label: 'Lectures',
                      ),
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 3),
                          child: SvgPicture.asset(navBarIndexNotifier.value == 2
                              ? MyAssets.liveEnabled
                              : MyAssets.liveDisabled),
                        ),
                        label: 'Live Classes',
                      ),
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          child: SvgPicture.asset(
                            MyAssets.more,
                            color: navBarIndexNotifier.value == 3
                                ? MyColors.primaryBlue
                                : Color(0xff9A9A9A),
                          ),
                        ),
                        label: 'More',
                      ),
                    ],
                  ),
                ),
              ],
            ));
  }
}

class NavItem extends StatelessWidget {
  final VoidCallback onTap;
  final String asset;
  final String label;

  const NavItem({
    @required this.label,
    @required this.onTap,
    @required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            asset,
            color: Theme.of(context).brightness == Brightness.light
                ? MyColors.primaryBlue
                : Color(0xffb4b4b4),
          ),
          const SizedBox(height: 3),
          Text(
            "$label",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).brightness == Brightness.light
                  ? MyColors.primaryBlue
                  : Color(0xffc2c2c2),
            ),
          ),
        ],
      ),
    );
  }
}
