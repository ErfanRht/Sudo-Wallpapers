import 'package:easy_gradient_text/easy_gradient_text.dart' as GradientText;
import 'package:sudo/models/models/section_models/favorites_models.dart';
import 'package:sudo/screens/basic/home_tabs/most_view/most_view.dart';
import 'package:sudo/screens/basic/home_tabs/category/category.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sudo/screens/basic/home_tabs/recent/recent.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:sudo/screens/basic/favorites/favorites.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:sudo/screens/basic/drawer/drawer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sudo/models/models/app_models.dart';
import 'package:sudo/screens/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class Basic extends StatefulWidget {
  LoadingState stateLoaded;
  Basic(this.stateLoaded);
  @override
  BasicState createState() => BasicState();
}

class BasicState extends State<Basic> {
  // ignore: non_constant_identifier_names
  static List favorites_list;
  String appMode, appLanguage;
  bool isDark, openFavoritesFromHome = false, inHome;
  List<Color> gradientColor;
  var wallpaperData;
  // ignore: non_constant_identifier_names
  int section_selected = 0;
  Color appThemeColor;

  initState() {
    super.initState();
    appLanguage = widget.stateLoaded.appLanguage;
    appThemeColor = widget.stateLoaded.buttonTextColor;
    appMode = widget.stateLoaded.appMode;
    gradientColor = widget.stateLoaded.appTheme;
    isDark = widget.stateLoaded.isDark;
    wallpaperData = widget.stateLoaded.wallpaperData;
    inHome = widget.stateLoaded.inHome;
    getFavoritesList();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;

    appMode == 'default'
        ? setState(() => isDark = brightnessValue == Brightness.dark)
        // ignore: unnecessary_statements
        : null;
    AppModels.systemUIOverlayStyle(isDark, 'normal');

    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        appLanguage == 'fa'
            ? Locale(
                'fa',
              )
            : Locale(
                'en',
              )
      ],
      theme: ThemeData(
          fontFamily: 'iran_sans',
          brightness: isDark ? Brightness.dark : Brightness.light),
      title: 'Sudo Walpapers',
      debugShowCheckedModeBanner: false,
      home: DoubleBack(
        message: 'برای خروج دکمه بازگشت را دوباره فشار دهید. ',
        child: DefaultTabController(
          length: 4,
          initialIndex: 1,
          child: Scaffold(
            backgroundColor: isDark ? Colors.black : Colors.white,
            drawer: Drawer(child: HomeDrawer(this)),
            appBar: homeAppBar(),
            body: TabBarView(children: [
              Category(this),
              Recent(this),
              MostView(this),
              Container(),
            ]),
          ),
        ),
      ),
    );
  }

  Widget homeAppBar() {
    return AppBar(
      backgroundColor: isDark ? Colors.black : Colors.white,
      automaticallyImplyLeading: false,
      leadingWidth: 47.5,
      leading: Builder(
        builder: (context) => Padding(
          padding: appLanguage == 'fa'
              ? EdgeInsets.only(right: 10)
              : EdgeInsets.only(left: 10),
          child: CircularGradientButton(
            child: Icon(
              Icons.menu,
              size: 19,
            ),
            callback: () => Scaffold.of(context).openDrawer(),
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: gradientColor),
            shadowColor: Gradients.rainbowBlue.colors.last.withOpacity(0.5),
          ),
        ),
      ),
      centerTitle: true,
      title: GradientText.GradientText(
        text: 'Sudo Walpapers',
        colors: gradientColor,
        style: TextStyle(
            //color: Colors.blue,
            fontSize: 25.0,
            fontFamily: 'pacifico',
            fontWeight: FontWeight.w500),
      ),
      bottom: TabBar(
        indicatorColor: appThemeColor,
        labelColor: appThemeColor,
        isScrollable: true,
        tabs: [
          Tab(
            child: GradientText.GradientText(
              text: appLanguage == 'fa' ? 'دسته بندی ها' : 'Category',
              colors: gradientColor,
              style: TextStyle(
                  fontSize: appLanguage == 'fa' ? 16.0 : 14.0,
                  fontWeight: FontWeight.w800),
            ),
          ),
          Tab(
            child: GradientText.GradientText(
              text: appLanguage == 'fa' ? 'جدیدترین ها' : 'Recent',
              colors: gradientColor,
              style: TextStyle(
                  fontSize: appLanguage == 'fa' ? 16.0 : 14.0,
                  fontWeight: FontWeight.w800),
            ),
          ),
          Tab(
            child: GradientText.GradientText(
              text: appLanguage == 'fa' ? 'پر بازدیدترین ها' : 'Most visited',
              colors: gradientColor,
              style: TextStyle(
                  fontSize: appLanguage == 'fa' ? 16.0 : 14.0,
                  fontWeight: FontWeight.w800),
            ),
          ),
          Tab(
            child: GradientText.GradientText(
              text: appLanguage == 'fa' ? 'محبوب ترین ها' : 'Most popular',
              colors: gradientColor,
              style: TextStyle(
                  fontSize: appLanguage == 'fa' ? 16.0 : 14.0,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
      actions: [
        Container(
            height: 37.5,
            width: 37.5,
            margin: appLanguage == 'fa'
                ? EdgeInsets.only(left: 10)
                : EdgeInsets.only(right: 10),
            child: Tooltip(
              message: 'لیست مورد علاقه ها',
              decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(10)),
              showDuration: Duration(milliseconds: 2000),
              child: CircularGradientButton(
                child: Icon(
                  Icons.favorite,
                  size: 19,
                ),
                callback: () {
                  setState(() {
                    openFavoritesFromHome = true;
                  });
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.scale,
                      //alignment: Alignment.center,
                      childCurrent: Basic(widget.stateLoaded),

                      child: Favorites(this, widget.stateLoaded),
                      duration: Duration(milliseconds: 700),
                      reverseDuration: Duration(milliseconds: 700),
                    ),
                  );
                },
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: gradientColor),
                shadowColor: Gradients.rainbowBlue.colors.last.withOpacity(0.5),
              ),
            ))
      ],
    );
  }

  changeAppSection() async {
    await Future.delayed(Duration(milliseconds: 400));
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.rotate,
        childCurrent: Basic(widget.stateLoaded),
        child: Favorites(this, widget.stateLoaded),
        duration: Duration(milliseconds: 600),
        reverseDuration: Duration(milliseconds: 600),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void update_favorites_list(String ok) async {
    getFavoritesList();
  }

  getFavoritesList() {
    FavoritesData.getFavoritesData().then((response) {
      setState(() {
        favorites_list = response;
      });
    });
  }
}
