import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/profile_bloc/index.dart';
import 'package:vems/config/functions.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 13/4/21 at 5:45 PM
///

class GreetingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, BaseState>(
        builder: (context, BaseState state) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              ProfileBloc().user.name == null
                  ? ""
                  : "Hey, ${ProfileBloc().user.name} ",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Row(
              children: [
                Text(
                  '${wish()}',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 29),
                ),
                const SizedBox(width: 15),
                SvgPicture.asset(wishAsset()),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(6), bottomLeft: Radius.circular(6)),
          gradient: dynamicDashboardGradient(context),
        ),
      );
    });
  }
}
