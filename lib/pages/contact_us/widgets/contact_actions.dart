import 'package:flutter/material.dart';
import 'package:vems/config/assets.dart';
import 'package:vems/config/index.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/utils/snackbar_helper.dart';
import 'package:vems/widgets/outlined_button.dart';
import 'package:url_launcher/url_launcher.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 22/4/21 at 10:26 PM
///

class ContactActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MyOutlineIconButton(
            icon: MyAssets.mail,
            text: S.of(context).email,
            onPressed: () async {
              if (await canLaunch(KeyUtils.mailUs)) {
                await launch(KeyUtils.mailUs);
              } else {
                SnackBarHelper.show('', S.of(context).couldNotLaunchMailSystem);
              }
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: MyOutlineIconButton(
            icon: MyAssets.phone,
            text: S.of(context).call,
            onPressed: () async {
              if (await canLaunch(KeyUtils.callUs)) {
                await launch(KeyUtils.callUs);
              } else {
                SnackBarHelper.show('', S.of(context).couldNotFindPhoneNumber);
              }
            },
          ),
        )
      ],
    );
  }
}
