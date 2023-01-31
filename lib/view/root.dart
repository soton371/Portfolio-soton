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
    ScreenType scrType = AppClass().getScreenType(context);
    return AdvancedDrawer(
        backdropColor: AppColors().textLight,
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: true,
        openRatio: scrType == ScreenType.mobile? 0.39 : 0.2,
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
                          // ScreenType scrType = AppClass().getScreenType(context);
                          if (scrType == ScreenType.mobile || scrType == ScreenType.tab) {
                            return Row(
                              children: [
                                Image.asset('assets/svg/logo.png',height: 60,),

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
                          return Container(
                            height: 70,
                            padding: EdgeInsets.only(right: 55.0, top: 10.0,left: 50.00),
                            child: Row(
                              children: [
                                Image.asset('assets/svg/logo.png'),

                                //for menu items web
                                Expanded(
                                  flex: 9,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      //for about
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
                                          child: Consumer(builder: (context, ref, child) {
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
                                        ),
                                      ),
                                      //end about

                                      //for Experience
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
                                          child: Consumer(builder: (context, ref, child) {
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
                                        ),
                                      ),
                                      //end Experience

                                      //for Work
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
                                          child: Consumer(builder: (context, ref, child) {
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
                                        ),
                                      ),
                                      //end Work

                                      //for Contact
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
                                        child: Consumer(builder: (context, ref, child) {
                                          String state = ref.watch(hoverProvider);
                                          bool isHovered = (state == "contactTitle");
                                          return Text("Contact",
                                              style: TextStyle(
                                                  color: isHovered
                                                      ? AppColors().neonColor
                                                      : AppColors().textColor,
                                                  fontSize: 13));
                                        }),
                                      ),
                                      //end Contact
                                    ],
                                  ),
                                ),
                                //end menu items web
                              ],
                            ),
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
                    radius: 40,
                    backgroundImage: AssetImage("assets/svg/profilePic.jpg"),
                  ),
                  SizedBox(height: 50,),

                  ListTile(
                    onTap: () =>aScrollController.scrollToIndex(1,
                        preferPosition: AutoScrollPosition.begin),
                    title: Row(
                      children: [
                        Icon(Iconsax.user_octagon,size: scrType == ScreenType.mobile? 13:14),
                        Text(' About',
                        style: TextStyle(
                            fontFamily: 'sfmono',
                          fontSize: scrType == ScreenType.mobile? 13:14
                        ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () =>aScrollController.scrollToIndex(2,
                      preferPosition: AutoScrollPosition.begin),
                    // leading: Icon(Iconsax.code,size: scrType == ScreenType.mobile? 13:14),
                    title: Row(
                      children: [
                        Icon(Iconsax.code,size: scrType == ScreenType.mobile? 13:14),
                        Text(' Experience',style: TextStyle(
                            fontFamily: 'sfmono',
                            fontSize: scrType == ScreenType.mobile? 13:14
                        ),),
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () =>aScrollController.scrollToIndex(3,
                        preferPosition: AutoScrollPosition.begin),
                    // leading: Icon(Iconsax.task_square,size: scrType == ScreenType.mobile? 13:14),
                    title: Row(
                      children: [
                        Icon(Iconsax.task_square,size: scrType == ScreenType.mobile? 13:14),
                        Text(' Work',style: TextStyle(
                            fontFamily: 'sfmono',
                            fontSize: scrType == ScreenType.mobile? 13:14
                        ),),
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () =>aScrollController.scrollToIndex(4,
                        preferPosition: AutoScrollPosition.begin),
                    // leading: Icon(Iconsax.message,size: scrType == ScreenType.mobile? 13:14,),
                    title: Row(
                      children: [
                        Icon(Iconsax.message,size: scrType == ScreenType.mobile? 13:14,),
                        Text(' Contact',style: TextStyle(
                            fontFamily: 'sfmono',
                            fontSize: scrType == ScreenType.mobile? 13:14
                        ),),
                      ],
                    ),
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
