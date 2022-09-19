import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/chapters_bloc/index.dart';
import 'package:vems/config/colors.dart';
import 'package:vems/config/index.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/chapters/widgets/chapter_tile.dart';
import 'package:vems/widgets/back_button.dart';
import 'package:vems/widgets/shimmer_layouts/units_shimmer.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 9/1/21 at 4:39 PM
///

class ChaptersPage extends StatefulWidget {
  static final routeName = '/ChaptersPage';

  @override
  _ChaptersPageState createState() => _ChaptersPageState();
}

class _ChaptersPageState extends State<ChaptersPage> {
  ScrollController _scrollController = ScrollController();
  String unitId = '';

  @override
  void initState() {
    unitId = Get.arguments ?? '';
    ChaptersBloc().add(LoadChaptersEvent(unitId));
    _scrollController.addListener(() {
      final maxGeneralScroll = _scrollController.position.maxScrollExtent;
      final currentGeneralScroll = _scrollController.position.pixels;
      if (maxGeneralScroll <= currentGeneralScroll) {
        ChaptersBloc().add(LoadMoreChapters(unitId));
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
          S.of(context).chapters,
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
          ChaptersBloc().add(LoadChaptersEvent(unitId));
        },
        child: BlocBuilder<ChaptersBloc, BaseState>(
            builder: (context, BaseState state) {
          if (state is ErrorBaseState) {
            return Center(
              child: Text(state.errorMessage),
            );
          }
          if (state is EmptyBaseState) {
            return Center(
              child: Text(S.of(context).noChaptersAvailable),
            );
          }
          if (state is LoadingBaseState) {
            return UnitsShimmer();
          }
          if (state is ChaptersLoadedState) {
            return ListView(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Text(
                  S.of(context).selectAChapter,
                  style: TextStyle(
                    fontSize: 16,
                    color: Get.isDarkMode
                        ? MyColors.darkTextColor
                        : MyColors.appBarTextColorLight,
                  ),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ChaptersBloc().shouldLoadMore
                      ? ChaptersBloc().chapters.length + 1
                      : ChaptersBloc().chapters.length,
                  itemBuilder: (context, index) {
                    if (index >= ChaptersBloc().chapters.length) {
                      return ChaptersBloc().shouldLoadMore
                          ? Center(child: CircularProgressIndicator())
                          : SizedBox();
                    } else {
                      return ChapterTile(
                        datum: ChaptersBloc().chapters[index],
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
