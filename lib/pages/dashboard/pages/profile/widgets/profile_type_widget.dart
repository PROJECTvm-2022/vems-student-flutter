import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vems/config/assets.dart';
import 'package:vems/config/colors.dart';
import 'package:vems/generated/l10n.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 3/3/21 at 11:19 PM
///

class ProfileTypeWidget extends StatelessWidget {
  final Function(bool r) onChanged;
  final bool isBasicDetails;

  const ProfileTypeWidget(
      {Key key, this.onChanged, this.isBasicDetails = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: FlatButton.icon(
              onPressed: () {
                onChanged(true);
              },
              icon: SvgPicture.asset(
                MyAssets.personFilled,
                color: isBasicDetails
                    ? MyColors.brightPrimary
                    : MyColors.disabledHeading,
              ),
              label: Text(
                S.of(context).basicDetails,
                style: TextStyle(
                  color: isBasicDetails
                      ? MyColors.brightPrimary
                      : MyColors.disabledHeading,
                ),
              ),
            ),
          ),
          Container(
            width: 2,
            height: 30,
            color: MyColors.borderGrey,
          ),
          Expanded(
            child: FlatButton.icon(
              onPressed: () {
                onChanged(false);
              },
              icon: SvgPicture.asset(
                MyAssets.subjects,
                color: isBasicDetails
                    ? MyColors.disabledHeading
                    : MyColors.brightPrimary,
              ),
              label: Text(
                S.of(context).mySubjects,
                style: TextStyle(
                  color: isBasicDetails
                      ? MyColors.disabledHeading
                      : MyColors.brightPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: MyColors.borderGrey),
        ),
      ),
    );
  }
}
