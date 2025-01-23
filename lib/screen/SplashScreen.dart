import '../../screen/DashboardScreen.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/constant.dart';
import '../../utils/images.dart';
import 'package:flutter/material.dart';
import '../utils/Extensions/text_styles.dart';

class SplashScreen extends StatefulWidget {
  static String tag = '/SplashScreen';

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await 2.seconds.delay;
    DashboardScreen().launch(context, isNewTask: true);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(12),
              decoration: boxDecorationRoundedWithShadowWidget(6, backgroundColor: Colors.white, blurRadius: 5),
              child: Image.asset(ic_logo, width: 120, height: 120)),
          Text(AppName, style: boldTextStyle(size: 26)),
        ],
      ).center(),
    );
  }
}
