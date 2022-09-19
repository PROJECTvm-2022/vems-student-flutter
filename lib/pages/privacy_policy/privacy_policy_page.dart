import 'package:flutter/material.dart';
import 'package:vems/config/index.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/widgets/back_button.dart';
import 'package:vems/widgets/shimmer_layouts/static_page_shimmer.dart';
import 'package:webview_flutter/webview_flutter.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 20/4/21 at 7:20 PM
///

class PrivacyPolicyPage extends StatefulWidget {
  static final routeName = '/PrivacyPolicyPage';

  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MyBackButton(),
        titleSpacing: 0,
        title: Text(
          S.of(context).privacyPolicy,
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
      body: Stack(
        children: [
          WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: KeyUtils.privacyUrl,
            onWebViewCreated: (WebViewController webViewController) {},
            onPageStarted: (val) {
              print("$val");
              setState(() {
                _isLoading = false;
              });
            },
          ),
          if (_isLoading)
            Positioned.fill(
              child: StaticPageShimmer(),
            )
        ],
      ),
    );
  }
}
