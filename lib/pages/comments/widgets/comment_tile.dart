import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vems/config/functions.dart';
import 'package:vems/config/index.dart';
import 'package:vems/data_models/comment_data.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/comments/widgets/replies_list.dart';
import 'package:vems/widgets/my_avatar.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 11/1/21 at 2:18 PM
///

class CommentTile extends StatefulWidget {
  final CommentDatum datum;

  const CommentTile({Key key, this.datum}) : super(key: key);

  @override
  _CommentTileState createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  bool _isExpandable = false;

  @override
  void didUpdateWidget(covariant CommentTile oldWidget) {
    setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.datum.comment);
    return InkWell(
      onTap: () {
        setState(() {
          _isExpandable = !_isExpandable;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyCircleAvatar(
              widget.datum.createdBy.avatar,
              radius: 22,
              name: widget.datum.createdBy.name,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                widget.datum.createdBy.name,
                                style: MyDecorations.commentTitle(context),
                              ),
                            ),
                            Container(
                              height: 3,
                              width: 3,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  color: Colors.grey, shape: BoxShape.circle),
                            ),
                            Text(
                              "${timeInAgoFull(widget.datum.createdAt)}",
                              style: MyDecorations.commentTitle(context),
                            ),
                          ],
                        ),
                      ),
                      if (widget.datum.type == 2)
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: SvgPicture.asset(MyAssets.private),
                        )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Html(
                      data: widget.datum.comment,
                    ),
                    // child: Text(
                    //   widget.datum.comment,
                    //   style: TextStyle(
                    //     fontSize: 13,
                    //     color: Theme.of(context).brightness == Brightness.light
                    //         ? MyColors.lightTextColor
                    //         : MyColors.darkTextColor,
                    //   ),
                    // ),
                  ),
                  const SizedBox(height: 4),
                  _isExpandable
                      ? RepliesList(
                          commentDatum: widget.datum,
                        )
                      : Row(
                          children: [
                            SvgPicture.asset(
                              MyAssets.dropDown,
                              color: MyColors.primaryBlue,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              S.of(context).replies,
                              style: TextStyle(
                                color: MyColors.primaryBlue,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
