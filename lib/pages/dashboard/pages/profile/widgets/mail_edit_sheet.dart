import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vems/api_services/authentication_api_services.dart';
import 'package:vems/bloc_models/profile_bloc/index.dart';
import 'package:vems/config/index.dart';
import 'package:vems/data_models/user.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/authentication/widgets/auth_text_widgets.dart';
import 'package:vems/utils/my_form_validators.dart';
import 'package:vems/utils/shared_preference_helper.dart';
import 'package:vems/utils/snackbar_helper.dart';
import 'package:vems/widgets/button.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 4/3/21 at 8:52 PM
///

class MailEditSheet extends StatefulWidget {
  @override
  _MailEditSheetState createState() => _MailEditSheetState();
}

class _MailEditSheetState extends State<MailEditSheet> {
  final _formKey = GlobalKey<FormState>();
  final _buttonKey = GlobalKey<MyButtonState>();
  bool _autoValidate = false;
  String _email = '', initialValue = '';

  @override
  void initState() {
    initialValue = ProfileBloc().user.email;
    _email = initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode:
          _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 5, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).editEmail,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                      icon: SvgPicture.asset(MyAssets.cross),
                      onPressed: () => Get.back())
                ],
              ),
            ),
            const Divider(
              height: 0,
              thickness: 1,
            ),
            const SizedBox(height: 23),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: TFLabelText(S.of(context).email),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                initialValue: initialValue,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                onChanged: (val) {
                  setState(() {
                    _email = val.trim();
                  });
                },
                validator: (value) {
                  _email = value.trim();
                  return MyFormValidators.validateMail(value.trim());
                },
                decoration: MyDecorations.textFieldDecoration(context).copyWith(
                  hintText: S.of(context).enterYourEmail,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 23, 16, 25),
              child: MyButton(
                key: _buttonKey,
                child: Text(S.of(context).save),
                width: double.infinity,
                onPressed: _email == initialValue
                    ? null
                    : () {
                        if (_formKey.currentState.validate()) {
                          print("$_email");
                          _buttonKey.currentState.showLoader();
                          userOnBoarding(body: {"email": _email}).then((datum) {
                            _buttonKey.currentState.hideLoader();
                            UserDatum temp = SharedPreferenceHelper.user;
                            temp.email = _email;
                            ProfileBloc().add(EditUserEvent(temp));
                            Get.back();
                            SnackBarHelper.show("Success",
                                S.of(context).profileUpdatedSuccessfully);
                          }).catchError((err, s) {
                            _buttonKey.currentState.hideLoader();
                            SnackBarHelper.show("ERROR", err?.toString());
                          });
                        } else {
                          setState(() {
                            _autoValidate = true;
                          });
                        }
                      },
              ),
            )
          ],
        ),
      ),
    );
  }
}
