import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/controller/generalController.dart';
import 'package:portfolio/resource/appClass.dart';
import 'package:portfolio/view/about/about.dart';
import 'package:portfolio/view/experience/experience.dart';
import 'package:portfolio/view/intro/intro.dart';
import 'package:portfolio/view/widget/appBar.dart';
import 'package:portfolio/view/widget/leftPane.dart';
import 'package:portfolio/view/widget/rightPane.dart';
import 'package:portfolio/view/work/work.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'contact/contact.dart';

class RootScreen extends ConsumerStatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends ConsumerState<RootScreen> {
  final aScrollController = AutoScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            final ScrollDirection direction = notification.direction;
            if (direction == ScrollDirection.reverse) {
              ref.read(scrollControlProvider.notifier).state = false;
            } else if (direction == ScrollDirection.forward) {
              ref.read(scrollControlProvider.notifier).state = true;
            }
            return true;
          },
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                  Color(0xffffffff),
                  Color(0xfffdf5ee)
                ])),
            height: AppClass().getMqHeight(context),
            child: Column(
              children: [
                //for appbar
                Consumer(builder: (context, ref, child) {
                  var isScrollingUp = ref.watch(scrollControlProvider);
                  return AnimatedOpacity(
                    opacity: isScrollingUp ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: ActionBar(aScrollController),
                  );
                }),
                //end appbar

                //for all body
                Expanded(
                  child: () {
                    ScreenType scrType = AppClass().getScreenType(context);
                    return Row(
                      children: [
                        //for left panel
                        scrType == ScreenType.mobile ? SizedBox() : LeftPane(),
                        //end left panel

                        //for content
                        Expanded(
                            flex: 8,
                            child: ListView(
                              controller: aScrollController,
                              children: [
                                AutoScrollTag(
                                    key: ValueKey(0),
                                    controller: aScrollController,
                                    index: 0,
                                    child: IntroContent(aScrollController)),
                                AutoScrollTag(
                                    key: ValueKey(1),
                                    controller: aScrollController,
                                    index: 1,
                                    child: About()),
                                AutoScrollTag(
                                    key: ValueKey(2),
                                    controller: aScrollController,
                                    index: 2,
                                    child: Experience()),
                                AutoScrollTag(
                                    key: ValueKey(3),
                                    controller: aScrollController,
                                    index: 3,
                                    child: Work()),
                                AutoScrollTag(
                                    key: ValueKey(4),
                                    controller: aScrollController,
                                    index: 4,
                                    child: Contact())
                              ],
                            )),
                        //end content

                        //for right panel
                        scrType == ScreenType.mobile ? SizedBox() : RightPane(),
                        //end right panel
                      ],
                    );
                  }(),
                ),
                //end all body
              ],
            ),
          ),
        ),
      ),
    );
  }
}
