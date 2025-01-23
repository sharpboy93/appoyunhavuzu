import 'package:mighty_games/utils/Extensions/Colors.dart';
import 'package:mighty_games/utils/Extensions/Widget_extensions.dart';
import 'package:mighty_games/utils/Extensions/context_extensions.dart';
import 'package:mighty_games/utils/Extensions/decorations.dart';
import 'package:mighty_games/utils/appWidget.dart';
import 'package:flutter/material.dart';
import '../model/DashboardResponse.dart';
import '../utils/Extensions/text_styles.dart';

class CategoryItemWidget extends StatefulWidget {
  static String tag = '/CategoryItemWidget';
  final Category data;
  final Function? onTap;

  CategoryItemWidget(this.data, {this.onTap});

  @override
  CategoryItemWidgetState createState() => CategoryItemWidgetState();
}

class CategoryItemWidgetState extends State<CategoryItemWidget> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }
  bool getDeviceTypePhone() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    // print('${data.size.shortestSide}');
    return data.size.shortestSide < 600 ? true : false;
  }

  getItemCount() {
    if (getDeviceTypePhone()) {
      return 3;
    } else {
      return 5;
    }
  }
  getItemSpace() {
    if (getDeviceTypePhone()) {
      return 50;
    } else {
      return 68;
    }
  }

  getItemHeight() {
    if (getDeviceTypePhone()) {
      return 160.0;
    } else {
      return 180.0;
    }
  }
  @override
  Widget build(BuildContext context) {
    double w = (context.width() -  getItemSpace()) / getItemCount();
    double h = getItemHeight();
    return SizedBox(
      width: w,
      child: GestureDetector(
        onTap: (){
          widget.onTap!.call();
          setState(() {});
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            if (widget.data.logo != null && widget.data.logo!.isNotEmpty) cachedImage(widget.data.logo, fit: BoxFit.fill, width: w, height: h).cornerRadiusWithClipRRect(6),
            Container(
                height: h,
                width: w,
                decoration: boxDecorationWithShadowWidget(
                    gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [transparentColor,transparentColor, Colors.black87]), borderRadius: radius(6))),
            Text(widget.data.name!, style: boldTextStyle(color: Colors.white,size: 18), maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center).paddingSymmetric(horizontal: 8,vertical: 8),
          ],
        ),
      ),
    );
  }
}
