import 'package:sudo/models/models/section_models/language_models.dart';
import 'package:sudo/models/models/section_models/theme_models.dart';
import 'package:sudo/models/models/section_models/mode_models.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sudo/screens/basic/home/basic.dart';
import 'package:sudo/models/models/app_models.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:sudo/models/data/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert' as convert;
import 'dart:io';

class Loading extends StatefulWidget {
  @override
  LoadingState createState() => LoadingState();
}

class LoadingState extends State<Loading> {
  int appThemeNum;
  // ignore: unused_field
  String appMode, appLanguage, _appLanguage;
  // ignore: unused_field
  bool isDark,
      _isDark,
      _loadingCompeleted = true,
      _sleepTimeCompleted = false,
      inHome = true,
      firstEnter = false;
  Color buttonColor = Colors.white, buttonTextColor = Colors.blue;
  double buttonWidth = 200,
      buttonHeight = 60,
      containerHeight = 0,
      containerWidth = 0;
  List<Color> appTheme = [Colors.white, Colors.white];
  var appData, wallpaperData;

  @override
  void initState() {
    super.initState();
    getSets();
    getData();
    timer();
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    _isDark = brightnessValue == Brightness.dark;
    AppModels.systemUIOverlayStyle(_isDark, 'normal');

    return Scaffold(
        backgroundColor: _isDark ? Colors.black : Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Center(
                          child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        height: containerHeight,
                        width: containerWidth,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: appTheme),
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 50, right: 30, left: 30),
                          child: Image.asset(
                            'assets/icons/logo.png',
                            color: Colors.white,
                          ),
                        ),
                      )),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 475),
                          child: Text(
                            'Sudo Walpapers',
                            //colors: appTheme,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 27.0,
                                fontFamily: 'pacifico',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              _sleepTimeCompleted
                  ? _loadingCompeleted
                      ? Padding(
                          padding: const EdgeInsets.only(top: 500),
                          child: SpinKitThreeBounce(
                            color: Colors.white,
                            size: 25.0,
                          ),
                        )
                      : tryAgainButton()
                  : Text(
                      '',
                      style: TextStyle(fontSize: 0),
                    )
            ],
          ),
        ));
  }

  void getData() async {
    Map<String, String> requestHeaders = {
      'X-Master-Key':
          '\$2b\$10\$i/Us68p8zvnmxmI.gpuJve8H7q5JO3qTB2rOobIsR/SOKv/5SmDiG',
    };
    var url =
        Uri.https('api.jsonbin.io', '/v3/b/605c9e6f16da904608a13caa/latest');
    var response;
    try {
      response = await http
          .get(url, headers: requestHeaders)
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        appData = jsonResponse['record'];
        wallpaperData = jsonResponse['record'][0]['wallpapersData'];
        if (firstEnter == false) {
          Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: Basic(this),
              duration: Duration(milliseconds: 1000),
              reverseDuration: Duration(milliseconds: 1000),
            ),
          );
        } else if (firstEnter) {
          await updateUsersCount();
          Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: Basic(this),
              duration: Duration(milliseconds: 1000),
              reverseDuration: Duration(milliseconds: 1000),
            ),
          );
        }
      } else {
        print('Request failed with status: ${response.statusCode}.');
        setState(() {
          _loadingCompeleted = false;
        });
      }
    } catch (e) {
      setState(() {
        _loadingCompeleted = false;
      });
    }
  }

  updateUsersCount() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'X-Master-Key':
          '\$2b\$10\$i/Us68p8zvnmxmI.gpuJve8H7q5JO3qTB2rOobIsR/SOKv/5SmDiG',
    };
    appData[1]['usersCount'] = appData[1]['usersCount'] + 1;
    var url = Uri.https('api.jsonbin.io', '/v3/b/605c9e6f16da904608a13caa');
    var response;
    appData = convert.jsonEncode(appData);
    try {
      response = await http.put(url, headers: requestHeaders, body: appData);
      if (response.statusCode == 200) {
      } else {
        setState(() {
          _loadingCompeleted = false;
        });
      }
    } catch (error) {
      print(error);
      setState(() {
        _loadingCompeleted = false;
      });
    }
    appData = convert.jsonDecode(appData);
    print(response);
  }

  getSets() {
    getAppMode();
    getAppTheme();
    getAppLanguage();
    createAppFolder();
  }

  getAppMode() {
    ModeModels.getAppMode().then((_appMode) async {
      if (_appMode == 'default' || _appMode == 'firstEntery') {
        if (_appMode == 'firstEntery') {
          getStorageAccess();
          setState(() {
            firstEnter = true;
          });
        } else {
          setState(() {
            appMode = 'default';
          });
        }
        final Brightness brightnessValue =
            MediaQuery.of(context).platformBrightness;
        setState(() {
          isDark = brightnessValue == Brightness.dark;
        });
      } else if (_appMode == 'light') {
        setState(() {
          isDark = false;
        });
      } else if (_appMode == 'dark') {
        setState(() {
          isDark = true;
        });
      }
      setState(() {
        appMode = _appMode;
      });
      setState(() {
        _isDark = isDark;
      });
    });
  }

  getAppTheme() {
    ThemeModels.getAppTheme().then((_appTheme) {
      setState(() {
        appThemeNum = _appTheme;
        containerHeight = MediaQuery.of(context).size.height - 100.0;
        containerWidth = MediaQuery.of(context).size.width - 50.0;
      });
      if (_appTheme == 0) {
        appTheme = AppData.themeGradient1;
        buttonTextColor = AppData.themeColor1;
      } else if (_appTheme == 1) {
        appTheme = AppData.themeGradient2;
        buttonTextColor = AppData.themeColor2;
      } else if (_appTheme == 2) {
        appTheme = AppData.themeGradient3;
        buttonTextColor = AppData.themeColor3;
      } else if (_appTheme == 3) {
        appTheme = AppData.themeGradient4;
        buttonTextColor = AppData.themeColor4;
      } else if (_appTheme == 4) {
        appTheme = AppData.themeGradient5;
        buttonTextColor = AppData.themeColor5;
      } else if (_appTheme == 5) {
        appTheme = AppData.themeGradient6;
        buttonTextColor = AppData.themeColor6;
      } else if (_appTheme == 6) {
        appTheme = AppData.themeGradient7;
        buttonTextColor = AppData.themeColor7;
      } else if (_appTheme == 7) {
        if (_isDark) {
          appTheme = AppData.themeGradient8Dark;
        }
        if (!_isDark) {
          appTheme = AppData.themeGradient8Light;
        }
        buttonTextColor = AppData.themeColor8;
      }
    });
  }

  getAppLanguage() {
    LanguageModels.getAppLanguage().then((_appLanguage) {
      setState(() {
        appLanguage = _appLanguage;
      });
    });
  }

  timer() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      _sleepTimeCompleted = true;
    });
  }

  Widget tryAgainButton() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 500),
        child: InkWell(
          onHighlightChanged: (status) {
            if (status) {
              setState(() {
                buttonWidth = 190;
                buttonHeight = 55;
              });
            }
            if (!status) {
              setState(() {
                buttonWidth = 200;
                buttonHeight = 60;
              });
            }
          },
          onTap: () {
            setState(() {
              getData();
              _loadingCompeleted = true;
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 50),
            height: buttonHeight,
            width: buttonWidth,
            decoration: BoxDecoration(
                color: buttonColor, borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'خطا در برقراری ارتباط با سرور',
                  style: TextStyle(
                      color: buttonTextColor, fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'تلاش مجدد',
                      style: TextStyle(
                          color: buttonTextColor, fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.sync_outlined,
                      color: buttonTextColor,
                      size: 18,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  createAppFolder() async {
    final folderName = "SudoWallpapers";
    final path = Directory("storage/emulated/0/Pictures/$folderName");
    if ((await path.exists())) {
      // App folder exixts
    } else {
      path.create();
      print("App folder created");
    }
  }

  getStorageAccess() async {
    bool returnedStatus = false;
    String imgUrl =
        'https://androidwalls.net/wp-content/uploads/2015/03/Abstract%20Glass%20Shards%20Universe%20Space%20Colors%20Android%20Wallpaper.jpg';

    await GallerySaver.saveImage(imgUrl, albumName: 'sudoWallpapers/sudoImages')
        .then((bool success) {
      if (success) {
        setState(() {
          returnedStatus = true;
        });
      }
    });
    print(returnedStatus);
  }
}
