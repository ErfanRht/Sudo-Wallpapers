import 'package:easy_gradient_text/easy_gradient_text.dart' as GradientText;
import 'package:flutter/material.dart';
import 'package:sudo/models/widgets/app_widgets.dart';
import 'package:sudo/models/models/section_models/language_models.dart';
import 'package:sudo/screens/basic/home/basic.dart';
import 'package:sudo/screens/shared/settings/settings.dart';

// ignore: must_be_immutable
class ChangeLanguage extends StatefulWidget {
  BasicState basicState;
  SettingsPageState settingsPage;
  ChangeLanguage(this.basicState, this.settingsPage);
  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  int selectedRadio = 0;
  bool _isDark;
  String appLanguage;
  List<Color> appTheme;
  Color appThemeColor;
  @override
  void initState() {
    super.initState();
    appTheme = this.widget.basicState.gradientColor;
    appThemeColor = this.widget.basicState.appThemeColor;
    _isDark = this.widget.basicState.isDark;
    appLanguage = this.widget.basicState.appLanguage;
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.basicState.appLanguage == 'fa') {
      selectedRadio = 0;
    }
    if (this.widget.basicState.appLanguage == 'en') {
      selectedRadio = 1;
    }
    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)), //this right here
          child: Container(
            height: 195.0,
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
                  child: Row(
                    mainAxisAlignment: appLanguage == 'fa'
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    children: [
                      Text(
                        appLanguage == 'fa'
                            ? 'زبان برنامه را انتخاب کنید:'
                            : ': Choose app language',
                        style: TextStyle(
                            fontSize: appLanguage == 'fa' ? 22 : 16,
                            fontWeight: appLanguage == 'fa'
                                ? FontWeight.w500
                                : FontWeight.w700,
                            color: _isDark ? Colors.white : Colors.black),
                      ),
                    ],
                  ),
                ),
                appLanguage == 'fa'
                    ? Padding(
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
                                  },
                                  activeColor: appThemeColor,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedRadio = 0;
                                    });
                                  },
                                  child: selectedRadio == 0
                                      ? GradientText.GradientText(
                                          text: 'فارسی',
                                          colors: appTheme,
                                          style: TextStyle(
                                              fontSize: 20.5,
                                              color: _isDark
                                                  ? Colors.white
                                                  : Colors.black),
                                        )
                                      : Text(
                                          'فارسی',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: _isDark
                                                  ? Colors.white
                                                  : Colors.black),
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
                                    });
                                  },
                                  activeColor: appThemeColor,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedRadio = 1;
                                    });
                                  },
                                  child: selectedRadio == 1
                                      ? GradientText.GradientText(
                                          text: 'انگلیسی',
                                          colors: appTheme,
                                          style: TextStyle(
                                              fontSize: 20.5,
                                              color: _isDark
                                                  ? Colors.white
                                                  : Colors.black),
                                        )
                                      : Text(
                                          'انگلیسی',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: _isDark
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                )
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
                      )
                    : Padding(
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
                                  },
                                  child: selectedRadio == 0
                                      ? GradientText.GradientText(
                                          text: 'Persian',
                                          colors: appTheme,
                                          style: TextStyle(
                                              fontSize: 15.5,
                                              fontWeight: FontWeight.w700,
                                              color: _isDark
                                                  ? Colors.white
                                                  : Colors.black),
                                        )
                                      : Text(
                                          'Persian',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: _isDark
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                ),
                                Radio(
                                  value: 0,
                                  groupValue: selectedRadio,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedRadio = value;
                                    });
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
                                    });
                                  },
                                  child: selectedRadio == 1
                                      ? GradientText.GradientText(
                                          text: 'English',
                                          colors: appTheme,
                                          style: TextStyle(
                                              fontSize: 15.5,
                                              fontWeight: FontWeight.w700,
                                              color: _isDark
                                                  ? Colors.white
                                                  : Colors.black),
                                        )
                                      : Text(
                                          'English',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: _isDark
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                ),
                                Radio(
                                  value: 1,
                                  groupValue: selectedRadio,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedRadio = value;
                                    });
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
                                              fontSize: 15,
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
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      this),
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

  void onClick(String mode) {
    if (mode == 'cancel') {
      Navigator.pop(context);
    } else if (mode == 'done') {
      if (selectedRadio == 0) {
        if (appLanguage != 'fa') {
          LanguageModels.setAppLanguage('fa').then((value) => null);
          this.widget.settingsPage.setState(() {
            this.widget.settingsPage.appLanguage = 'fa';
          });
          this.widget.basicState.setState(() {
            this.widget.basicState.appLanguage = 'fa';
          });
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/loading');
        } else {
          Navigator.pop(context);
        }
      } else if (selectedRadio == 1) {
        if (appLanguage != 'en') {
          LanguageModels.setAppLanguage('en').then((value) => null);
          this.widget.settingsPage.setState(() {
            this.widget.settingsPage.appLanguage = 'en';
          });
          this.widget.basicState.setState(() {
            this.widget.basicState.appLanguage = 'en';
          });
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/loading');
        } else {
          Navigator.pop(context);
        }
      }
    }
  }
}
