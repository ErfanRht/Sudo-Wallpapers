import 'package:sudo/models/data/app_data.dart';
import 'package:sudo/screens/basic/drawer/drawer_button.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeDrawer extends StatefulWidget {
  dynamic parent;
  HomeDrawer(this.parent);
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  bool _isDark, inHome, isLastVersion, showNewUpdate;
  String _appLanguage, appVersion, lastVersion;
  // ignore: non_constant_identifier_names
  int section_selected;
  List<Color> appTheme;

  @override
  void initState() {
    super.initState();
    inHome = widget.parent.inHome;
    appTheme = widget.parent.gradientColor;
    _isDark = widget.parent.isDark;
    _appLanguage = widget.parent.appLanguage;
    appVersion = AppData.appVersion;
    showNewUpdate = false;
    lastVersion = widget.parent.widget.stateLoaded.appData[2]['lastVersion'];
    if (appVersion == lastVersion) {
      isLastVersion = true;
    } else if (appVersion != lastVersion) {
      isLastVersion = false;
      showNewUpdateManage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _isDark ? Colors.black : Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              logo(),
              line(EdgeInsets.only(top: 25)),
              DrawerButton(0, widget.parent),
              DrawerButton(1, widget.parent),
              line(EdgeInsets.only(top: 5)),
              !isLastVersion
                  ? newUpdate()
                  : Text(
                      '',
                      style: TextStyle(fontSize: 0),
                    ),
              otherText(),
              DrawerButton(2, widget.parent),
              DrawerButton(3, widget.parent),
              DrawerButton(4, widget.parent),
              DrawerButton(5, widget.parent),
              DrawerButton(6, widget.parent),
              DrawerButton(7, widget.parent),
            ],
          ),
        ),
      ),
    );
  }

  showNewUpdateManage() async {
    await Future.delayed(Duration(milliseconds: 50));
    setState(() {
      showNewUpdate = true;
    });
  }

  // Widgets
  Widget logo() {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: appTheme),
            borderRadius: BorderRadius.circular(35)),
        child: Image.asset('assets/icons/logo.png'),
      ),
    );
  }

  Widget line(EdgeInsets edgeInsets) {
    return Padding(
      padding: edgeInsets,
      child: Container(
        height: 1,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: appTheme),
            borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  Widget newUpdate() {
    return AnimatedOpacity(
      opacity: showNewUpdate ? 1 : 0,
      duration: Duration(milliseconds: 500),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.only(top: 7.5),
          height: 50,
          width: MediaQuery.of(context).size.width - 105,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: appTheme),
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              'بروزرسانی جدید موجود است، برای بروزرسانی ضربه بزنید.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget otherText() {
    return Row(
      children: [
        Padding(
          padding: _appLanguage == 'fa'
              ? const EdgeInsets.only(
                  right: 15,
                  top: 5,
                )
              : const EdgeInsets.only(
                  left: 15,
                  top: 5,
                ),
          child: GradientText(
            text: _appLanguage == 'fa' ? 'بیشتر' : 'Other',
            colors: appTheme,
            style: TextStyle(
                //color: Colors.blue,
                fontSize: _appLanguage == 'fa' ? 17.0 : 12.0,
                //fontFamily: 'pacifico',
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
