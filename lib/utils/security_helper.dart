import 'package:flutter/services.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 4/4/21 at 9:44 AM
///

class SecurityHelper {
  static const platform = MethodChannel('com.vernacularmedium.ems/security');

  static Future<void> enableSecurity() async {
    await platform.invokeMethod('enableSecurity');
  }

  static Future<void> disableSecurity() async {
    await platform.invokeMethod('disableSecurity');
  }
}
