import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:vems/config/functions.dart';
import 'package:vems/config/index.dart';
import 'package:vems/data_models/comment_data.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/utils/shared_preference_helper.dart';
import 'package:vems/widgets/my_avatar.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 11/1/21 at 7:54 PM
///

class ReplyTile extends StatelessWidget {
  final CommentDatum datum;

  const ReplyTile({Key key, this.datum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyCircleAvatar(
            datum.createdBy.avatar,
            name: datum.createdBy.name,
            radius: 11,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        datum.createdBy.name,
                        style: MyDecorations.commentTitle(context),
                      ),
                    ),
                    Container(
                      height: 3,
                      width: 3,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 7),
                      decoration: BoxDecoration(
                          color: Colors.grey, shape: BoxShape.circle),
                    ),
                    Text(
                      "${timeInAgoFull(datum.createdAt)}",
                      style: MyDecorations.commentTitle(context),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Html(data: datum.comment),
                  // child: Text(
                  //   datum.comment,
                  //   style: TextStyle(
                  //     fontSize: 13,
                  //     color: Theme.of(context).brightness == Brightness.light
                  //         ? MyColors.lightTextColor
                  //         : MyColors.darkTextColor,
                  //   ),
                  // ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AddReplyWidget extends StatelessWidget {
  final VoidCallback onTap;

  const AddReplyWidget({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          MyCircleAvatar(
            SharedPreferenceHelper.user.avatar,
            radius: 11,
            name: SharedPreferenceHelper.user.name,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                S.of(context).addAReply,
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.3), width: 1)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
