import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vems/api_services/static_services.dart';
import 'package:vems/config/index.dart';
import 'package:vems/data_models/user.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/pages/authentication/widgets/auth_text_widgets.dart';
import 'package:vems/pages/contact_us/widgets/contact_actions.dart';
import 'package:vems/utils/my_form_validators.dart';
import 'package:vems/utils/shared_preference_helper.dart';
import 'package:vems/utils/snackbar_helper.dart';
import 'package:vems/widgets/back_button.dart';
import 'package:vems/widgets/button.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 20/4/21 at 7:18 PM
///

class ContactUsPage extends StatefulWidget {
  static final routeName = '/ContactUsPage';

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _formKey = GlobalKey<FormState>();
  final _buttonKey = GlobalKey<MyButtonState>();
  String _name = '';
  String _mail = '';
  String _phone = '';
  String _description = '';
  FocusNode _mailNode = FocusNode();
  FocusNode _phoneNode = FocusNode();
  FocusNode _descNode = FocusNode();
  bool _autoValidate = false;

  UserDatum get _user => SharedPreferenceHelper.user;

  @override
  void initState() {
    _name = _user.name;
    _mail = _user.email;
    _phone = _user.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: MyBackButton(),
        titleSpacing: 0,
        title: Text(
          S.of(context).contactUs,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).brightness == Brightness.light
                ? MyColors.appBarTextColorLight
                : MyColors.darkTextColor,
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : MyColors.darkTFColor,
      ),
      body: Form(
        key: _formKey,
        autovalidateMode:
            _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
              children: [
                SvgPicture.asset(MyAssets.contactUsVector),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    S.of(context).contactUs,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ContactActions(),
                const SizedBox(height: 20),
                Text(
                  S.of(context).tellUsYourStory,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                TFLabelText(S.of(context).name),
                TextFormField(
                  initialValue: _name,
                  scrollPadding: EdgeInsets.only(bottom: 100),
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => node.requestFocus(_mailNode),
                  validator: (value) {
                    _name = value.trim();
                    return MyFormValidators.validateEmpty(value.trim());
                  },
                  decoration:
                      MyDecorations.textFieldDecoration(context).copyWith(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SvgPicture.asset(
                        MyAssets.person,
                        color: Theme.of(context).brightness == Brightness.light
                            ? MyColors.lightTextColor
                            : MyColors.darkTextColor,
                      ),
                    ),
                    hintText: S.of(context).enterYourName,
                  ),
                ),
                const SizedBox(height: 15),
                TFLabelText(S.of(context).email),
                TextFormField(
                  initialValue: _mail,
                  focusNode: _mailNode,
                  scrollPadding: EdgeInsets.only(bottom: 100),
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => node.requestFocus(_phoneNode),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    _mail = value.trim();
                    return MyFormValidators.validateMail(value.trim());
                  },
                  decoration:
                      MyDecorations.textFieldDecoration(context).copyWith(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SvgPicture.asset(
                        MyAssets.mail,
                        color: Theme.of(context).brightness == Brightness.light
                            ? MyColors.lightTextColor
                            : MyColors.darkTextColor,
                      ),
                    ),
                    hintText: S.of(context).enterYourEmailId,
                  ),
                ),
                const SizedBox(height: 15),
                TFLabelText(S.of(context).phone),
                TextFormField(
                  initialValue: _phone,
                  focusNode: _phoneNode,
                  scrollPadding: EdgeInsets.only(bottom: 100),
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => node.requestFocus(_descNode),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    _phone = value.trim();
                    return MyFormValidators.validatePhone(value.trim());
                  },
                  maxLength: 10,
                  decoration:
                      MyDecorations.textFieldDecoration(context).copyWith(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SvgPicture.asset(
                        MyAssets.phone,
                        color: Theme.of(context).brightness == Brightness.light
                            ? MyColors.lightTextColor
                            : MyColors.darkTextColor,
                      ),
                    ),
                    hintText: S.of(context).enterYourPhoneNumber,
                  ),
                ),
                const SizedBox(height: 15),
                TFLabelText(S.of(context).description),
                TextFormField(
                  maxLines: 5,
                  minLines: 3,
                  initialValue: _description,
                  focusNode: _descNode,
                  scrollPadding: EdgeInsets.only(bottom: 140),
                  validator: (value) {
                    _description = value.trim();
                    return MyFormValidators.validateEmpty(value.trim());
                  },
                  decoration:
                      MyDecorations.textFieldDecoration(context).copyWith(
                    hintText: S.of(context).enterYourDescription,
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
            Positioned(
              right: 16,
              left: 16,
              bottom: 16,
              child: MyButton(
                key: _buttonKey,
                width: double.infinity,
                child: Text(S.of(context).send),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    //print("$_name : $_mail : $_phone : $_description");
                    Get.focusScope.unfocus();
                    _buttonKey.currentState.showLoader();
                    requestForContact({
                      "name": _name,
                      "email": _mail,
                      "phone": _phone,
                      "description": _description,
                    }).then((value) {
                      _buttonKey.currentState.hideLoader();
                      Get.back();
                      SnackBarHelper.show('',
                          "Request submitted successfully. \nWe'll contact you soon.");
                    }).catchError((err) {
                      _buttonKey.currentState.hideLoader();
                      SnackBarHelper.show('', err?.toString());
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
