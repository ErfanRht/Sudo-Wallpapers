import 'package:flutter/material.dart';

class AppData {
  static String appVersion = '1.0.1';
  static int appSize = 21;
  static String appMarket = 'کافه بازار';
  static String appMarketEnglish = 'Cafe Bazaar';
  // wallpapersCategory:
  static var wallpapersCategory = """[
    {"id":0,"name":"نقاب","img_url":"neghab"}
   ,{"id":1,"name":"حیوانات","img_url":"heyvanat"}
   ,{"id":2,"name":"ماشین","img_url":"mashin"}
   ,{"id":3,"name":"شهر","img_url":"shahr"}
   ,{"id":4,"name":"طبیعت","img_url":"tabiat"}
   ,{"id":5,"name":"فانتزی","img_url":"fantasy"}
   ,{"id":6,"name":"هنر","img_url":"honar"}
   ,{"id":7,"name":"پس زمینه","img_url":"background"}
   ,{"id":8,"name":"تکنولوژی","img_url":"technology"}
   ,{"id":9,"name":"کارتون","img_url":"cartoon"}
   ,{"id":10,"name":"دارک","img_url":"dark"}
  ]""";
  static var englishWallpapersCategory = """[
    {"id":0,"name":"Mask","img_url":"neghab"}
   ,{"id":1,"name":"Animal","img_url":"heyvanat"}
   ,{"id":2,"name":"Car","img_url":"mashin"}
   ,{"id":3,"name":"City","img_url":"shahr"}
   ,{"id":4,"name":"Nature","img_url":"tabiat"}
   ,{"id":5,"name":"Fantasy","img_url":"fantasy"}
   ,{"id":6,"name":"Art","img_url":"honar"}
   ,{"id":7,"name":"Background","img_url":"background"}
   ,{"id":8,"name":"Technology","img_url":"technology"}
   ,{"id":9,"name":"cartoon","img_url":"cartoon"}
   ,{"id":10,"name":"Dark","img_url":"dark"}
  ]""";

  // drawerButton:
  static var drawerButton = """[
    {"id":0,"name":"صفحه اصلی"}
   ,{"id":1,"name":"مورد علاقه ها"}
   ,{"id":2,"name":"ثبت نظر"}
   ,{"id":3,"name":"پشتیبانی"}
   ,{"id":4,"name":"درباره برنامه"}
   ,{"id":5,"name":"اشتراک گذاری"}
   ,{"id":6,"name":"تنظیمات"}
   ,{"id":7,"name":"خروج"}
  ]""";
  static var englishDrawerButton = """[
    {"id":0,"name":"Home"}
   ,{"id":1,"name":"Favorites"}
   ,{"id":2,"name":"Rate"}
   ,{"id":3,"name":"Support"}
   ,{"id":4,"name":"AboutApp"}
   ,{"id":5,"name":"Share"}
   ,{"id":6,"name":"Settings"}
   ,{"id":7,"name":"Exit"}
  ]""";

  //settingButton:
  static var settingsButtons = """[
    {"id":0,"name":"حالت برنامه"}
   ,{"id":1,"name":"زبان برنامه"}
   ,{"id":2,"name":"تم برنامه"}
   ,{"id":3,"name":"حافظه موقت"}
  ]""";
  static var englishSettingsButtons = """[
    {"id":0,"name":"AppMode"}
   ,{"id":1,"name":"AppLanguage"}
   ,{"id":2,"name":"AppTheme"}
   ,{"id":3,"name":"AppCache"}
  ]""";

  // themeGradients:
  static List<Color> themeGradient1 = [
    Colors.blue,
    Colors.purple,
  ];
  static List<Color> themeGradient2 = [
    Colors.orange,
    Colors.redAccent,
  ];
  static List<Color> themeGradient3 = [
    Color(0xff32a060),
    Colors.blue,
  ];
  static List<Color> themeGradient4 = [
    Color(0xff073a37),
    Color(0xff607262),
  ];
  static List<Color> themeGradient5 = [
    Colors.pink,
    Colors.purple,
  ];
  static List<Color> themeGradient6 = [
    Color(0xffff29e6),
    Color(0xffac47ff),
  ];
  static List<Color> themeGradient7 = [
    Color(0xffF58529),
    Color(0xffDD2A7B),
    Color(0xff8134AF),
    Color(0xff515BD4)
  ];
  static List<Color> themeGradient8Light = [
    Color(0xfff5e6bd),
    Color(0xff7a6446),
    Color(0xffac9167),
    //Color(0xffffebd4),
    Color(0xff8c6d3d)
  ];
  static List<Color> themeGradient8Dark = [
    Color(0xfff5e6bd),
    Color(0xff7a6446),
    Color(0xffac9167),
    Color(0xffffebd4),
    Color(0xff8c6d3d)
  ];

  // themeColors:
  static Color themeColor1 = Colors.blue;
  static Color themeColor2 = Colors.orange;
  static Color themeColor3 = Color(0xff32a060);
  static Color themeColor4 = Color(0xff607262);
  static Color themeColor5 = Colors.pinkAccent;
  static Color themeColor6 = Color(0xffff29e6);
  static Color themeColor7 = Color(0xffDD2A7B);
  static Color themeColor8 = Color(0xff8c6d3d);
}
