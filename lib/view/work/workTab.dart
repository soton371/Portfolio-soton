import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/controller/generalController.dart';
import 'package:portfolio/resource/appClass.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../resource/colors.dart';

class WorkTab extends ConsumerStatefulWidget {
  const WorkTab({Key? key}) : super(key: key);

  @override
  ConsumerState<WorkTab> createState() => _WorkWebState();
}

class _WorkWebState extends ConsumerState<WorkTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
              text: "03.",
              style: TextStyle(
                  color: AppColors().neonColor,
                  fontSize: 20,
                  fontFamily: 'sfmono'),
              children: <TextSpan>[
                TextSpan(
                  text: ' My Noteworthy Projects',
                  style: GoogleFonts.roboto(
                      color: AppColors().textColor,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )
              ]),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'view the archives',
            style: TextStyle(
                color: AppColors().neonColor,
                fontSize: 12,
                fontFamily: 'sfmono'),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 30.0, bottom: 50.0),
          child: StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            children: [
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: Tile(index: 0),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: Tile(index: 1),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: Tile(index: 2),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: Tile(index: 3),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Tile({required int index}) {
    return InkWell(
      onTap: () async {
        switch (index) {
          case 0:
            await launchUrl(Uri.parse(AppClass.zappAppSocial));
            break;

          case 1:
            await launchUrl(Uri.parse(AppClass.meekago));
            break;

          case 2:
            await launchUrl(Uri.parse(AppClass.smartDokani));
            break;

          case 3:
            await launchUrl(Uri.parse(AppClass.medicalSurveyReport));
            break;

          case 4:
            await launchUrl(Uri.parse(AppClass.rahma));
            break;

          case 5:
            await launchUrl(Uri.parse(AppClass.century5));
            break;
        }
      },
      onHover: (bool) {
        if (bool) {
          ref.read(hoverProvider.notifier).state = "$index";
        } else {
          ref.read(hoverProvider.notifier).state = "";
        }
      },
      child: Consumer(builder: (context, ref, child) {
        String data = ref.watch(hoverProvider);
        bool isHovered = (data == "$index");
        return Container(
          margin: EdgeInsets.all(isHovered ? 8.0 : 0.0),
          child: Card(
            color: AppColors().cardColor,
            elevation: 1,
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/folder.svg',
                        width: 45,
                        height: 45,
                        color: AppColors().neonColor,
                      ),
                      SvgPicture.asset(
                        'assets/svg/externalLink.svg',
                        width: 22,
                        height: 22,
                        color: isHovered
                            ? AppColors().neonColor
                            : AppColors().textLight,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 8.0),
                    child: Text(
                      AppClass().projectList[index].projectTitle.toString(),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: GoogleFonts.robotoSlab(
                          color: isHovered
                              ? AppColors().neonColor
                              : AppColors().textColor,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        AppClass().projectList[index].projectContent.toString(),
                        style: GoogleFonts.roboto(
                          color: AppColors().textLight,
                          letterSpacing: 1,
                          height: 1.5,
                          fontSize: 14,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
