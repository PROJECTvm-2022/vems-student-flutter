import 'package:flutter/material.dart';
import 'package:vems/bloc_models/profile_bloc/index.dart';
import 'package:vems/bloc_models/subjects_bloc/index.dart';
import 'package:vems/pages/dashboard/pages/home/home_page.dart';
import 'package:vems/pages/dashboard/pages/lectures/lectures_page.dart';
import 'package:vems/pages/dashboard/widgets/bottom_nav_bar.dart';

ValueNotifier<int> dashboardIndexNotifier = ValueNotifier(0);
ValueNotifier<int> navBarIndexNotifier = ValueNotifier(0);

class DashboardPage extends StatefulWidget {
  static final routeName = '/DashboardPage';

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Widget> children = [];
  bool extended = false;

  int get dashValue => dashboardIndexNotifier.value;

  int get navValue => navBarIndexNotifier.value;

  @override
  void initState() {
    super.initState();
    children = [
      HomePage(),
      LecturesPage(),
    ];
    ProfileBloc().add(LoadUserEvent());
    SubjectsBloc().add(LoadSubjectsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (extended)
          setState(() {
            extended = false;
          });
        if (dashValue == 0 && navValue == 0)
          return true;
        else if (dashValue != navValue) {
          navBarIndexNotifier.value = dashValue;
        } else {
          navBarIndexNotifier.value = 0;
          dashboardIndexNotifier.value = 0;
        }
        return false;
      },
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: BottomNavBar(
          extended: extended,
          onExtendedChange: (val) {
            setState(() {
              extended = val;
            });
          },
          onPageChange: (index) {
            // navBarIndexNotifier.value = index;

            if (index == 3) {
              setState(() {
                extended = !extended;
              });
            } else {
              dashboardIndexNotifier.value = index;
              navBarIndexNotifier.value = index;
              setState(() {
                extended = false;
              });
            }
          },
        ),
        body: SafeArea(
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: ValueListenableBuilder(
              valueListenable: dashboardIndexNotifier,
              builder: (ctx, value, _) {
                return children[value];
              },
            ),
          ),
        ),
      ),
    );
  }
}
