import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/units_bloc/index.dart';
import 'package:vems/config/index.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/units/widgets/unit_card.dart';
import 'package:vems/widgets/back_button.dart';
import 'package:vems/widgets/shimmer_layouts/units_shimmer.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 9/1/21 at 4:39 PM
///

class UnitsPage extends StatefulWidget {
  static final routeName = '/UnitsPage';

  @override
  _UnitsPageState createState() => _UnitsPageState();
}

class _UnitsPageState extends State<UnitsPage> {
  ScrollController _scrollController = ScrollController();
  String syllabusId = '';

  @override
  void initState() {
    syllabusId = Get.arguments ?? '';
    UnitsBloc().add(LoadUnitsEvent(syllabusId));
    _scrollController.addListener(() {
      final maxGeneralScroll = _scrollController.position.maxScrollExtent;
      final currentGeneralScroll = _scrollController.position.pixels;
      if (maxGeneralScroll <= currentGeneralScroll) {
        UnitsBloc().add(LoadMoreUnits(syllabusId));
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MyBackButton(),
        title: Text(
          S.of(context).units,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).brightness == Brightness.light
                  ? MyColors.appBarTextColorLight
                  : MyColors.darkTextColor),
        ),
        titleSpacing: 0,
        elevation: 1,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : MyColors.darkTFColor,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          UnitsBloc().add(LoadUnitsEvent(syllabusId));
        },
        child: BlocBuilder<UnitsBloc, BaseState>(
            builder: (context, BaseState state) {
          if (state is ErrorBaseState) {
            return Center(
              child: Text(state.errorMessage),
            );
          }
          if (state is EmptyBaseState) {
            return Center(
              child: Text(S.of(context).noUnitsAvailable),
            );
          }
          if (state is LoadingBaseState) {
            return UnitsShimmer();
          }
          if (state is UnitsLoadedState) {
            return ListView(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Text(
                  S.of(context).selectAnUnit,
                  style: TextStyle(
                    fontSize: 16,
                    color: Get.isDarkMode
                        ? MyColors.darkTextColor
                        : MyColors.appBarTextColorLight,
                  ),
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: UnitsBloc().shouldLoadMore
                      ? UnitsBloc().units.length + 1
                      : UnitsBloc().units.length,
                  itemBuilder: (context, index) {
                    if (index >= UnitsBloc().units.length) {
                      return UnitsBloc().shouldLoadMore
                          ? Center(child: CircularProgressIndicator())
                          : SizedBox();
                    } else {
                      return UnitCard(
                        datum: UnitsBloc().units[index],
                      );
                    }
                  },
                )
              ],
            );
          }
          return UnitsShimmer();
        }),
      ),
    );
  }
}
