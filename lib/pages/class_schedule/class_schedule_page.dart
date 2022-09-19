import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/schedule_bloc/index.dart';
import 'package:vems/config/index.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/class_schedule/widgets/schedule_grid.dart';
import 'package:vems/widgets/back_button.dart';
import 'package:vems/widgets/shimmer_layouts/time_table_shimmer.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 25/1/21 at 9:19 PM
///

class ClassSchedulePage extends StatefulWidget {
  static final routeName = '/ClassSchedulePage';

  @override
  _ClassSchedulePageState createState() => _ClassSchedulePageState();
}

class _ClassSchedulePageState extends State<ClassSchedulePage> {
  @override
  void initState() {
    ScheduleBloc().add(LoadSchedulesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MyBackButton(),
        titleSpacing: 0,
        title: Text(
          S.of(context).classSchedule,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).brightness == Brightness.light
                ? MyColors.appBarTextColorLight
                : MyColors.darkTextColor,
          ),
        ),
        // titleSpacing: 0,
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : MyColors.darkTFColor,
      ),
      body: BlocBuilder<ScheduleBloc, BaseState>(
          builder: (context, BaseState state) {
        if (state is ErrorBaseState) {
          return Center(
            child: Text(state.errorMessage),
          );
        }
        if (state is EmptyBaseState) {
          return Center(
            child: Text(S.of(context).noSchedulesAvailable),
          );
        }
        if (state is LoadingBaseState) {
          return TimeTableShimmer();
        }
        if (state is ScheduleLoadedState) {
          return ScheduleGrid(
            cells: ScheduleBloc().cells,
          );
        }
        return TimeTableShimmer();
      }),
    );
  }
}
