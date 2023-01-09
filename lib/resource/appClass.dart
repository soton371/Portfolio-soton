import 'package:flutter/material.dart';
import 'package:portfolio/resource/styles.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/workModel.dart';

enum ScreenType { mobile, tab, web }

class AppClass {
  static final AppClass _mAppClass = AppClass._internal();
  static BuildContext? lastContext;
  ScrollController controller = ScrollController();

  /* URL */
  static final resumeDownloadURL =
      '''https://jeeva-portfolio.s3.amazonaws.com/JEEVANANDHAM's+Resume.pdf''';

  static final rahma = '''https://play.google.com/store/apps/details?id=com.smartsoftware.rahma&hl=en&gl=US''';

  static final meekago = '''https://play.google.com/store/apps/details?id=com.meekago.app&hl=en&gl=US''';
  static final smartDokani = '''https://play.google.com/store/apps/details?id=com.smartsoftwarebd.dokani&hl=en&gl=US''';
  static final medicalSurveyReport =
      '''https://apps.apple.com/us/app/medical-survey-report/id6443634739''';
  static final dokandar = '''https://play.google.com/store/apps/details?id=xyz.dokandar.userapp&hl=en&gl=US''';
  static final century5 = '''https://play.google.com/store/apps/details?id=com.smartsoftware.century5&hl=en&gl=US''';


  List<WorkModel> projectList = [
    WorkModel(
        projectTitle: "Rahma",
        projectContent:
            "Arabic with Bengali pronunciation and Bengali meaning. Also find nearby mosques.",
        tech1: "Dart",
        tech2: "Flutter",
        tech3: "Google Services",
    ),
    WorkModel(
        projectTitle: "Smart Dokani",
        projectContent: "Smart Dokani an Incredibly powerful POS app that can handle all necessary operations of your retail shop.",
        tech1: "Flutter",
        tech2: "Dart",
        tech3: "Rest API",
    ),
    WorkModel(
        projectTitle: "Medical Survey",
        projectContent:
            '''Medical Survey is a reporting tool for ATI Limited Marketing User.''',
        tech1: "Dart",
        tech2: "Flutter",
        tech3: "API",
    ),
    WorkModel(
        projectTitle: "Dokandar",
        projectContent:
            '''Dokander.xyz mainly e-commerce and vendor applications.''',
        tech1: "Dart",
        tech2: "Flutter",
        tech3: "Rest API",
    ),
    WorkModel(
        projectTitle: "Meekago",
        projectContent:
            '''Meekago is an Online Grocery Shop. We are here to serve you with best quality Product and best price.''',
        tech1: "Flutter",
        tech2: "Dart",
        tech3: "Rest API"
    ),
    WorkModel(
        projectTitle: "Century5",
        projectContent:
            '''The hardest part is making the decision, the rest is sheer determination.''',
        tech1: "Flutter",
        tech2: "Dart",
        tech3: "API",
    ),
  ];

  factory AppClass() {
    return _mAppClass;
  }

  AppClass._internal();

  getMqWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  getMqHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  showSnackBar(String msg, {BuildContext? context}) {
    ScaffoldMessenger.of(context ?? lastContext!)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  ScreenType getScreenType(BuildContext context) {
    double scrWidth = getMqWidth(context);
    if (scrWidth > 915) {
      return ScreenType.web;
    } else if (scrWidth < 650) {
      return ScreenType.mobile;
    }
    return ScreenType.tab;
  }

  downloadResume(context) async {
    await launchUrl(Uri.parse(AppClass.resumeDownloadURL));
  }

  alertDialog(context, title, msg) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
                title: Text(title, style: TxtStyle().boldWhite(context)),
                content: Text(msg),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text('Okay'))
                ]));
  }
}
