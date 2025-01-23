import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../component/ItemWidget.dart';
import '../../model/DashboardResponse.dart';
import '../../network/RestApis.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/appWidget.dart';
import '../../utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import '../utils/Extensions/AppTextField.dart';
import '../utils/constant.dart';
import 'WebViewScreen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchCont = TextEditingController();
  ScrollController scrollController = ScrollController();
  // List<Category> games = [];
  List<Category> searchList = [];

  String searchText = '';
  int? timer;

  int page = 1;
  int numPage = 1;
  String error = '';
  bool hasError = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      scrollHandler();
    });
    init();
  }

  void init() async {
    appStore.setLoading(true);
    loadGames('');
  }

  scrollHandler() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !appStore.isLoading) {
      page++;
      loadGames(searchText);
    }
  }

  void loadGames(String text) {
    appStore.setLoading(true);
     searchGame(searchText: text, page: page).then((value) {
       if(page==1)
         searchList.clear();
      searchList.addAll(value);
      setState(() {});
      appStore.setLoading(false);
    }).catchError((e) {
      appStore.setLoading(false);
      error = e.toString();
      setState(() {});
    });
    // getGames().then((value) {
    //   // searchList = value;
    //   appStore.setLoading(true);
    //   isLoading = true;
    //   searchList.clear();
    //   return searchGame(searchText: text, page: page).then((value) {
    //     searchList.addAll(value);
    //     setState(() {});
    //     isLoading = false;
    //     appStore.setLoading(false);
    //   }).catchError((e) {
    //     appStore.setLoading(false);
    //     error = e.toString();
    //     setState(() {});
    //   });
    // }).catchError((e) {
    //   log(e);
    // });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(language.lblSearchGame, showBack: true),
      body: Observer(
        builder: (_) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    autoFocus: true,
                    textFieldType: TextFieldType.OTHER,
                    decoration: inputDecoration(context, label: language.lblSearchGame, prefixIcon: Icon(Ionicons.search_outline)),
                    controller: searchCont,
                    onChanged: (v) async {
                      setState(() {
                        searchText = v.trim();
                        page = 1;
                      });
                      if (timer == null) {
                        timer = 1500;
                        await timer.milliseconds.delay;
                        appStore.setLoading(true);
                        searchList.clear();
                        loadGames(searchText);
                        timer = null;
                      }
                    },
                    onFieldSubmitted: (c) {
                      appStore.setLoading(true);
                      searchList.clear();
                      loadGames(c);
                      setState(() {});
                    },
                  ).paddingAll(16),
                  searchList.isEmpty
                      ? noDataWidget(context).visible(!appStore.isLoading)
                      : SingleChildScrollView(
                          controller: scrollController,
                          padding: EdgeInsets.all(16),
                          child: Wrap(
                            runSpacing: 8,
                            spacing: 8,
                            alignment: WrapAlignment.start,
                            children: List.generate(
                              searchList.length,
                              (index) {
                                Category data = searchList[index];
                                return AnimationConfiguration.staggeredGrid(
                                  duration: Duration(milliseconds: 750),
                                  columnCount: 1,
                                  position: index,
                                  child: ItemWidget(data, isFavourite: true, onTap: () async {
                                    if (Platform.isAndroid) {
                                      if (data.url!.contains("market://") || data.url!.contains("play.google.com")) {
                                        await launchUrl(Uri.parse(data.url!));
                                      } else {
                                        WebViewScreen(isAdsLoad: true, mInitialUrl: data.url).launch(context);
                                      }
                                    } else {
                                      WebViewScreen(isAdsLoad: true,isAppBar: true, mInitialUrl: data.url).launch(context);
                                    }
                                  }),
                                );
                              },
                            ),
                          ),
                        ).expand()
                ],
              ),
            CircularProgressIndicator(color: primaryColor).center().visible(appStore.isLoading),
            ],
          );
        }
      ),
      bottomNavigationBar: mSearchBannerAds == '1' ? showBannerAds() : SizedBox(),
    );
  }
}
