import 'package:flutter/material.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/colors.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/shared_pref.dart';
import '../utils/Extensions/text_styles.dart';
import '../utils/appWidget.dart';
import '../utils/constant.dart';
import '../utils/images.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget mIcon(String icon, Function onCall) {
    return InkWell(
      onTap: () async {
        onCall.call();
      },
      child: Container(
        margin: EdgeInsets.only(left: 16),
        padding: EdgeInsets.all(10),
        child: Image.asset(icon, height: 35, width: 35),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(language.lblAboutUs, showBack: true),
      bottomNavigationBar: Container(
        height: 130,
        child: Column(
          children: [
            Text(language.lblFollowUs, style: boldTextStyle()),
            8.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                mIcon(ic_whatsApp, () {
                  var whatsappUrl = "whatsapp://send?phone=${getStringAsync(WHATSAPP)}";
                  launchUrl(Uri.parse(whatsappUrl));
                }).visible(!getStringAsync(WHATSAPP).isEmptyOrNull),
                mIcon(ic_insta, () {
                  launchUrl(Uri.parse(getStringAsync(INSTAGRAM)));
                }).visible(!getStringAsync(INSTAGRAM).isEmptyOrNull),
                mIcon(ic_twitter, () {
                  launchUrl(Uri.parse(getStringAsync(TWITTER)));
                }).visible(!getStringAsync(TWITTER).isEmptyOrNull),
                mIcon(ic_facebook, () {
                  launchUrl(Uri.parse(getStringAsync(FACEBOOK)));
                }).visible(!getStringAsync(FACEBOOK).isEmptyOrNull),
                InkWell(
                  onTap: () {
                    launchUrl(Uri.parse('tel://${getStringAsync(CONTACT_PREF).validate()}'));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 16),
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.call,
                      color: appStore.isDarkModeOn ? Colors.white : primaryColor,
                      size: 36,
                    ),
                  ),
                ).visible(!getStringAsync(CONTACT_PREF).isEmptyOrNull)
              ],
            ),
            8.height,
            Text(getStringAsync(COPYRIGHT), style: secondaryTextStyle(letterSpacing: 1.2), maxLines: 1).visible(!getStringAsync(COPYRIGHT).isEmptyOrNull),
            8.height,
          ],
        ),
      ),
      body: Center(
        child: FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (_, snap) {
              if (snap.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.all(16),
                        padding: EdgeInsets.all(12),
                        decoration: boxDecorationRoundedWithShadowWidget(6, backgroundColor: Colors.white, blurRadius: 5),
                        child: Image.asset(ic_logo, width: 120, height: 120)),
                    Text('${snap.data!.appName.validate()}', style: boldTextStyle(size: 20)),
                    SizedBox(height: 6),
                    Text(getStringAsync(ABOUT_US_PREF), style: secondaryTextStyle(), textAlign: TextAlign.center).paddingOnly(left: 16, right: 16),
                  ],
                );
              }
              return SizedBox();
            }),
      ),
    );
  }
}
