import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/appWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../main.dart';
import '../model/DashboardResponse.dart';
import '../utils/Extensions/text_styles.dart';
import '../../utils/Extensions/string_extensions.dart';

class ItemWidget extends StatefulWidget {
  static String tag = '/ItemWidget';
  final Function? onTap;
  final bool? isFavourite;
  final bool? isGrid;
  final Category data;

  ItemWidget(this.data, {this.onTap, this.isFavourite = false, this.isGrid = false});

  @override
  ItemWidgetState createState() => ItemWidgetState();
}

class ItemWidgetState extends State<ItemWidget> {
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
    double w = (context.width() - getItemSpace()) / getItemCount();
    double h = getItemHeight();
    return Observer(builder: (context) {
      return SizedBox(
        width: w,
        child: GestureDetector(
          onTap: () {
            widget.onTap!.call();
            setState(() {});
          },
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  if (widget.data.logo != null && widget.data.logo!.isNotEmpty) cachedImage(widget.data.logo, fit: BoxFit.fill, width: w, height: h).cornerRadiusWithClipRRect(6),
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: boxDecorationWithShadowWidget(
                        backgroundColor: context.cardColor.withOpacity(0.8), borderRadius: BorderRadius.only(bottomRight: Radius.circular(6), topLeft: Radius.circular(6))),
                    child: Icon(
                      wishListStore.isItemInWishlist(widget.data.id.toInt()) == false ? MaterialIcons.favorite_border : MaterialIcons.favorite,
                      color: wishListStore.isItemInWishlist(widget.data.id.toInt()) == false ? context.iconColor : Colors.red,
                      size: 20,
                    ).onTap(() {
                      Category mWishListModel = Category();
                      mWishListModel = widget.data;
                      wishListStore.addToWishList(mWishListModel);
                      setState(() {});
                    }),
                  ),
                ],
              ),
              8.height,
              Text(parseHtmlStringWidget(widget.data.name!.trim()), textAlign: TextAlign.center, style: primaryTextStyle()).paddingSymmetric(horizontal: 4),
            ],
          ),
        ),
      );
    });
  }
}
