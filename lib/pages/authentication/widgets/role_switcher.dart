import 'package:flutter/material.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 04/09/21 at 12:02 pm
///

class RoleSwitcher extends StatelessWidget {
  final int role;
  final Function(int r) onChanged;

  const RoleSwitcher({this.role, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              onChanged?.call(1);
            },
            behavior: HitTestBehavior.translucent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Radio(
                    value: 1,
                    groupValue: role,
                    onChanged: onChanged,
                  ),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    "Continue as Student",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              onChanged?.call(2);
            },
            behavior: HitTestBehavior.translucent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Radio(
                    value: 2,
                    groupValue: role,
                    onChanged: onChanged,
                  ),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    "Continue as Parent",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
