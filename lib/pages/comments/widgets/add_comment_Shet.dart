import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vems/bloc_models/comments_bloc/comments_bloc.dart';
import 'package:vems/bloc_models/comments_bloc/comments_event.dart';
import 'package:vems/bloc_models/reply_bloc/index.dart';
import 'package:vems/config/index.dart';
import 'package:vems/data_models/comment_data.dart';
import 'package:vems/data_models/video_data.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/utils/my_form_validators.dart';
import 'package:vems/utils/shared_preference_helper.dart';
import 'package:vems/widgets/my_avatar.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 12/1/21 at 7:03 PM
///

class AddCommentSheet extends StatefulWidget {
  final bool isReply;
  final StudentVideoDatum videoDatum;
  final CommentDatum commentDatum;
  final ReplyBloc replyBloc;
  final int type;

  const AddCommentSheet({
    Key key,
    this.isReply = false,
    this.replyBloc,
    this.videoDatum,
    this.commentDatum,
    this.type,
  }) : super(key: key);

  @override
  _AddCommentSheetState createState() => _AddCommentSheetState();
}

class _AddCommentSheetState extends State<AddCommentSheet> {
  final _formKey = GlobalKey<FormState>();
  bool autoValidate = false;
  String comment = '';

  bool get isReply => widget.isReply;

  StudentVideoDatum get video => widget.videoDatum;

  CommentDatum get commentDatum => widget.commentDatum;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 6, 12),
      child: Form(
        key: _formKey,
        autovalidateMode:
            autoValidate ? AutovalidateMode.always : AutovalidateMode.always,
        child: Row(
          children: [
            MyCircleAvatar(
              SharedPreferenceHelper.user.avatar,
              radius: 22,
              name: SharedPreferenceHelper.user.name,
            ),
            const SizedBox(
              width: 8,
            ),
            Flexible(
              child: TextFormField(
                autofocus: true,
                validator: (value) {
                  comment = value.trim();
                  return MyFormValidators.validateEmpty(value.trim());
                },
                decoration: InputDecoration(
                  hintText: widget.isReply
                      ? S.of(context).addAReply
                      : S.of(context).askADoubt,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                  hintStyle: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? MyColors.darkTextColor.withOpacity(0.6)
                        : MyColors.appBarTextColorLight,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: SvgPicture.asset(MyAssets.send),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Get.back();
                  CommentDatum tempDatum = CommentDatum(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    comment: comment,
                    entityType: isReply ? 'comment' : 'instituteBatchVideo',
                    entityId: isReply
                        ? commentDatum.id
                        : video.instituteBatchVideo.id,
                    parentEntityType: isReply ? 'instituteBatchVideo' : 'video',
                    parentEntityId:
                        isReply ? commentDatum.entityId : video.videoId.id,
                    type: widget.type ?? 1,
                    createdBy: SharedPreferenceHelper.user,
                    createdAt: DateTime.now(),
                    commentCount: 0,
                  );
                  if (widget.isReply) {
                    widget.replyBloc.add(AddReplyEvent(tempDatum));
                  } else {
                    CommentsBloc().add(AddCommentEvent(tempDatum));
                  }
                } else {
                  setState(() {
                    autoValidate = true;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
