import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vems/config/assets.dart';
import 'package:vems/pages/authentication/login/login_page.dart';
import 'package:vems/pages/authentication/signup/signup_page.dart';
import 'package:vems/pages/authentication/welcome/welcome_page.dart';
import 'package:vems/widgets/button.dart';
import 'package:vems/widgets/outlined_button.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 14/06/21 at 4:58 PM
///

class IntroPage extends StatefulWidget {
  static final routeName = '/IntroPage';

  const IntroPage({Key key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  int currentIndex = 0;

  List<Map<String, String>> introData = [
    {
      'asset': MyAssets.intro3,
      'title': 'Learn from on subject curated video lectures.',
    },
    {
      'asset': MyAssets.intro1,
      'title': 'Dedicated live classes for all subjects.',
    },
    {
      'asset': MyAssets.intro2,
      'title': 'Practice & assess yourself with online tests.',
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              const SizedBox(height: 26),
              Theme.of(context).brightness == Brightness.dark
                  ? SizedBox(
                      height: 67,
                      child: SvgPicture.asset(MyAssets.logoSvg),
                    )
                  : SvgPicture.asset(MyAssets.introLogo),
              const SizedBox(height: 30),
              CarouselSlider.builder(
                itemCount: introData.length,
                options: CarouselOptions(
                  height: height * 0.6,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  onPageChanged: (i, rsn) {
                    setState(() {
                      currentIndex = i;
                    });
                  },
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 600),
                  viewportFraction: 1,
                ),
                itemBuilder: (ctx, i, j) => Column(
                  children: [
                    Expanded(child: SvgPicture.asset(introData[i]['asset'])),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "${introData[i]['title']}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Color(0xff2F415E),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  introData.length,
                  (index) => AnimatedContainer(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    height: currentIndex == index ? 10 : 6,
                    width: currentIndex == index ? 10 : 6,
                    duration: Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentIndex == index
                          ? Colors.transparent
                          : Color(0xffCED0D2),
                      border: currentIndex != index
                          ? null
                          : Border.all(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Color(0xff2F415E),
                              width: 2,
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 85),
            ],
          ),
          Positioned(
            right: 16,
            left: 16,
            bottom: 16,
            child: Row(
              children: [
                Expanded(
                  child: MyButton(
                    height: 49,
                    child: Text("Register now"),
                    onPressed: () {
                      // SharedPreferenceHelper.setFirstTime(false);
                      Get.offAllNamed(SignUpPage.routeName);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: MyOutlineButton(
                    height: 49,
                    onPressed: () {
                      // SharedPreferenceHelper.setFirstTime(false);
                      Get.offAllNamed(LoginPage.routeName);
                    },
                    text: 'Skip',
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
