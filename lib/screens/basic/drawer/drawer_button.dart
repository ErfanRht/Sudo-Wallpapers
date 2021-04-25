import 'package:easy_gradient_text/easy_gradient_text.dart' as GradientText;
import 'package:sudo/screens/shared/about_app/about_app.dart';
import 'package:sudo/screens/basic/favorites/favorites.dart';
import 'package:sudo/screens/shared/settings/settings.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sudo/screens/basic/home/basic.dart';
import 'package:sudo/models/data/app_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'dart:convert' as convert;

// ignore: must_be_immutable
class DrawerButton extends StatefulWidget {
  int buttonID;
  dynamic parent;
  DrawerButton(this.buttonID, this.parent);
  @override
  _DrawerButtonState createState() => _DrawerButtonState(buttonID);
}

class _DrawerButtonState extends State<DrawerButton> {
  // ignore: non_constant_identifier_names
  int buttonID;
  var dataJs;
  List data;
  bool _isDark, inHome;
  String appLanguage, shareContent;
  Color buttonColor;
  List<Color> gradientColor;
  // ignore: non_constant_identifier_names
  _DrawerButtonState(this.buttonID);

  final Uri _emailLaunchUri = Uri(
      scheme: 'mailto', path: 'sudowallpapers@gmail.com', queryParameters: {});

