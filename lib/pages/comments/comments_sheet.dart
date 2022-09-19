import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/comments_bloc/comments_bloc.dart';
import 'package:vems/bloc_models/comments_bloc/comments_event.dart';
import 'package:vems/bloc_models/comments_bloc/comments_state.dart';
import 'package:vems/bloc_models/videos_bloc/index.dart';
import 'package:vems/config/functions.dart';
import 'package:vems/config/index.dart';
import 'package:vems/data_models/comment_data.dart';
import 'package:vems/data_models/video_data.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/comments/widgets/comment_field.dart';
import 'package:vems/pages/comments/widgets/comment_tile.dart';
import 'package:vems/utils/shared_preference_helper.dart';
import 'package:vems/widgets/quill_editor_sheet.dart';
import 'package:vems/widgets/sheet_top_bar.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 11/1/21 at 2:09 PM
///

class CommentsSheet extends StatefulWidget {
  final StudentVideoDatum videoDatum;
  final int currentIndex;
  final bool questionView;

  const CommentsSheet(
      {Key key,
      this.videoDatum,
      this.currentIndex = 0,
      this.questionView = false})
      : super(key: key);

  @override
  _CommentsSheetState createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<CommentsSheet> {
  ScrollController _scrollController = ScrollController();
  int commentType = 1;

  String get videoId => widget.videoDatum.instituteBatchVideo.id;

  @override
  void initState() {
    if (videoId != null) {
      CommentsBloc().add(LoadCommentsEvent(videoId));
    }
    _scrollController.addListener(() {
      final maxGeneralScroll = _scrollController.position.maxScrollExtent;
      final currentGeneralScroll = _scrollController.position.pixels;
      if (maxGeneralScroll <= currentGeneralScroll) {
        CommentsBloc().add(LoadMoreComments(videoId));
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
    double height = Get.height;

    return SizedBox(
      height: widget.questionView
          ? (0.65 * height) / 1.65 - 20
          : (2 * height) / 3 - 25,
      child: Column(
        children: [
          BlocBuilder<VideosBloc, BaseState>(
              builder: (context, BaseState state) => SheetTopBar(
                    primaryText: S.of(context).doubts,
                    secondaryText: state is VideosLoadedState
                        ? '${compactCount(VideosBloc().videos[widget.currentIndex].instituteBatchVideo.publicCommentCount)}'
                        : "0",
                  )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CommentField(
              type: commentType,
              onTypeChanged: (val) {
                setState(() {
                  commentType = val;
                });
              },
              onTap: () {
                Get.bottomSheet(QuillEditorSheet((str) {
                  Get.back();
                  CommentDatum tempDatum = CommentDatum(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    comment: str,
                    entityType: 'instituteBatchVideo',
                    entityId: widget.videoDatum.instituteBatchVideo.id,
                    parentEntityType: 'video',
                    parentEntityId: widget.videoDatum.videoId.id,
                    type: commentType,
                    createdBy: SharedPreferenceHelper.user,
                    createdAt: DateTime.now(),
                    commentCount: 0,
                  );
                  CommentsBloc().add(AddCommentEvent(tempDatum));
                }),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(12))),
                    backgroundColor: Colors.grey[300],
                    ignoreSafeArea: false,
                    isScrollControlled: true);

                // Get.bottomSheet(
                //   AddCommentSheet(
                //     isReply: false,
                //     videoDatum: widget.videoDatum,
                //     type: commentType,
                //   ),
                //   backgroundColor: Theme.of(context).canvasColor,
                //   isScrollControlled: true,
                // );
              },
            ),
          ),
          Divider(
            height: 22,
            thickness: 1,
            endIndent: 16,
            indent: 16,
            color: Theme.of(context).brightness == Brightness.dark
                ? MyColors.grey
                : MyColors.lightDividerColor,
          ),
          Flexible(
            child: BlocBuilder<CommentsBloc, BaseState>(
                builder: (context, BaseState state) {
              if (state is ErrorBaseState) {
                return Center(
                  child: Text(state.errorMessage),
                );
              }
              if (state is EmptyBaseState) {
                return Center(
                  child: Text(S.of(context).noDoubtsAvailable),
                );
              }
              if (state is LoadingBaseState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CommentsLoadedState) {
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: CommentsBloc().shouldLoadMore
                      ? CommentsBloc().comments.length + 1
                      : CommentsBloc().comments.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index >= CommentsBloc().comments.length) {
                      return CommentsBloc().shouldLoadMore
                          ? Center(child: CircularProgressIndicator())
                          : SizedBox();
                    } else {
                      return CommentTile(
                        datum: CommentsBloc().comments[index],
                      );
                    }
                  },
                );
              }
              return SizedBox();
            }),
          ),
        ],
      ),
    );
  }
}
