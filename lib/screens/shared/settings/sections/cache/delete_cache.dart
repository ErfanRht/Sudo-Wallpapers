import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:sudo/models/widgets/app_widgets.dart';
import 'package:sudo/screens/basic/home/basic.dart';
import 'package:sudo/screens/shared/settings/settings.dart';

class DeleteCache extends StatefulWidget {
  BasicState basicState;
  SettingsPageState settingsPageState;
  DeleteCache(this.basicState, this.settingsPageState);
  @override
  _DeleteCacheState createState() => _DeleteCacheState();
}

class _DeleteCacheState extends State<DeleteCache> {
  bool _isDark;
  String appLanguage;
  List<Color> appTheme;
  @override
  void initState() {
    super.initState();
    appTheme = this.widget.basicState.gradientColor;
    _isDark = this.widget.basicState.isDark;
    appLanguage = this.widget.basicState.appLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)), //this right here
          child: Container(
            height: appLanguage == 'fa' ? 150.0 : 115,
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
                      appLanguage == 'fa'
                          ? Container(
                              width: 290,
                              child: Text(
                                'آیا مایل به حذف حافظه موقت برنامه هستید؟',
                                style: TextStyle(
                                    fontSize: appLanguage == 'fa' ? 22 : 17,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        _isDark ? Colors.white : Colors.black),
                              ),
                            )
                          : Text(
                              '? Do you want to clear app cache',
                              style: TextStyle(
                                  fontSize: appLanguage == 'fa' ? 22 : 16,
                                  fontWeight: FontWeight.w700,
                                  color: _isDark ? Colors.white : Colors.black),
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: appLanguage == 'fa'
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: appLanguage == 'fa'
                          ? EdgeInsets.only(
                              left: 10,
                            )
                          : EdgeInsets.only(
                              right: 10,
                            ),
                      child: Center(
                        child: gradientButton(
                            appLanguage == 'fa' ? 'no' : 'yes',
                            35,
                            88,
                            Text(
                              appLanguage == 'fa' ? 'خیر' : 'Yes',
                              style: TextStyle(
                                  fontSize: appLanguage == 'fa' ? 22 : 14,
                                  color: Colors.white,
                                  fontWeight: appLanguage == 'fa'
                                      ? FontWeight.w500
                                      : FontWeight.w700),
                            ),
                            this),
                      ),
                    ),
                    Padding(
                      padding: appLanguage == 'fa'
                          ? EdgeInsets.only(
                              left: 15,
                            )
                          : EdgeInsets.only(
                              right: 15,
                            ),
                      child: gradientButton(
                          appLanguage == 'fa' ? 'yes' : 'no',
                          35,
                          88,
                          Text(
                            appLanguage == 'fa' ? 'بله' : 'No',
                            style: TextStyle(
                                fontSize: appLanguage == 'fa' ? 22 : 14,
                                color: Colors.white,
                                fontWeight: appLanguage == 'fa'
                                    ? FontWeight.w500
                                    : FontWeight.w700),
                          ),
                          this),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> onClick(String mode) async {
    if (mode == 'no') {
      Navigator.pop(context);
    } else if (mode == 'yes') {
      await DefaultCacheManager().emptyCache();
      Navigator.pop(context);
      widget.settingsPageState.setState(() {
        widget.settingsPageState.showCacheDeletedAlert = true;
      });
      await Future.delayed(Duration(milliseconds: 2000));
      widget.settingsPageState.setState(() {
        widget.settingsPageState.showCacheDeletedAlert = false;
      });
    }
  }
}
