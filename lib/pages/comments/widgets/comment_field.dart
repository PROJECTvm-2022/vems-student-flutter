import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vems/config/index.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/utils/shared_preference_helper.dart';
import 'package:vems/widgets/my_avatar.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 12/1/21 at 4:59 PM
///

class CommentField extends StatelessWidget {
  final VoidCallback onTap;
  final int type;
  final Function(int r) onTypeChanged;

  const CommentField({Key key, this.onTap, this.onTypeChanged, this.type = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onTap,
                    behavior: HitTestBehavior.translucent,
                    child: Text(
                      S.of(context).askADoubt,
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? MyColors.darkTextColor.withOpacity(0.6)
                            : MyColors.appBarTextColorLight,
                      ),
                    ),
                  ),
                ),
                onTypeChanged == null
                    ? GestureDetector(
                        onTap: onTap,
                        behavior: HitTestBehavior.translucent,
                        child: Row(
                          children: [
                            SvgPicture.asset(MyAssets.public),
                            const SizedBox(
                              width: 6,
                            ),
                            SvgPicture.asset(MyAssets.dropDown),
                          ],
                        ),
                      )
                    : PopupMenuButton<int>(
                        onSelected: onTypeChanged ?? (val) {},
                        child: Row(
                          children: [
                            SvgPicture.asset(
                                type == 1 ? MyAssets.public : MyAssets.private),
                            const SizedBox(
                              width: 6,
                            ),
                            SvgPicture.asset(MyAssets.dropDown),
                          ],
                        ),
                        itemBuilder: (c) => [
                          const PopupMenuItem<int>(
                            value: 1,
                            child: Text('Public',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600)),
                          ),
                          const PopupMenuItem<int>(
                            value: 2,
                            child: Text(
                              'Private',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Theme.of(context).brightness == Brightness.dark
                  ? MyColors.darkTFColor
                  : MyColors.lightTFColor,
            ),
          ),
        )
      ],
    );
  }
}
