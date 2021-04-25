import 'package:easy_gradient_text/easy_gradient_text.dart' as GradientText;
import 'package:sudo/models/models/section_models/mode_models.dart';
import 'package:sudo/screens/shared/settings/settings.dart';
import 'package:sudo/models/widgets/app_widgets.dart';
import 'package:sudo/models/models/app_models.dart';
import 'package:sudo/screens/basic/home/basic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class ChangeMode extends StatefulWidget {
  BasicState basicState;
  SettingsPageState settingsPage;
  ChangeMode(this.basicState, this.settingsPage);
  @override
  ChangeModeState createState() => ChangeModeState();
}

class ChangeModeState extends State<ChangeMode> {
  List<Color> appTheme;
  int selectedRadio = 0;
  bool _isDark;
  Color appThemeColor;
  String appLanguage;
  @override
  void initState() {
    super.initState();
    appTheme = widget.basicState.gradientColor;
    appThemeColor = widget.basicState.appThemeColor;
    appLanguage = widget.basicState.appLanguage;
    if (widget.basicState.appMode == 'default') {
      selectedRadio = 0;
    }
    if (widget.basicState.appMode == 'light') {
      selectedRadio = 1;
    }
    if (widget.basicState.appMode == 'dark') {
      selectedRadio = 2;
    }
    _isDark = widget.basicState.isDark;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            height: 245.0,
            width: 330.0,
            decoration: BoxDecoration(
                color: _isDark ? Colors.black87 : Colors.white,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: appLanguage == 'fa'
                      ? EdgeInsets.only(top: 15, right: 20)
                      : EdgeInsets.only(top: 15, left: 20),
                  child: appLanguage == 'fa'
                      ? Row(
                          children: [
                            Text(
                              'حالت برنامه رو انتخاب کنید:',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: _isDark ? Colors.white : Colors.black),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              ': Choose app mode',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: _isDark ? Colors.white : Colors.black),
                            ),
                          ],
                        ),
                ),
                radios(),
              ],
            ),
          ),
        );
      },
    );
  }

  void onClick(String mode) {
    if (mode == 'cancel') {
      Navigator.pop(context);
    } else if (mode == 'done') {
      changeMode('done', selectedRadio);
      Navigator.pop(context);
    }
  }

  changeMode(String work, int mode) {
    if (work == 'apply') {
      if (mode == 0) {
        final Brightness brightnessValue =
            MediaQuery.of(context).platformBrightness;
        setState(() {
          _isDark = brightnessValue == Brightness.dark;
        });
        widget.settingsPage.setState(() {
          widget.settingsPage.isDark = _isDark;
          _isDark
              ? widget.settingsPage.appMode = 'dark'
              : widget.settingsPage.appMode = 'light';
        });
      }
      if (mode == 1) {
        widget.settingsPage.setState(() {
          widget.settingsPage.isDark = false;
          widget.settingsPage.appMode = 'light';
        });
      }
      if (mode == 2) {
        widget.settingsPage.setState(() {
          widget.settingsPage.isDark = true;
          widget.settingsPage.appMode = 'dark';
        });
      }
    }
    if (work == 'done') {
      if (mode == 0) {
        ModeModels.setAppMode('default').then((value) => null);
        final Brightness brightnessValue =
            MediaQuery.of(context).platformBrightness;
        _isDark = brightnessValue == Brightness.dark;
        widget.basicState.setState(() {
          widget.basicState.isDark = _isDark;
          widget.basicState.appMode = 'default';
        });
      }
      if (mode == 1) {
        ModeModels.setAppMode('light').then((value) => null);
        widget.basicState.setState(() {
          widget.basicState.isDark = false;
          widget.basicState.appMode = 'light';
        });
      }
      if (mode == 2) {
        ModeModels.setAppMode('dark').then((value) => null);
        widget.basicState.setState(() {
          widget.basicState.isDark = true;
          widget.basicState.appMode = 'dark';
        });
      }
    }
    AppModels.systemUIOverlayStyle(_isDark, 'normal');
  }

  Widget radios() {
    if (appLanguage == 'fa') {
      return Padding(
        padding: const EdgeInsets.only(right: 4),
        child: Column(
          children: [
            Row(
              children: [
                Radio(
                  value: 0,
                  groupValue: selectedRadio,
                  onChanged: (value) {
                    setState(() {
                      selectedRadio = value;
                    });
                    changeMode('apply', 0);
                  },
                  activeColor: appThemeColor,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedRadio = 0;
                    });
                    changeMode('apply', 0);
                  },
                  child: selectedRadio == 0
                      ? GradientText.GradientText(
                          text: 'پیش فرض دستگاه',
                          colors: appTheme,
                          style: TextStyle(
                              fontSize: 17.5,
                              color: _isDark ? Colors.white : Colors.black),
                        )
                      : Text(
                          'پیش فرض دستگاه',
                          style: TextStyle(
                              fontSize: 17,
                              color: _isDark ? Colors.white : Colors.black),
                        ),
                )
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: selectedRadio,
                  onChanged: (value) {
                    setState(() {
                      selectedRadio = value;
                      _isDark = false;
                    });
                    changeMode('apply', 1);
                  },
                  activeColor: appThemeColor,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedRadio = 1;
                      _isDark = false;
                    });
                    changeMode('apply', 1);
                  },
                  child: selectedRadio == 1
                      ? GradientText.GradientText(
                          text: 'روشن',
                          colors: appTheme,
                          style: TextStyle(
                              fontSize: 17.5,
                              color: _isDark ? Colors.white : Colors.black),
                        )
                      : Text(
                          'روشن',
                          style: TextStyle(
                              fontSize: 17,
                              color: _isDark ? Colors.white : Colors.black),
                        ),
                )
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 2,
                  groupValue: selectedRadio,
                  onChanged: (value) {
                    setState(() {
                      selectedRadio = value;
                      _isDark = true;
                    });
                    changeMode('apply', 2);
                  },
                  activeColor: appThemeColor,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedRadio = 2;
                      _isDark = true;
                    });
                    changeMode('apply', 2);
                  },
                  child: selectedRadio == 2
                      ? GradientText.GradientText(
                          text: 'تاریک',
                          colors: appTheme,
                          style: TextStyle(
                              fontSize: 17.5,
                              color: _isDark ? Colors.white : Colors.black),
                        )
                      : Text(
                          'تاریک',
                          style: TextStyle(
                              fontSize: 17,
                              color: _isDark ? Colors.white : Colors.black),
                        ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Center(
                    child: gradientButton(
                        'cancel',
                        35,
                        88,
                        Text(
                          'لغو',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        this),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: gradientButton(
                      'done',
                      35,
                      88,
                      Text(
                        'تایید',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      this),
                ),
              ],
            )
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedRadio = 0;
                    });
                    changeMode('apply', 0);
                  },
                  child: selectedRadio == 0
                      ? GradientText.GradientText(
                          text: 'Default',
                          colors: appTheme,
                          style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: _isDark ? Colors.white : Colors.black),
                        )
                      : Text(
                          'Default',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: _isDark ? Colors.white : Colors.black),
                        ),
                ),
                Radio(
                  value: 0,
                  groupValue: selectedRadio,
                  onChanged: (value) {
                    setState(() {
                      selectedRadio = value;
                    });
                    changeMode('apply', 0);
                  },
                  activeColor: appThemeColor,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedRadio = 1;
                      _isDark = false;
                    });
                    changeMode('apply', 1);
                  },
                  child: selectedRadio == 1
                      ? GradientText.GradientText(
                          text: 'Light',
                          colors: appTheme,
                          style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: _isDark ? Colors.white : Colors.black),
                        )
                      : Text(
                          'Light',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: _isDark ? Colors.white : Colors.black),
                        ),
                ),
                Radio(
                  value: 1,
                  groupValue: selectedRadio,
                  onChanged: (value) {
                    setState(() {
                      selectedRadio = value;
                      _isDark = false;
                    });
                    changeMode('apply', 1);
                  },
                  activeColor: appThemeColor,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedRadio = 2;
                      _isDark = true;
                    });
                    changeMode('apply', 2);
                  },
                  child: selectedRadio == 2
                      ? GradientText.GradientText(
                          text: 'Dark',
                          colors: appTheme,
                          style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: _isDark ? Colors.white : Colors.black),
                        )
                      : Text(
                          'Dark',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: _isDark ? Colors.white : Colors.black),
                        ),
                ),
                Radio(
                  value: 2,
                  groupValue: selectedRadio,
                  onChanged: (value) {
                    setState(() {
                      selectedRadio = value;
                      _isDark = true;
                    });
                    changeMode('apply', 2);
                  },
                  activeColor: appThemeColor,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: Center(
                    child: gradientButton(
                        'done',
                        35,
                        88,
                        Text(
                          'Done',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        this),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 15,
                  ),
                  child: gradientButton(
                      'cancel',
                      35,
                      88,
                      Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                      this),
                ),
              ],
            )
          ],
        ),
      );
    }
  }
}
