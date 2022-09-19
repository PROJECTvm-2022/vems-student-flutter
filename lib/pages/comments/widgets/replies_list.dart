import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/reply_bloc/index.dart';
import 'package:vems/data_models/comment_data.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/comments/widgets/reply_tile.dart';
import 'package:vems/utils/shared_preference_helper.dart';
import 'package:vems/widgets/quill_editor_sheet.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 12/1/21 at 9:34 PM
///

class RepliesList extends StatefulWidget {
  final CommentDatum commentDatum;

  const RepliesList({Key key, this.commentDatum}) : super(key: key);

  @override
  _RepliesListState createState() => _RepliesListState();
}

class _RepliesListState extends State<RepliesList> {
  ReplyBloc _replyBloc = ReplyBloc();

  CommentDatum get comment => widget.commentDatum;

  @override
  void initState() {
    ReplyBloc.replyBlocs.add(_replyBloc);
    _replyBloc.add(LoadRepliesEvent(comment.id));
    super.initState();
  }

  @override
  void dispose() {
    ReplyBloc.replyBlocs.remove(_replyBloc);
    _replyBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddReplyWidget(
          onTap: () {
            Get.bottomSheet(QuillEditorSheet((str) {
              Get.back();
              CommentDatum tempDatum = CommentDatum(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                comment: str,
                entityType: 'comment',
                entityId: comment.id,
                parentEntityType: 'instituteBatchVideo',
                parentEntityId: comment.entityId,
                type: 1,
                createdBy: SharedPreferenceHelper.user,
                createdAt: DateTime.now(),
                commentCount: 0,
              );
              _replyBloc.add(AddReplyEvent(tempDatum));
            }),
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12))),
                backgroundColor: Colors.grey[300],
                ignoreSafeArea: false,
                isScrollControlled: true);

            // Get.bottomSheet(
            //   AddCommentSheet(
            //     isReply: true,
            //     replyBloc: _replyBloc,
            //     commentDatum: comment,
            //   ),
            //   backgroundColor: Theme.of(context).canvasColor,
            //   isScrollControlled: true,
            // );
          },
        ),
        BlocBuilder<ReplyBloc, BaseState>(
            bloc: _replyBloc,
            builder: (context, BaseState state) {
              if (state is LoadingBaseState) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator()),
                );
              }
              if (state is ReplyLoadedState) {
                return Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _replyBloc.replies.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ReplyTile(
                          datum: _replyBloc.replies[index],
                        );
                      },
                    ),
                    if (_replyBloc.shouldLoadMore)
                      GestureDetector(
                        onTap: () {
                          _replyBloc.add(LoadMoreRepliesEvent(comment.id));
                        },
                        child: Text(
                          S.of(context).loadMoreReplies,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                  ],
                );
              }
              return SizedBox();
            }),
      ],
    );
  }
}
