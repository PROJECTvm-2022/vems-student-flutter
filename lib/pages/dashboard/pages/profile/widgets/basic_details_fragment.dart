import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vems/config/index.dart';
import 'package:vems/data_models/user.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/dashboard/pages/profile/widgets/mail_edit_sheet.dart';
import 'package:vems/pages/dashboard/pages/profile/widgets/phone_edit_sheet.dart';
import 'package:vems/utils/shared_preference_helper.dart';
import 'package:vems/widgets/disabled_textfield.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 3/3/21 at 10:30 PM
///

class BasicDetailsFragment extends StatelessWidget {
  final UserDatum datum;

  const BasicDetailsFragment({Key key, this.datum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        DisabledTextField(
          label: S.of(context).phone,
          value: datum.phone,
          asset: MyAssets.phoneFilled,
          trailingWidget: InkWell(
            onTap: () {
              Get.bottomSheet(PhoneEditSheet(),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor);
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                S.of(context).edit,
                style: TextStyle(
                  color: MyColors.brightPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        DisabledTextField(
          label: 'Email',
          value: datum.email,
          asset: MyAssets.mailEdit,
          trailingWidget: InkWell(
            onTap: () {
              Get.bottomSheet(MailEditSheet(),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor);
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                S.of(context).edit,
                style: TextStyle(
                  color: MyColors.brightPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        DisabledTextField(
          label: S.of(context).parentPhone,
          value: datum.parentPhone,
          asset: MyAssets.phoneFilled,
          vPadding: datum.parentPhone.isNotEmpty ? 16 : 0,
          trailingWidget: datum.parentPhone.isNotEmpty
              ? null
              : InkWell(
                  onTap: datum.parentPhone.isNotEmpty
                      ? null
                      : () {
                          Get.bottomSheet(PhoneEditSheet(parentPhone: true),
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor);
                        },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      datum.parentPhone.isEmpty
                          ? S.of(context).add
                          : S.of(context).edit,
                      style: TextStyle(
                        color: MyColors.brightPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
        ),
        const SizedBox(height: 16),
        DisabledTextField(
          label: S.of(context).course,
          value:
              "${SharedPreferenceHelper.user.studentSeat.instituteCourse.name}",
          asset: MyAssets.scholar,
          vPadding: 16,
        ),
        const SizedBox(height: 16),
        DisabledTextField(
          label: "Batch",
          value:
              "${SharedPreferenceHelper.user.studentSeat.instituteBatch.name}",
          asset: MyAssets.scholar,
          vPadding: 16,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