  @override
  void initState() {
    super.initState();
    _isDark = widget.parent.isDark;
    gradientColor = widget.parent.gradientColor;
    appLanguage = widget.parent.appLanguage;
    inHome = widget.parent.inHome;
    if (buttonID == 0 || buttonID == 1) {
      if (buttonID == 0) {
        if (inHome) {
          buttonColor = _isDark ? Colors.grey[300] : Colors.grey[200];
        } else {
          buttonColor = _isDark ? Colors.black : Colors.white;
        }
      }
      if (buttonID == 1) {
        if (!inHome) {
          buttonColor = _isDark ? Colors.grey[300] : Colors.grey[200];
        } else {
          buttonColor = _isDark ? Colors.black : Colors.white;
        }
      }
    } else {
      buttonColor = _isDark ? Colors.black : Colors.white;
    }
    shareContent = widget.parent.widget.stateLoaded.appData[6]['shareContent'];
    if (appLanguage == 'fa') {
      dataJs = AppData.drawerButton;
    } else {
      dataJs = AppData.englishDrawerButton;
    }
    data = convert.jsonDecode(dataJs);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: buttonID == 0
          ? EdgeInsets.only(
              top: 10,
            )
          : null,
      color: buttonColor,
      //  buttonID == section_selected
      //     ? _isDark
      //         ? Colors.grey[300]
      //         : Colors.grey[200]
      //     : _isDark
      //         ? Colors.black
      //         : Colors.white,
      // ignore: deprecated_member_use
      child: FlatButton(
        splashColor: _isDark ? Colors.grey[300] : Colors.grey[200],
        onPressed: () {
          onClick();
        },
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  height: 30,
                  child: CircularGradientButton(
                    child: buttonIcon(),
                    callback: () {
                      onClick();
                    },
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: gradientColor),
                    shadowColor:
                        Gradients.rainbowBlue.colors.last.withOpacity(0.5),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: GradientText.GradientText(
                    text: data[buttonID]['name'],
                    colors: gradientColor,
                    style: TextStyle(
                        fontSize: appLanguage == 'fa' ? 17.0 : 12.0,
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
    );
  }

  Widget buttonIcon() {
    return Icon(
      buttonID == 0
          ? Icons.home
          : buttonID == 1
              ? Icons.favorite
              : buttonID == 2
                  ? Icons.comment
                  : buttonID == 3
                      ? Icons.headset_mic_rounded
                      : buttonID == 4
                          ? Icons.info
                          : buttonID == 5
                              ? Icons.share
                              : buttonID == 6
                                  ? Icons.settings
                                  : buttonID == 7
                                      ? Icons.exit_to_app
                                      : Icons.help,
      size: 15,
    );
  }

  onClick() async {
    if (buttonID == 0) {
      Navigator.pop(context);
      if (!inHome) {
        widget.parent.setState(() {
          widget.parent.inHome = true;
        });
        widget.parent.changeAppSection();
      }
    }
    if (buttonID == 1) {
      Navigator.pop(context);
      if (inHome) {
        widget.parent.setState(() {
          widget.parent.inHome = false;
        });
        widget.parent.changeAppSection();
      }
    }
    if (buttonID == 2) {
      // None yet
    }
    if (buttonID == 3) {
      Navigator.pop(context);
      await Future.delayed(Duration(milliseconds: 300));
      launch(_emailLaunchUri.toString());
    }
    if (buttonID == 4) {
      Navigator.pop(context);
      await Future.delayed(Duration(milliseconds: 250));
      Navigator.push(
        context,
        PageTransition(
          type: appLanguage == 'fa'
              ? PageTransitionType.rightToLeft
              : PageTransitionType.leftToRight,
          //alignment: Alignment.center,
          childCurrent: inHome
              ? Basic(this.widget.parent.widget.stateLoaded)
              : Favorites(widget.parent, widget.parent.widget.stateLoaded),
          child: AboutApp(widget.parent),
          duration: Duration(milliseconds: 300),
          reverseDuration: Duration(milliseconds: 300),
        ),
      );
    }
    if (buttonID == 5) {
      Navigator.pop(context);
      await Future.delayed(Duration(milliseconds: 250));
      shareApp(context);
    }
    if (buttonID == 6) {
      Navigator.pop(context);
      await Future.delayed(Duration(milliseconds: 250));
      Navigator.push(
        context,
        PageTransition(
          type: appLanguage == 'fa'
              ? PageTransitionType.rightToLeft
              : PageTransitionType.leftToRight,
          //alignment: Alignment.center,
          childCurrent: inHome
              ? Basic(this.widget.parent.widget.stateLoaded)
              : Favorites(widget.parent, widget.parent),
          child: SettingsPage(widget.parent),
          duration: Duration(milliseconds: 300),
          reverseDuration: Duration(milliseconds: 300),
        ),
      );
    }
    if (buttonID == 7) {
      SystemNavigator.pop();
    }

    // if (buttonID != section_selected) {
    //   if (buttonID == 0) {
    //     Navigator.pop(context);
    //     update_section_selected(buttonID);
    //   } else if (buttonID == 1) {
    //     Navigator.pop(context);
    //     update_section_selected(buttonID);
    //   } else if (buttonID == 2) {
    //   } else if (buttonID == 3) {
    //     Navigator.pop(context);
    //     await Future.delayed(Duration(milliseconds: 300));
    //     launch(_emailLaunchUri.toString());
    //   } else if (buttonID == 4) {
    //     Navigator.pop(context);
    //     await Future.delayed(Duration(milliseconds: 250));
    //     Navigator.push(
    //       context,
    //       PageTransition(
    //         type: appLanguage == 'fa'
    //             ? PageTransitionType.rightToLeft
    //             : PageTransitionType.leftToRight,
    //         //alignment: Alignment.center,
    //         childCurrent: section_selected == 0
    //             ? Basic(this.widget.basicState.widget.stateLoaded)
    //             : Favorites(widget.basicState),
    //         child: AboutApp(widget.basicState),
    //         duration: Duration(milliseconds: 300),
    //         reverseDuration: Duration(milliseconds: 300),
    //       ),
    //     );
    //   } else if (buttonID == 5) {
    //     Navigator.pop(context);
    //     await Future.delayed(Duration(milliseconds: 250));
    //     shareApp(context);
    //   } else if (buttonID == 6) {
    //     Navigator.pop(context);
    //     await Future.delayed(Duration(milliseconds: 250));
    //     Navigator.push(
    //       context,
    //       PageTransition(
    //         type: appLanguage == 'fa'
    //             ? PageTransitionType.rightToLeft
    //             : PageTransitionType.leftToRight,
    //         //alignment: Alignment.center,
    //         childCurrent: section_selected == 0
    //             ? Basic(this.widget.basicState.widget.stateLoaded)
    //             : Favorites(widget.basicState),
    //         child: SettingsPage(widget.basicState),
    //         duration: Duration(milliseconds: 300),
    //         reverseDuration: Duration(milliseconds: 300),
    //       ),
    //     );
    //   } else if (buttonID == 7) {
    //     SystemNavigator.pop();
    //   }
    // } else {
    //   Navigator.pop(context);
    // }
  }

  shareApp(BuildContext context) async {
    await Share.share(shareContent);
  }
}
