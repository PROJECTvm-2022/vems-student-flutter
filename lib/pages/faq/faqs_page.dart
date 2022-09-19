import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/faq_bloc/index.dart';
import 'package:vems/config/index.dart';
import 'package:vems/data_models/faq_datum.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/widgets/back_button.dart';
import 'package:vems/widgets/shimmer_layouts/faq_shimmer.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 20/4/21 at 7:22 PM
///

class FAQsPage extends StatefulWidget {
  static final routeName = '/FAQsPage';

  @override
  _FAQsPageState createState() => _FAQsPageState();
}

class _FAQsPageState extends State<FAQsPage> {
  int _activeMeterIndex;
  ScrollController _scrollController = ScrollController();

  List<FaqDatum> get _faqs => FAQBloc().faqs;

  @override
  void initState() {
    FAQBloc().add(LoadFAQs());
    _scrollController.addListener(() {
      final maxGeneralScroll = _scrollController.position.maxScrollExtent;
      final currentGeneralScroll = _scrollController.position.pixels;
      if (maxGeneralScroll <= currentGeneralScroll) {
        FAQBloc().add(LoadMoreFAQs());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: MyBackButton(),
        titleSpacing: 0,
        title: Text(
          S.of(context).faqs,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).brightness == Brightness.light
                ? MyColors.appBarTextColorLight
                : MyColors.darkTextColor,
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 2,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : MyColors.darkTFColor,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          FAQBloc().add(LoadFAQs());
        },
        child: BlocBuilder<FAQBloc, BaseState>(
            builder: (context, BaseState state) {
          if (state is ErrorBaseState) {
            return Center(
              child: Text(state.errorMessage),
            );
          }
          if (state is EmptyBaseState) {
            return Center(
              child: Text(S.of(context).noFaqsAvailable),
            );
          }
          if (state is LoadingBaseState) {
            return FAQShimmer();
          }
          if (state is FAQLoadedState) {
            return ListView(
              children: [
                ExpansionPanelList(
                  elevation: 0,
                  expansionCallback: (int i, bool status) {
                    print("$i");
                    setState(() {
                      _activeMeterIndex = _activeMeterIndex == i ? null : i;
                    });
                  },
                  children: FAQBloc().faqs.map((e) {
                    int index = _faqs.indexOf(e);
                    return ExpansionPanel(
                      canTapOnHeader: true,
                      backgroundColor: _activeMeterIndex == index
                          ? theme.brightness == Brightness.light
                              ? MyColors.activePanelBgColor
                              : MyColors.brightPrimary.withOpacity(0.2)
                          : theme.brightness == Brightness.light
                              ? Colors.white
                              : Get.theme.bottomAppBarColor,
                      isExpanded: _activeMeterIndex == index,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text(
                            "${_faqs[index].question}",
                            style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 0.4,
                              color: _activeMeterIndex == index
                                  ? MyColors.brightPrimary
                                  : theme.brightness == Brightness.light
                                      ? MyColors.lightTextColor
                                      : MyColors.darkTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          contentPadding: EdgeInsets.only(left: 16),
                        );
                      },
                      body: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
                        child: Text("${_faqs[index].answer}"),
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
            // return ListView.builder(
            //   controller: _scrollController,
            //   itemCount: FAQBloc().shouldLoadMore
            //       ? FAQBloc().faqs.length + 1
            //       : FAQBloc().faqs.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     if (index >= FAQBloc().faqs.length) {
            //       return FAQBloc().shouldLoadMore
            //           ? Center(child: CircularProgressIndicator())
            //           : SizedBox();
            //     } else {
            //       return ExpansionPanelList(
            //         elevation: _activeMeterIndex == index ? 0 : 1,
            //         expansionCallback: (int i, bool status) {
            //           print("$i");
            //           setState(() {
            //             _activeMeterIndex = _activeMeterIndex == i ? null : i;
            //           });
            //         },
            //         children: [
            //           ExpansionPanel(
            //             backgroundColor: _activeMeterIndex == index
            //                 ? theme.brightness == Brightness.light
            //                     ? MyColors.activePanelBgColor
            //                     : MyColors.brightPrimary.withOpacity(0.2)
            //                 : theme.brightness == Brightness.light
            //                     ? Colors.white
            //                     : Get.theme.bottomAppBarColor,
            //             isExpanded: _activeMeterIndex == index,
            //             headerBuilder: (BuildContext context, bool isExpanded) {
            //               return ListTile(
            //                 title: Text(
            //                   "${_faqs[index].question}",
            //                   style: TextStyle(
            //                     fontSize: 16,
            //                     letterSpacing: 0.4,
            //                     color: _activeMeterIndex == index
            //                         ? MyColors.brightPrimary
            //                         : theme.brightness == Brightness.light
            //                             ? MyColors.lightTextColor
            //                             : MyColors.darkTextColor,
            //                     fontWeight: FontWeight.w500,
            //                   ),
            //                 ),
            //                 contentPadding: EdgeInsets.only(left: 16),
            //               );
            //             },
            //             body: Padding(
            //               padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
            //               child: Text("${_faqs[index].answer}"),
            //             ),
            //           ),
            //         ],
            //       );
            //     }
            //   },
            // );
          }
          return FAQShimmer();
        }),
      ),
    );
  }
}
