import 'package:flutter/cupertino.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/appWidget.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../component/SettingItemWidget.dart';
import '../component/ThemeSelectionDialog.dart';
import '../main.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/device_extensions.dart';
import '../utils/Extensions/shared_pref.dart';
import 'AboutUsScreen.dart';
import 'LanguageScreen.dart';
import 'WebViewScreen.dart';

class SettingScreen extends StatefulWidget {
  static String tag = '/SettingScreen';

  @override
  SettingScreenState createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
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

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(language.lblSetting.validate()),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingItemWidget(
              title: language.lblSelectTheme,
              leading: Icon(MaterialCommunityIcons.theme_light_dark),
              onTap: () async {
                hideKeyboard(context);
                showDialog(
                  context: context,
                  builder: (_) => ThemeSelectionDialog(),
                );
              },
            ),
            Divider(height: 1),
            SettingItemWidget(
              title: language.lblSelectLanguage,
              leading: Icon(Ionicons.language_outline),
              onTap: () async {
                bool res = await LanguageScreen().launch(context);
                if (res == true) setState(() {});
              },
            ),
            Divider(height: 1),
            SettingItemWidget(
              title: language.lblPushNotification,
              leading: Icon(MaterialCommunityIcons.bell_outline),
              onTap: () async {},
              trailing: Transform.scale(
                scale: 0.8,
                child: CupertinoSwitch(
                  activeColor: primaryColor,
                  value: appStore.isNotificationOn,
                  onChanged: (v) {
                    appStore.setNotification(v);
                    setState(() {});
                  },
                ).withHeight(10),
              ),
            ),
            Divider(height: 1),
            SettingItemWidget(
              title: language.lblShare + " " + AppName,
              leading: Icon(Ionicons.share_social_outline),
              onTap: () {
                PackageInfo.fromPlatform().then((value) {
                  Share.share('Share $AppName app\n$playStoreBaseURL${value.packageName}');
                });
              },
            ),
            Divider(height: 1),
            SettingItemWidget(
              title: language.lblRateUs,
              leading: Icon(AntDesign.staro),
              onTap: () {
                PackageInfo.fromPlatform().then((value) {
                  String package = '';
                  if (isAndroid) package = value.packageName;
                  launchUrl(Uri.parse('${storeBaseURL()}$package'));
                });
              },
            ),
            Divider(height: 1).visible(getStringAsync(PRIVACY_POLICY_PREF).isNotEmpty),
            SettingItemWidget(
              title: language.lblPrivacyPolicy,
              leading: Icon(Ionicons.document_text_outline),
              onTap: () {
                WebViewScreen(mInitialUrl: getStringAsync(PRIVACY_POLICY_PREF), isAppBar: true).launch(context);
              },
            ).visible(!getStringAsync(PRIVACY_POLICY_PREF).isEmptyOrNull),
            Divider(height: 1).visible(getStringAsync(TERMS_AND_CONDITION_PREF).isNotEmpty),
            SettingItemWidget(
              title: language.lblTermsCondition,
              leading: Icon(Ionicons.document_text_outline),
              onTap: () async {
                WebViewScreen(mInitialUrl: getStringAsync(TERMS_AND_CONDITION_PREF), isAppBar: true).launch(context);
              },
            ).visible(!getStringAsync(TERMS_AND_CONDITION_PREF).isEmptyOrNull),
            Divider(height: 1),
            SettingItemWidget(
              title: language.lblAboutUs,
              leading: Icon(Ionicons.md_information_circle_outline),
              onTap: () {
                hideKeyboard(context);
                AboutUsScreen().launch(context, pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
              },
            ),
          ],
        ),
      ),
    );
  }
}
