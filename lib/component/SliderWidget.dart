
import 'package:flutter/material.dart';
import 'package:mighty_games/utils/Extensions/Widget_extensions.dart';
import 'package:mighty_games/utils/Extensions/context_extensions.dart';
import 'package:mighty_games/utils/appWidget.dart';
import '../model/DashboardResponse.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/text_styles.dart';

class SliderWidget extends StatefulWidget {
  static String tag = '/SliderWidget';
  final Function? onTap;
  final SliderResponse data;

  SliderWidget(this.data, {this.onTap});

  @override
  SliderWidgetState createState() => SliderWidgetState();
}

class SliderWidgetState extends State<SliderWidget> {
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
  Widget build(BuildContext context) {
    double w = context.width() * 0.75;
    double h = 190;
    return SizedBox(
      width: w,
      child: GestureDetector(
        onTap: () {
          widget.onTap!.call();
          setState(() {});
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            if (widget.data.imageUrl != null && widget.data.imageUrl!.isNotEmpty) cachedImage(widget.data.imageUrl, fit: BoxFit.fill, width: w, height: h).cornerRadiusWithClipRRect(12),
            Text(parseHtmlStringWidget(widget.data.title!.trim()), maxLines: 2, textAlign: TextAlign.center, style: primaryTextStyle(color: Colors.white)).paddingAll(16),
          ],
        ),
      ),
    ).paddingRight(8);
  }
}
