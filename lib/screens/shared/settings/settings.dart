import 'package:easy_gradient_text/easy_gradient_text.dart' as GradientText;
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:sudo/models/models/section_models/mode_models.dart';
import 'package:sudo/screens/basic/home/basic.dart';
import 'package:sudo/screens/shared/settings/buttons/settings_button.dart';

class SettingsPage extends StatefulWidget {
  BasicState basicState;
  SettingsPage(this.basicState);
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  SettingsPageState() {
    getSets();
  }
  bool isDark, showCacheDeletedAlert;
  String appMode, appLanguage;
  List<Color> appTheme;

  getSets() {
    ModeModels.getAppMode().then((_appMode) {
      setState(() {
        appMode = _appMode;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    isDark = this.widget.basicState.isDark;
    appLanguage = this.widget.basicState.appLanguage;
    appTheme = widget.basicState.gradientColor;
    showCacheDeletedAlert = false;
  }

  @override
  Widget build(BuildContext context) {
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
          text: appLanguage == 'fa' ? 'تنظیمات' : 'Settings',
          colors: appTheme,
          style: TextStyle(
              fontSize: appLanguage == 'fa' ? 20.0 : 15.0,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) =>
                SettingsButton(index, widget.basicState, this),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: UnDraw(
              color: widget.basicState.appThemeColor,
              illustration: UnDrawIllustration.personal_settings,
              placeholder:
                  CircularProgressIndicator(), //optional, default is the CircularProgressIndicator().
              errorWidget: Icon(Icons.error_outline,
                  color: Colors.red,
                  size:
                      50), //optional, default is the Text('Could not load illustration!').
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              notiferAlert(showCacheDeletedAlert),
              SizedBox(
                height: 75,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget notiferAlert(bool active) {
    String text;
    if (appLanguage == 'fa') {
      text = 'حافظه موقت برنامه حذف شد.';
    } else {
      text = 'Application cache deleted.';
    }
    return Center(
      child: AnimatedOpacity(
        opacity: active ? 1.0 : 0.0,
        duration: Duration(milliseconds: 300),
        child: Stack(
          children: [
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width - 50,
              decoration: BoxDecoration(
                  color: isDark ? Colors.black : Colors.blue[800],
                  borderRadius: BorderRadius.circular(7)),
              child: Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(text,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: appLanguage == 'fa' ? 18 : 14,
                          fontWeight: appLanguage == 'fa'
                              ? FontWeight.normal
                              : FontWeight.w700))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
