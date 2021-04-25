import 'package:easy_gradient_text/easy_gradient_text.dart' as GradientText;
import 'package:sudo/screens/shared/settings/sections/language/change_language.dart';
import 'package:sudo/screens/shared/settings/sections/mode/change_mode.dart';
import 'package:sudo/screens/shared/settings/sections/theme/change_theme.dart';
import 'package:sudo/screens/shared/settings/sections/cache/delete_cache.dart';
import 'package:sudo/screens/shared/settings/settings.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:sudo/screens/basic/home/basic.dart';
import 'package:sudo/models/data/app_data.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

// ignore: must_be_immutable
class SettingsButton extends StatefulWidget {
  BasicState basicState;
  SettingsPageState settingsPage;
  int buttonId;
  SettingsButton(this.buttonId, this.basicState, this.settingsPage);
  @override
  _SettingsButtonState createState() => _SettingsButtonState(buttonId);
}

class _SettingsButtonState extends State<SettingsButton> {
  var dataJs;
  bool _isDark;
  int buttonId;
  String appLanguage;
  List data;
  List<Color> appTheme;
  _SettingsButtonState(this.buttonId);
  @override
  void initState() {
    super.initState();
    appLanguage = widget.basicState.appLanguage;
    appLanguage == 'fa'
        ? dataJs = AppData.settingsButtons
        : dataJs = AppData.englishSettingsButtons;
    data = convert.jsonDecode(dataJs);
  }

  @override
  Widget build(BuildContext context) {
    appTheme = widget.settingsPage.appTheme;
    _isDark = widget.settingsPage.isDark;
    return Stack(
      children: [
        Container(
          color: _isDark ? Colors.black : Colors.white,
          child: Column(
            children: [
              SizedBox(height: buttonId != 0 ? 0 : 10),
              // ignore: deprecated_member_use
              FlatButton(
                splashColor: Colors.grey[200],
                onPressed: () => onTap(),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(
                          height: 30,
                          child: CircularGradientButton(
                            child: Icon(
                              buttonId == 0
                                  ? Icons.wb_sunny_rounded
                                  : buttonId == 1
                                      ? Icons.language
                                      : buttonId == 2
                                          ? Icons.format_paint
                                          : buttonId == 3
                                              ? Icons.cloud
                                              : Icons.help,
                              size: 15,
                            ),
                            callback: () => onTap(),
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: appTheme),
                            shadowColor: Gradients.rainbowBlue.colors.last
                                .withOpacity(0.5),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: GradientText.GradientText(
                            text: data[buttonId]['name'],
                            colors: appTheme,
                            style: TextStyle(
                                fontSize: appLanguage == 'fa' ? 18.0 : 13.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  onTap() async {
    if (buttonId == 0) {
      showDialog(
        context: context,
        builder: (context) {
          return ChangeMode(widget.basicState, widget.settingsPage);
        },
      );
    } else if (buttonId == 1) {
      showDialog(
        context: context,
        builder: (context) {
          return ChangeLanguage(widget.basicState, widget.settingsPage);
        },
      );
    } else if (buttonId == 2) {
      showDialog(
        context: context,
        builder: (context) {
          return ChangeTheme(widget.basicState, widget.settingsPage);
        },
      );
    } else if (buttonId == 3) {
      showDialog(
        context: context,
        builder: (context) {
          return DeleteCache(widget.basicState, widget.settingsPage);
        },
      );
    }
  }
}
