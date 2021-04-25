import 'package:sudo/screens/shared/settings/settings.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:sudo/screens/loading/loading.dart';
import 'package:sudo/models/models/section_models/theme_models.dart';
import 'package:sudo/screens/basic/home/basic.dart';
import 'package:sudo/models/data/app_data.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChangeTheme extends StatefulWidget {
  BasicState basicState;
  SettingsPageState settingsPage;
  ChangeTheme(this.basicState, this.settingsPage);
  @override
  ChangeThemeState createState() => ChangeThemeState();
}

class ChangeThemeState extends State<ChangeTheme> {
  int selectedRadio, beforeSelectedRadio, appThemeNum;
  bool _isDark;
  String appLanguage;
  List<Color> appTheme;
  Color appThemeColor;
  double gradientButtonWidth1 = 88,
      gradientButtonHeight1 = 35,
      gradientButtonWidth2 = 88,
      gradientButtonHeight2 = 35;
  @override
  void initState() {
    super.initState();
    _isDark = this.widget.basicState.isDark;
    appTheme = widget.basicState.widget.stateLoaded.appTheme;
    selectedRadio = widget.basicState.widget.stateLoaded.appThemeNum;
    beforeSelectedRadio = widget.basicState.widget.stateLoaded.appThemeNum;
    appThemeColor = widget.basicState.appThemeColor;
    appThemeNum = widget.basicState.widget.stateLoaded.appThemeNum;
    appLanguage = widget.basicState.appLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            height: 295.0,
            width: 330.0,
            decoration: BoxDecoration(
                color: _isDark ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: appLanguage == 'fa'
                      ? EdgeInsets.only(top: 15, right: 20)
                      : EdgeInsets.only(top: 15, left: 20),
                  child: Row(
                    mainAxisAlignment: appLanguage == 'fa'
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    children: [
                      Text(
                        appLanguage == 'fa'
                            ? 'تم برنامه رو انتخاب کنید:'
                            : ': Choose app theme',
                        style: TextStyle(
                            fontSize: appLanguage == 'fa' ? 22 : 17,
                            fontWeight: appLanguage == 'fa'
                                ? FontWeight.w500
                                : FontWeight.w700,
                            color: _isDark ? Colors.white : Colors.black),
                      ),
                    ],
                  ),
                ),
                appLanguage == 'fa'
                    ? Row(
                        children: [
                          Column(
                            children: [
                              buttons(0),
                              buttons(1),
                              buttons(2),
                              buttons(3),
                            ],
                          ),
                          Column(
                            children: [
                              buttons(4),
                              buttons(5),
                              buttons(6),
                              buttons(7),
                            ],
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              buttons(4),
                              buttons(5),
                              buttons(6),
                              buttons(7),
                            ],
                          ),
                          Column(
                            children: [
                              buttons(0),
                              buttons(1),
                              buttons(2),
                              buttons(3),
                            ],
                          ),
                        ],
                      ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: appLanguage == 'fa'
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                            ),
                            child: Center(
                              child: gradientButton(0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                            ),
                            child: gradientButton(1),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buttons(int radio) {
    List<Color> theme;
    Color themeColor;
    if (radio == 0) {
      theme = AppData.themeGradient1;
      themeColor = AppData.themeColor1;
    } else if (radio == 1) {
      theme = AppData.themeGradient2;
      themeColor = AppData.themeColor2;
    } else if (radio == 2) {
      theme = AppData.themeGradient3;
      themeColor = AppData.themeColor3;
    } else if (radio == 3) {
      theme = AppData.themeGradient4;
      themeColor = AppData.themeColor4;
    } else if (radio == 4) {
      theme = AppData.themeGradient5;
      themeColor = AppData.themeColor5;
    } else if (radio == 5) {
      theme = AppData.themeGradient6;
      themeColor = AppData.themeColor6;
    } else if (radio == 6) {
      theme = AppData.themeGradient7;
      themeColor = AppData.themeColor7;
    } else if (radio == 7) {
      theme = AppData.themeGradient8Light;
      themeColor = AppData.themeColor8;
    }
    appThemeNum = radio + 1;

    return Padding(
      padding: radio == 0
          ? EdgeInsets.only(top: 5)
          : radio == 4
              ? EdgeInsets.only(top: 5)
              : radio == 3
                  ? EdgeInsets.only(top: 5, bottom: 10)
                  : radio == 7
                      ? EdgeInsets.only(top: 5, bottom: 10)
                      : EdgeInsets.only(top: 5),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedRadio = radio;
            appTheme = theme;
            appThemeColor = themeColor;
          });
          widget.settingsPage.setState(() {
            widget.settingsPage.appTheme = appTheme;
          });
        },
        child: Row(
          mainAxisAlignment: appLanguage == 'fa'
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 10),
              width: 100,
              height: 40,
              margin: appLanguage == 'fa'
                  ? EdgeInsets.only(right: 20)
                  : EdgeInsets.only(left: 20),
              decoration: selectedRadio == radio
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: theme),
                    )
                  : BoxDecoration(
                      color: _isDark ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
              child: Row(
                mainAxisAlignment: appLanguage == 'fa'
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                children: [
                  appLanguage == 'fa'
                      ? Radio(
                          value: radio,
                          groupValue: selectedRadio,
                          onChanged: (radio) {
                            setState(() {
                              selectedRadio = radio;
                              appTheme = theme;
                              appThemeColor = themeColor;
                            });
                            widget.settingsPage.setState(() {
                              widget.settingsPage.appTheme = appTheme;
                            });
                          },
                          activeColor: Colors.white,
                        )
                      : Text(
                          '',
                          style: TextStyle(fontSize: 0),
                        ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedRadio = radio;
                          appTheme = theme;
                          appThemeColor = themeColor;
                        });
                      },
                      child: selectedRadio == radio
                          ? Container(
                              height: 30,
                              width: 30,
                              child: CircularGradientButton(
                                child: Icon(
                                  Icons.format_paint,
                                  size: 15,
                                  color: Colors.black,
                                ),
                                callback: () {
                                  setState(() {
                                    selectedRadio = radio;
                                    appTheme = theme;
                                  });
                                  widget.settingsPage.setState(() {
                                    widget.settingsPage.appTheme = appTheme;
                                  });
                                },
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [Colors.white, Colors.white]),
                                shadowColor: Gradients.rainbowBlue.colors.last
                                    .withOpacity(0.5),
                              ),
                            )
                          : Container(
                              height: 30,
                              width: 30,
                              child: CircularGradientButton(
                                child: Icon(
                                  Icons.format_paint,
                                  size: 15,
                                ),
                                callback: () {
                                  setState(() {
                                    selectedRadio = radio;
                                    appTheme = theme;
                                    appThemeColor = themeColor;
                                  });
                                  widget.settingsPage.setState(() {
                                    widget.settingsPage.appTheme = appTheme;
                                  });
                                },
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: theme),
                                shadowColor: Gradients.rainbowBlue.colors.last
                                    .withOpacity(0.5),
                              ),
                            )),
                  appLanguage == 'en'
                      ? Radio(
                          value: radio,
                          groupValue: selectedRadio,
                          onChanged: (radio) {
                            setState(() {
                              selectedRadio = radio;
                              appTheme = theme;
                              appThemeColor = themeColor;
                            });
                            widget.settingsPage.setState(() {
                              widget.settingsPage.appTheme = appTheme;
                            });
                          },
                          activeColor: Colors.white,
                        )
                      : Text(
                          '',
                          style: TextStyle(fontSize: 0),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onClick(String mode) {
    if (mode == 'cancel') {
      Navigator.pop(context);
      widget.settingsPage.setState(() {
        widget.settingsPage.appTheme =
            widget.basicState.widget.stateLoaded.appTheme;
      });
    } else if (mode == 'done') {
      ThemeModels.setAppTheme(selectedRadio).then((value) => null);

      if (beforeSelectedRadio == selectedRadio) {
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/loading');
      }
    }
  }

  gradientButton(int index) {
    String mode, text;
    if (index == 0) {
      mode = appLanguage == 'fa' ? 'cancel' : 'done';
      text = appLanguage == 'fa' ? 'لغو' : 'Done';
    } else if (index == 1) {
      mode = appLanguage == 'fa' ? 'done' : 'cancel';
      text = appLanguage == 'fa' ? 'تایید' : 'Cancel';
    }
    return InkWell(
        onHighlightChanged: (status) {
          if (status) {
            setState(() {
              if (index == 0) {
                gradientButtonHeight1 = gradientButtonHeight1 - 2;
                gradientButtonWidth1 = gradientButtonWidth1 - 5;
              }
              if (index == 1) {
                gradientButtonHeight2 = gradientButtonHeight2 - 2;
                gradientButtonWidth2 = gradientButtonWidth2 - 5;
              }
            });
          }
          if (!status) {
            setState(() {
              if (index == 0) {
                gradientButtonHeight1 = 35;
                gradientButtonWidth1 = 88;
              }
              if (index == 1) {
                gradientButtonHeight2 = 35;
                gradientButtonWidth2 = 88;
              }
            });
          }
        },
        onTap: () {
          onClick(mode);
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 150),
          height: index == 0 ? gradientButtonHeight1 : gradientButtonHeight2,
          width: index == 1 ? gradientButtonWidth2 : gradientButtonWidth1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: appTheme),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: this.widget.basicState.isDark
                    ? Colors.black
                    : Colors.blueGrey.withOpacity(0.5),
                spreadRadius: 1.75,
                blurRadius: 6,
                offset: Offset(0, 7), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: appLanguage == 'fa' ? 22 : 15,
                  color: _isDark ? Colors.black : Colors.white,
                  fontWeight:
                      appLanguage == 'fa' ? FontWeight.w500 : FontWeight.w700),
            ),
          ),
        ));
  }
}
