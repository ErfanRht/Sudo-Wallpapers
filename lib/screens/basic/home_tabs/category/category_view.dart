import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart' as GradientText;
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:sudo/models/data/app_data.dart';
import 'dart:convert' as convert;
import 'package:sudo/screens/basic/home/basic.dart';
import 'package:sudo/screens/shared/homeTabs_body/homeTabs_body.dart';

class CategoryView extends StatefulWidget {
  int categoryID;
  BasicState basicState;
  CategoryView(this.categoryID, this.basicState);
  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  int categoryID, wallpaperSelectedIndex, _popUpSpeed;
  List wallpapersData;
  var categoryJs;
  bool isDark, showDialog;
  String appMode, appLanguage;
  List<Color> appTheme;
  List category;
  double _pupUpPageWidth, _pupUpPageHeight;
  List<int> wallpapersCategoryID;

  @override
  void initState() {
    super.initState();
    isDark = widget.basicState.isDark;
    appLanguage = widget.basicState.appLanguage;
    appTheme = widget.basicState.gradientColor;
    categoryJs = AppData.wallpapersCategory;
    wallpapersData = widget.basicState.wallpaperData;
    category = convert.jsonDecode(categoryJs);
    categoryID = widget.categoryID;
    showDialog = false;
    _pupUpPageWidth = 0;
    _pupUpPageHeight = 0;
    _popUpSpeed = 250;
    wallpapersCategoryID = [];
    for (int i = 0; i < wallpapersData.length; i++) {
      if (wallpapersData[i]['category'] == category[categoryID]['name']) {
        wallpapersCategoryID.add(i);
      }
    }
  }

  void update_favorites_list(String ok) async {
    this.widget.basicState.setState(() {
      this.widget.basicState.update_favorites_list('');
    });
  }

  @override
  Widget build(BuildContext context) {
    print(wallpapersCategoryID);
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    isDark = brightnessValue == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 45,
        leading: Tooltip(
          message: 'بازگشت به صفحه اصلی',
          decoration: BoxDecoration(
              color: Colors.grey[700], borderRadius: BorderRadius.circular(10)),
          showDuration: Duration(milliseconds: 2000),
          child: Padding(
            padding: appLanguage == 'fa'
                ? EdgeInsets.only(right: 10)
                : EdgeInsets.only(left: 10),
            child: CircularGradientButton(
              child: Icon(
                Icons.arrow_back,
                size: 18,
              ),
              callback: () {
                Navigator.pop(context);
              },
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: appTheme),
              shadowColor: Gradients.rainbowBlue.colors.last.withOpacity(0.5),
            ),
          ),
        ),
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 1.0,
        iconTheme: IconThemeData(color: Colors.blue),
        title: GradientText.GradientText(
          text: category[categoryID]['name'],
          colors: appTheme,
          style: TextStyle(
              fontSize: appLanguage == 'fa' ? 20.0 : 15.0,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: wallpapersCategoryID.isNotEmpty
          ? Stack(
              children: [
                GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(wallpapersCategoryID.length, (index) {
                    return HomeTabsBody(
                        wallpapersCategoryID[index], this, 'category');
                  }),
                ),
                Center(child: showDialog ? pupUp() : nullWidget())
              ],
            )
          : Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 50,
                height: MediaQuery.of(context).size.height - 200,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 500),
                      child: Center(
                        child: GradientText.GradientText(
                          colors: appTheme,
                          text: 'لیست والپیپر های مورد علاقه شما خالی است.',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),

                    // Center(
                    //   child: Container(
                    //       margin: EdgeInsets.only(
                    //           top: MediaQuery.of(context).size.width /
                    //               3),
                    //       child: CircularProgressIndicator()),
                    // ),
                    // isDark
                    //     ? Image.asset(
                    //         'assets/images/404Error/404Error_dark.png')
                    //     : Image.asset(
                    //         'assets/images/404Error/404Error_light.jpg',
                    //       ),
                    Center(
                      child: UnDraw(
                        color: widget.basicState.appThemeColor,
                        illustration: UnDrawIllustration.empty,
                        placeholder:
                            CircularProgressIndicator(), //optional, default is the CircularProgressIndicator().
                        errorWidget: Icon(Icons.error_outline,
                            color: Colors.red,
                            size:
                                50), //optional, default is the Text('Could not load illustration!').
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  showPopUpPageManage(bool open, int index) async {
    if (open) {
      setState(() {
        showDialog = true;
        wallpaperSelectedIndex = index;
      });
      await Future.delayed(Duration(milliseconds: 20));
      setState(() {
        _pupUpPageHeight = MediaQuery.of(context).size.height;
        _pupUpPageWidth = MediaQuery.of(context).size.width;
      });
    }
    if (open == false) {
      setState(() {
        _pupUpPageHeight = 0;
        _pupUpPageWidth = 0;
      });
      await Future.delayed(Duration(milliseconds: _popUpSpeed));
      setState(() {
        showDialog = false;
        wallpaperSelectedIndex = index;
      });
    }
  }

  Widget pupUp() {
    return AnimatedContainer(
        duration: Duration(milliseconds: _popUpSpeed),
        width: _pupUpPageWidth,
        height: _pupUpPageHeight,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
              backgroundColor: isDark ? Colors.black87 : Colors.grey[100],
              child: Container(
                height: 530,
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: wallpapersData[wallpaperSelectedIndex]['img_url'],
                    fit: BoxFit.fitHeight,
                    height: 500,
                  ),
                ),
              ),
            ),
          ),
        ));
  }

// ignore: missing_return
  Widget nullWidget() {
    return Text(
      '',
      style: TextStyle(fontSize: 0),
    );
  }
}
