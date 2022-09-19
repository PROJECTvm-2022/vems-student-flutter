import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vems/api_services/authentication_api_services.dart';
import 'package:vems/api_services/base_api.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/profile_bloc/index.dart';
import 'package:vems/config/index.dart';
import 'package:vems/data_models/user.dart';
import 'package:vems/utils/shared_preference_helper.dart';
import 'package:vems/utils/snackbar_helper.dart';
import 'package:vems/widgets/my_avatar.dart';
import 'package:vems/widgets/photo_chooser.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 3/3/21 at 10:29 PM
///

class DPUpdateWidget extends StatefulWidget {
  final bool isProfilePage;

  const DPUpdateWidget({Key key, this.isProfilePage = false}) : super(key: key);

  @override
  _DPUpdateWidgetState createState() => _DPUpdateWidgetState();
}

class _DPUpdateWidgetState extends State<DPUpdateWidget> {
  bool isLoading = false;

  handleUpdate() async {
    var result = await Get.bottomSheet(PhotoChooser(),
        backgroundColor: MyColors.brightBackgroundColor);
    if (result != null) {
      setState(() {
        isLoading = true;
      });
      ApiCall.singleFileUpload(result).then((url) {
        print('uploaded url : $url');
        userOnBoarding(body: {"avatar": url}).then((value) {
          setState(() {
            isLoading = false;
          });
          UserDatum temp = SharedPreferenceHelper.user;
          temp.avatar = url ?? '';
          ProfileBloc().add(EditUserEvent(temp));
        }).catchError((err) {
          setState(() {
            isLoading = false;
          });
          SnackBarHelper.show('', err?.toString());
        });
      }).catchError((err, s) {
        setState(() {
          isLoading = false;
        });
        SnackBarHelper.show('', err?.toString());
      });
    }
  }

  @override
  void didUpdateWidget(covariant DPUpdateWidget oldWidget) {
    setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, BaseState>(
      builder: (context, BaseState state) {
        return Center(
          child: Stack(
            children: [
              Container(
                child: MyCircleAvatar(ProfileBloc().user.avatar ?? "",
                    name: ProfileBloc().user.name, radius: 48),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
              ),
              if (isLoading)
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: Center(
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),
                ),
              if (widget.isProfilePage)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: isLoading
                        ? null
                        : () {
                            handleUpdate();
                          },
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset(MyAssets.photo),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
