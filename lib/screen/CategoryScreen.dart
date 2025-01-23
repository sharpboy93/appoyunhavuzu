import '../../component/CategoryItemWidget.dart';
import '../../network/RestApis.dart';
import '../../screen/ViewAllScreen.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/appWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../main.dart';
import '../model/DashboardResponse.dart';

class CategoryScreen extends StatefulWidget {
  static String tag = '/CategoryScreen';

  @override
  CategoryScreenState createState() => CategoryScreenState();
}

class CategoryScreenState extends State<CategoryScreen> {
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
    return Scaffold(
      appBar: appBar(language.lblCategory),
      body: FutureBuilder<List<Category>>(
        future: getCategories(),
        builder: (_, snap) {
          if (snap.hasData) {
            return snap.data!.isNotEmpty
                ? SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      runSpacing: 8,
                      spacing: 8,
                      children: List.generate(
                        snap.data!.length,
                        (index) {
                          Category data = snap.data![index];
                          return AnimationConfiguration.staggeredGrid(
                            duration: Duration(milliseconds: 750),
                            columnCount: 1,
                            position: index,
                            child: CategoryItemWidget(data, onTap: () {
                              ViewAllScreen(title: data.name, categoryId: data.id.toInt(), isCategory: true).launch(context);
                            }),
                          );
                        },
                      ),
                    ),
                  )
                : noDataWidget(context);
          }
          return snapWidgetHelper(snap, loadingWidget: mProgress());
        },
      ),
    );
  }
}
