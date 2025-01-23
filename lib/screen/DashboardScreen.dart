import 'dart:io';

import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../screen/CategoryScreen.dart';
import '../../screen/FavouriteScreen.dart';
import '../../screen/HomeScreen.dart';
import '../../screen/SettingScreen.dart';
import '../../screen/WebViewScreen.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/device_extensions.dart';
import '../utils/Extensions/text_styles.dart';
import '../utils/colors.dart';

class DashboardScreen extends StatefulWidget {
  static String tag = '/DashboardScreen';

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final tab = [
    HomeScreen(),
    CategoryScreen(),
    FavouriteScreen(),
    SettingScreen(),
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {

    if (isMobile) {

      OneSignal.Notifications.addClickListener((notification) async{

        if (!notification.notification.launchUrl.isEmptyOrNull) {
              if (Platform.isAndroid) {
                if (notification.notification.launchUrl!.contains("market://") || notification.notification.launchUrl!.contains("play.google.com")) {
                  await launchUrl(Uri.parse(notification.notification.launchUrl!));
                } else {
                  WebViewScreen(mInitialUrl: notification.notification.launchUrl!).launch(context);
                }
              } else {
                WebViewScreen(mInitialUrl: notification.notification.launchUrl!,isAppBar: true,).launch(context);
              }
            }
      });

    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tab[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: context.scaffoldBackgroundColor,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedLabelStyle: primaryTextStyle(),
        currentIndex: _currentIndex,
        unselectedItemColor: unSelectIconColor,
        selectedItemColor: primaryColor,
        onTap: (index) {
          _currentIndex = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(AntDesign.home),
              activeIcon: Column(
                children: [
                  Icon(AntDesign.home),
                  Container(
                    height: 5,
                    margin: EdgeInsets.only(top: 4),
                    width: 5,
                    decoration: boxDecorationWithShadowWidget(boxShape: BoxShape.circle, backgroundColor: primaryColor),
                  )
                ],
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(MaterialCommunityIcons.view_dashboard_outline),
              activeIcon: Column(
                children: [
                  Icon(MaterialCommunityIcons.view_dashboard_outline),
                  Container(
                    height: 5,
                    margin: EdgeInsets.only(top: 4),
                    width: 5,
                    decoration: boxDecorationWithShadowWidget(boxShape: BoxShape.circle, backgroundColor: primaryColor),
                  )
                ],
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(MaterialIcons.favorite_border),
              activeIcon: Column(
                children: [
                  Icon(MaterialIcons.favorite_border),
                  Container(
                    height: 5,
                    margin: EdgeInsets.only(top: 4),
                    width: 5,
                    decoration: boxDecorationWithShadowWidget(boxShape: BoxShape.circle, backgroundColor: primaryColor),
                  )
                ],
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(Feather.settings),
              activeIcon: Column(
                children: [
                  Icon(Feather.settings),
                  Container(
                    height: 5,
                    margin: EdgeInsets.only(top: 4),
                    width: 5,
                    decoration: boxDecorationWithShadowWidget(boxShape: BoxShape.circle, backgroundColor: primaryColor),
                  )
                ],
              ),
              label: ""),
        ],
      ),
    );
  }
}
