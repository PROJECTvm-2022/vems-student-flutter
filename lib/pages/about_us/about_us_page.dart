import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vems/config/index.dart';
import 'package:vems/generated/l10n.dart';
import 'package:vems/widgets/back_button.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 20/4/21 at 7:17 PM
///

class AboutUsPage extends StatefulWidget {
  static final routeName = '/AboutUsPage';

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MyBackButton(),
        titleSpacing: 0,
        title: Text(
          S.of(context).aboutUs,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).brightness == Brightness.light
                ? MyColors.appBarTextColorLight
                : MyColors.darkTextColor,
          ),
        ),
        // titleSpacing: 0,
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : MyColors.darkTFColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Image.asset(MyAssets.aboutUsBanner),
          const SizedBox(height: 18),
          StaticPageHeading("About Jupion classes"),
          const SizedBox(height: 10),
          GreyBodyText(
              "Jupion is an offshoot of Jupiter Group which focuses on bridging the gap between the urban-rural education diviJupion is the one step solution, bridging the gap between the urban-rural education divide. The competitiveness has reached a higher limit which so puts forward the issues like preparation for the entrances, limited seats and competition in bulk. Jupion has come up with the solution. We here provide the guidance for the competitive exams with the best possible ways to all the students irrespective of the division due to mediums, with the best of the educators from Odisha, helping with the preparations and focusing on the entrances and education as well."),
          const SizedBox(height: 25),
          SvgPicture.asset(MyAssets.mission),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: StaticPageHeading("Our mission"),
          ),
          GreyBodyText(
              "Our aim is to focus on every ems with sole effort to help the budding caterpillars transform themselves into beautiful butterflies gone through all the processes, are ready to fly high and set examples."),
          const SizedBox(height: 25),
          SvgPicture.asset(MyAssets.vision),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: StaticPageHeading("Our vision"),
          ),
          GreyBodyText(
              "Jupion has come up with various features to ensure development of its students like the live sessions, practice sessions, doubt-clearing sessions and many more. In addition to it, progress tracker and individual guidance too. Jupion has a completely new and never before approach for the students’ clear conceptualization and understanding. And exclusively the classes are multilingual, as to focus on better understanding of Odia Medium students too. Our mobile application simplifies the whole learning process at a different level, allowing the students to gain knowledge at their comfortable timings. "),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}

class StaticPageHeading extends StatelessWidget {
  final String text;
  final TextAlign align;

  StaticPageHeading(this.text, {this.align});

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      textAlign: align ?? TextAlign.center,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class GreyBodyText extends StatelessWidget {
  final String text;
  final TextAlign align;

  GreyBodyText(this.text, {this.align});

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      textAlign: align ?? TextAlign.justify,
      style: TextStyle(
        color: Theme.of(context).brightness == Brightness.light
            ? MyColors.bodyGreyText
            : MyColors.darkTextColor,
      ),
    );
  }
}
