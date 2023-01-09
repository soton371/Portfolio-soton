import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio/resource/urls.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/generalController.dart';
import '../../resource/appClass.dart';
import '../../resource/colors.dart';

class LeftPane extends ConsumerStatefulWidget {
  const LeftPane({Key? key}) : super(key: key);

  @override
  ConsumerState<LeftPane> createState() => _LeftPaneState();
}

class _LeftPaneState extends ConsumerState<LeftPane> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Column(
          children: [
            Expanded(
                flex: 5,
                child: Container(
                  child: Consumer(builder: (context, ref, child) {
                    String val = ref.watch(hoverProvider);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //for git
                          Container(
                            height: AppClass().getMqHeight(context) * 0.07,
                            child: InkWell(
                              onTap: () async {
                                await launchUrl(
                                    Uri.parse(AppUrls.github));
                              },
                              onHover: (bol) {
                                if (bol) {
                                  ref.read(hoverProvider.notifier).state =
                                      "git";
                                } else {
                                  ref.read(hoverProvider.notifier).state = "";
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: val == "git" ? 5.0 : 0),
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: SvgPicture.asset('assets/svg/github.svg',
                                    color: val == "git"
                                        ? AppColors().neonColor
                                        : AppColors().textLight,
                                    width: 22),
                              ),
                            ),
                          ),
                          //end git

                          //for linkedin
                          Container(
                            height: AppClass().getMqHeight(context) * 0.07,
                            child: InkWell(
                              onTap: () async {
                                await launchUrl(Uri.parse(AppUrls.linkedin));
                              },
                              onHover: (bol) {
                                if (bol) {
                                  ref.read(hoverProvider.notifier).state =
                                      "linkedIn";
                                } else {
                                  ref.read(hoverProvider.notifier).state = "";
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: val == "linkedIn" ? 5.0 : 0),
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: SvgPicture.asset(
                                    'assets/svg/linkedIn.svg',
                                    color: val == "linkedIn"
                                        ? AppColors().neonColor
                                        : AppColors().textLight,
                                    width: 22),
                              ),
                            ),
                          ),
                          //end linkedin

                          //for stack over flow
                          Container(
                            height: AppClass().getMqHeight(context) * 0.07,
                            child: InkWell(
                              onTap: () async {
                                await launchUrl(Uri.parse(AppUrls.stackoverflow));
                              },
                              onHover: (bol) {
                                if (bol) {
                                  ref.read(hoverProvider.notifier).state =
                                      "stackoverflow";
                                } else {
                                  ref.read(hoverProvider.notifier).state = "";
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: val == "stackoverflow" ? 5.0 : 0),
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: SvgPicture.asset(
                                    'assets/svg/stackoverflow.svg',
                                    color: val == "stackoverflow"
                                        ? AppColors().neonColor
                                        : AppColors().textLight,
                                    width: 22),
                              ),
                            ),
                          ),
                          //end stack over flow
                        ],
                      ),
                    );
                  }),
                )),
            Expanded(
                child: Container(
              width: 1,
              color: AppColors().textLight,
            ))
          ],
        ));
  }
}
