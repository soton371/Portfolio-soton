import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/controller/generalController.dart';
import 'package:portfolio/resource/appClass.dart';
import 'package:portfolio/resource/colors.dart';
import 'package:portfolio/view/about/about.dart';
import 'package:portfolio/view/experience/experience.dart';
import 'package:portfolio/view/intro/intro.dart';
import 'package:iconsax/iconsax.dart';
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
  final _advancedDrawerController = AdvancedDrawerController();
  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
        backdropColor: AppColors().textLight,
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: true,
        openRatio: 0.3,
        disabledGestures: false,
        childDecoration: const BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: SafeArea(
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
                        child: (){
                          ScreenType scrType = AppClass().getScreenType(context);
                          if (scrType == ScreenType.mobile || scrType == ScreenType.tab) {
                            return Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                        padding: const EdgeInsets.only(left: 20.0),
                                        child: Text('S',style: TextStyle(fontStyle: FontStyle.italic,color: AppColors().neonColor,fontSize: 20),)
                                    )),
                                Expanded(
                                  flex: 9,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: _handleMenuButtonPressed,
                                        icon: ValueListenableBuilder<AdvancedDrawerValue>(
                                          valueListenable: _advancedDrawerController,
                                          builder: (_, value, __) {
                                            return AnimatedSwitcher(
                                              duration: Duration(milliseconds: 250),
                                              child: Icon(
                                                value.visible ? Icons.clear : Icons.menu,
                                                key: ValueKey<bool>(value.visible),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                          return Row(
                            children: [
                              Expanded(
                                  child: Container(
                                    height: 40,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(3.0)),
                                        border: Border.all(
                                            color: AppColors().neonColor, width: 1.5)),
                                    child: Center(
                                      child: Text('Soton',
                                          style: TextStyle(
                                              color: AppColors().neonColor,
                                              fontSize: 13,
                                              letterSpacing: 1,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'sfmono')),
                                    ),
                                  )
                              ),
                              Expanded(
                                flex: 9,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    /*Text(scrType.name),*/
                                    InkWell(
                                      onTap: () {
                                        aScrollController.scrollToIndex(1,
                                            preferPosition: AutoScrollPosition.begin);
                                      },
                                      onHover: (bol) {
                                        if (bol) {
                                          ref.read(hoverProvider.notifier).state = "aboutTitle";
                                        } else {
                                          ref.read(hoverProvider.notifier).state = "";
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 30.0),
                                        child: Row(
                                          children: [
                                            Text("01. ",
                                                style: TextStyle(
                                                    color: AppColors().neonColor,
                                                    fontSize: 13,
                                                    fontFamily: 'sfmono')),
                                            Consumer(builder: (context, ref, child) {
                                              String state = ref.watch(hoverProvider);
                                              bool isHovered = (state == "aboutTitle");
                                              return Text("About",
                                                  style: TextStyle(
                                                      color: isHovered
                                                          ? AppColors().neonColor
                                                          : AppColors().textColor,
                                                      fontSize: 13,
                                                      fontFamily: 'sfmono'));
                                            }),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        aScrollController.scrollToIndex(2,
                                            preferPosition: AutoScrollPosition.begin);
                                      },
                                      onHover: (bol) {
                                        if (bol) {
                                          ref.read(hoverProvider.notifier).state = "expTitle";
                                        } else {
                                          ref.read(hoverProvider.notifier).state = "";
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 30.0),
                                        child: Row(
                                          children: [
                                            Text("02. ",
                                                style: TextStyle(
                                                    color: AppColors().neonColor,
                                                    fontSize: 13,
                                                    fontFamily: 'sfmono')),
                                            Consumer(builder: (context, ref, child) {
                                              String state = ref.watch(hoverProvider);
                                              bool isHovered = (state == "expTitle");
                                              return Text("Experience",
                                                  style: TextStyle(
                                                      color: isHovered
                                                          ? AppColors().neonColor
                                                          : AppColors().textColor,
                                                      fontSize: 13,
                                                      fontFamily: 'sfmono'));
                                            }),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        aScrollController.scrollToIndex(3,
                                            preferPosition: AutoScrollPosition.begin);
                                      },
                                      onHover: (bol) {
                                        if (bol) {
                                          ref.read(hoverProvider.notifier).state = "workTitle";
                                        } else {
                                          ref.read(hoverProvider.notifier).state = "";
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 30.0),
                                        child: Row(
                                          children: [
                                            Text("03. ",
                                                style: TextStyle(
                                                    color: AppColors().neonColor,
                                                    fontSize: 13,
                                                    fontFamily: 'sfmono')),
                                            Consumer(builder: (context, ref, child) {
                                              String state = ref.watch(hoverProvider);
                                              bool isHovered = (state == "workTitle");

                                              return Text("Work",
                                                  style: TextStyle(
                                                      color: isHovered
                                                          ? AppColors().neonColor
                                                          : AppColors().textColor,
                                                      fontSize: 13,
                                                      fontFamily: 'sfmono'));
                                            }),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        aScrollController.scrollToIndex(4,
                                            preferPosition: AutoScrollPosition.begin);
                                      },
                                      onHover: (bol) {
                                        if (bol) {
                                          ref.read(hoverProvider.notifier).state =
                                          "contactTitle";
                                        } else {
                                          ref.read(hoverProvider.notifier).state = "";
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          Text("04.",
                                              style: TextStyle(
                                                  color: AppColors().neonColor,
                                                  fontSize: 13,
                                                  fontFamily: 'sfmono')),
                                          Consumer(builder: (context, ref, child) {
                                            String state = ref.watch(hoverProvider);
                                            bool isHovered = (state == "contactTitle");
                                            return Text("Contact",
                                                style: TextStyle(
                                                    color: isHovered
                                                        ? AppColors().neonColor
                                                        : AppColors().textColor,
                                                    fontSize: 13));
                                          }),
                                        ],
                                      ),
                                    ),

                                    //for cv
                                    /*InkWell(
                      onTap: () {
                        AppClass().downloadResume(context);
                      },
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(3.0)),
                            border: Border.all(
                                color: AppColors().neonColor, width: 1.5)),
                        child: Center(
                          child: Text('Resume',
                              style: TextStyle(
                                  color: AppColors().neonColor,
                                  fontSize: 13,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'sfmono')),
                        ),
                      ),
                    ),*/
                                    //end cv
                                  ],
                                ),
                              ),
                            ],
                          );
                        }()
                        // child: ActionBar(aScrollController),
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
        ),
        drawer: SafeArea(
          child: Container(
            child: ListTileTheme(
              textColor: AppColors().cardColor,
              iconColor: AppColors().cardColor,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 50,),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/svg/profilePic.jpg"),
                  ),
                  SizedBox(height: 50,),
                  /*Container(
                    width: 128.0,
                    height: 128.0,
                    margin: const EdgeInsets.only(
                      top: 24.0,
                      bottom: 64.0,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/svg/profilePic.jpg',
                    ),
                  ),*/

                  ListTile(
                    onTap: () =>aScrollController.scrollToIndex(1,
                        preferPosition: AutoScrollPosition.begin),
                    leading: Icon(Iconsax.user_octagon),
                    title: Text('About',
                    style: TextStyle(
                        fontFamily: 'sfmono'),
                    ),
                  ),
                  ListTile(
                    onTap: () =>aScrollController.scrollToIndex(2,
                      preferPosition: AutoScrollPosition.begin),
                    leading: Icon(Iconsax.code),
                    title: Text('Experience',style: TextStyle(
                        fontFamily: 'sfmono'),),
                  ),
                  ListTile(
                    onTap: () =>aScrollController.scrollToIndex(3,
                        preferPosition: AutoScrollPosition.begin),
                    leading: Icon(Iconsax.task_square),
                    title: Text('Work',style: TextStyle(
                        fontFamily: 'sfmono'),),
                  ),
                  ListTile(
                    onTap: () =>aScrollController.scrollToIndex(4,
                        preferPosition: AutoScrollPosition.begin),
                    leading: Icon(Iconsax.message),
                    title: Text('Contact',style: TextStyle(
                        fontFamily: 'sfmono'),),
                  ),
                  Spacer(),
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white54,
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 16.0,
                      ),
                      child: Text('soton | ©2023'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}

/*PopupMenuButton(
                                        color: AppColors().cardColor,
                                        itemBuilder: (c) => <PopupMenuEntry>[
                                          PopupMenuItem(
                                            child: Container(
                                                width: 90.0,
                                                child: InkWell(
                                                  onTap: () => widget.controller.scrollToIndex(
                                                      1,
                                                      preferPosition: AutoScrollPosition.begin),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.account_circle_rounded,
                                                          size: 18),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(left: 10.0),
                                                        child: Text(
                                                          'About',
                                                          style: GoogleFonts.roboto(),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          ),
                                          PopupMenuItem(
                                            child: InkWell(
                                              onTap: () => widget.controller.scrollToIndex(2,
                                                  preferPosition: AutoScrollPosition.begin),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.travel_explore_rounded, size: 18),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 10.0),
                                                    child: Text(
                                                      'Experience',
                                                      style: GoogleFonts.roboto(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          PopupMenuItem(
                                            child: InkWell(
                                              onTap: () => widget.controller.scrollToIndex(3,
                                                  preferPosition: AutoScrollPosition.begin),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.computer_rounded, size: 18),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 10.0),
                                                    child: Text(
                                                      'Work',
                                                      style: GoogleFonts.roboto(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          PopupMenuItem(
                                            child: InkWell(
                                              onTap: () => widget.controller.scrollToIndex(4,
                                                  preferPosition: AutoScrollPosition.begin),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.phone_rounded, size: 18),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 10.0),
                                                    child: Text(
                                                      'Contact',
                                                      style: GoogleFonts.roboto(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                        child: Icon(Icons.menu_rounded, size: 25, color: AppColors().textLight,),
                                      )*/

/*
SafeArea(
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
 */