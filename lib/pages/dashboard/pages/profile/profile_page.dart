import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/profile_bloc/index.dart';
import 'package:vems/bloc_models/profile_stats_bloc/index.dart';
import 'package:vems/bloc_models/subjects_bloc/index.dart';
import 'package:vems/data_models/user.dart';
import 'package:vems/pages/dashboard/pages/profile/widgets/basic_details_fragment.dart';
import 'package:vems/pages/dashboard/pages/profile/widgets/my_subjects_fragment.dart';
import 'package:vems/pages/dashboard/pages/profile/widgets/profile_top_section.dart';
import 'package:vems/pages/dashboard/pages/profile/widgets/profile_type_widget.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 8/1/21 at 1:42 AM
///

class ProfilePage extends StatefulWidget {
  static final routeName = '/ProfilePage';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isBasicDetails = true;

  UserDatum get me => ProfileBloc().user;

  @override
  void initState() {
    ProfileStatsBloc().add(LoadStatsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ProfileStatsBloc().add(LoadStatsEvent());
          ProfileBloc().add(LoadUserEvent());
          SubjectsBloc().add(LoadSubjectsEvent());
        },
        child: BlocBuilder<ProfileBloc, BaseState>(
            builder: (context, BaseState state) {
          if (state is ErrorBaseState) {
            return Center(
              child: Text(state.errorMessage),
            );
          }
          if (state is LoadingBaseState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProfileLoadedState) {
            return ListView(
              children: [
                ProfileTopSection(
                  datum: me,
                  isProfilePage: true,
                ),
                ProfileTypeWidget(
                  isBasicDetails: _isBasicDetails,
                  onChanged: (val) {
                    setState(() {
                      _isBasicDetails = val;
                    });
                  },
                ),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: _isBasicDetails
                      ? BasicDetailsFragment(
                          datum: ProfileBloc().user,
                        )
                      : MySubjectsFragment(),
                )
              ],
            );
          }
          return SizedBox();
        }),
      ),
    );
  }
}
