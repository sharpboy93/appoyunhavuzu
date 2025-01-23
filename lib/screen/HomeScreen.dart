import 'dart:io';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mighty_games/component/ItemWidget.dart';
import 'package:mighty_games/model/DashboardResponse.dart';
import 'package:mighty_games/network/RestApis.dart';
import 'package:mighty_games/screen/ViewAllScreen.dart';
import 'package:mighty_games/screen/WebViewScreen.dart';
import 'package:mighty_games/utils/Extensions/Widget_extensions.dart';
import 'package:mighty_games/utils/Extensions/decorations.dart';
import 'package:mighty_games/utils/Extensions/int_extensions.dart';
import 'package:mighty_games/utils/appWidget.dart';
import 'package:mighty_games/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../component/SliderWidget.dart';
import '../main.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/HorizontalList.dart';
import '../utils/Extensions/text_styles.dart';
import 'package:mighty_games/utils/Extensions/string_extensions.dart';
import '../utils/constant.dart';
import 'SearchScreen.dart';

class HomeScreen extends StatefulWidget {
  static String tag = '/HomeScreen';

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget mHeading(String title, {int? id, bool? isFeatured = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: primaryTextStyle(size: 20, fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w500).fontFamily)).expand(),
        Icon(Icons.keyboard_arrow_right, color: textPrimaryColorGlobal).onTap(() {
          ViewAllScreen(categoryId: id, title: title, isFeatured: isFeatured).launch(context);
        }),
      ],
    ).paddingSymmetric(horizontal: 16, vertical: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(AppName, style: primaryTextStyle(size: 22, color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Ionicons.search_sharp, color: Colors.white),
            onPressed: () {
              SearchScreen().launch(context);
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await 2.seconds.delay;
          setState(() {});
        },
        child: FutureBuilder<DashboardResponse>(
          future: getDashboard(),
          builder: (_, snap) {
            if (snap.hasData) {
              return snap.data!.featuredModule != null && snap.data!.featuredModule!.isNotEmpty
                  ? SingleChildScrollView(physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (snap.data!.slider != null && snap.data!.slider!.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                16.height,
                                HorizontalList(
                                  itemCount: snap.data!.slider!.length,
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  itemBuilder: (BuildContext context, int i) {
                                    return SliderWidget(
                                      snap.data!.slider![i],
                                      onTap: () async {
                                        WebViewScreen(mInitialUrl: snap.data!.slider![i].url).launch(context);
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          if (snap.data!.featuredModule != null && snap.data!.featuredModule!.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                10.height,
                                mHeading(language.lblFeatured, isFeatured: true),
                                HorizontalList(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: snap.data!.featuredModule!.length,
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    itemBuilder: (BuildContext context, int index) {
                                      return ItemWidget(snap.data!.featuredModule![index], onTap: () async {
                                        if (Platform.isAndroid) {
                                          if (snap.data!.featuredModule![index].url!.contains("market://") || snap.data!.featuredModule![index].url!.contains("play.google.com")) {
                                            await launchUrl(Uri.parse(snap.data!.featuredModule![index].url!));
                                          } else {
                                            WebViewScreen(
                                              isAdsLoad: true,
                                              mInitialUrl: snap.data!.featuredModule![index].url,
                                            ).launch(context);
                                          }
                                        } else {
                                          WebViewScreen(
                                            isAdsLoad: true,
                                            isAppBar: true,
                                            mInitialUrl: snap.data!.featuredModule![index].url,
                                          ).launch(context);
                                        }
                                      });
                                    }),
                              ],
                            ),
                          if (snap.data!.category != null && snap.data!.category!.isNotEmpty)
                            ListView.builder(
                              itemCount: snap.data!.category!.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(bottom: 16),
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    mHeading(snap.data!.category![index].name!, id: snap.data!.category![index].id.toInt()),
                                    HorizontalList(
                                      physics: BouncingScrollPhysics(),
                                      itemCount: snap.data!.category![index].games!.length,
                                      padding: EdgeInsets.symmetric(horizontal: 16),
                                      itemBuilder: (BuildContext context, int i) {
                                        return ItemWidget(
                                          snap.data!.category![index].games![i],
                                          onTap: () async {
                                            if (Platform.isAndroid) {
                                              if (snap.data!.category![index].games![i].url!.contains("market://") || snap.data!.category![index].games![i].url!.contains("play.google.com")) {
                                                await launchUrl(Uri.parse(snap.data!.category![index].games![i].url!));
                                              } else {
                                                WebViewScreen(isAdsLoad: true, mInitialUrl: snap.data!.category![index].games![i].url).launch(context);
                                              }
                                            } else {
                                              WebViewScreen(isAdsLoad: true,isAppBar: true,mInitialUrl: snap.data!.category![index].games![i].url).launch(context);
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ).paddingBottom(16).visible(snap.data!.category![index].games!.isNotEmpty);
                              },
                            ),
                        ],
                      ),
                    )
                  : noDataWidget(context);
            }
            return snapWidgetHelper(snap, loadingWidget: mProgress());
          },
        ),
      ),
    );
  }
}
