import 'package:easy_gradient_text/easy_gradient_text.dart' as GradientText;
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:sudo/models/data/app_data.dart';
import 'package:sudo/screens/basic/home/basic.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class AboutApp extends StatefulWidget {
  BasicState basicState;
  AboutApp(this.basicState);
  @override
  _AboutAppState createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  String appMode,
      appLanguage,
      instagramPage,
      webVersionLink,
      releaseDate,
      appVersion,
      appMarket;
  bool isDark;
  int appSize;
  List<Color> appTheme;
  Icon sectionIcon;
  double webVersionHeight, webVersionWidth;
  Color webVersionColor = Color(0xff32a060);
  FontWeight textWeight = FontWeight.w500;
  @override
  void initState() {
    super.initState();
    isDark = this.widget.basicState.isDark;
    appLanguage = this.widget.basicState.appLanguage;
    appTheme = this.widget.basicState.gradientColor;
    appVersion = AppData.appVersion;
    appSize = AppData.appSize;
    appLanguage == 'fa'
        ? appMarket = AppData.appMarket
        : appMarket = AppData.appMarketEnglish;
    releaseDate =
        widget.basicState.widget.stateLoaded.appData[3]['releaseDate'];
    instagramPage =
        widget.basicState.widget.stateLoaded.appData[5]['myInstagramPage'];
    if (instagramPage != 'null') {
      instagramPage = 'https://www.instagram.com/$instagramPage';
    }
    webVersionLink =
        widget.basicState.widget.stateLoaded.appData[4]['webVersion_link'];
    webVersionHeight = 40;
    webVersionWidth = 130;
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
          text: appLanguage == 'fa' ? 'درباره برنامه' : 'About App',
          colors: appTheme,
          style: TextStyle(
              fontSize: appLanguage == 'fa' ? 20.0 : 15.0,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) => sectionsContainer(index),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: UnDraw(
              color: widget.basicState.appThemeColor,
              illustration: UnDrawIllustration.mobile_application,
              placeholder:
                  CircularProgressIndicator(), //optional, default is the CircularProgressIndicator().
              errorWidget: Icon(Icons.error_outline,
                  color: Colors.red,
                  size:
                      50), //optional, default is the Text('Could not load illustration!').
            ),
          ),
          webVersionLink != 'comming_soon'
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: Duration(
                        milliseconds: 100,
                      ),
                      margin: EdgeInsets.only(top: 250),
                      height: webVersionHeight,
                      width: webVersionWidth,
                      decoration: BoxDecoration(
                          color: webVersionColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onHighlightChanged: (status) {
                          if (status) {
                            setState(() {
                              webVersionHeight = 35;
                              webVersionWidth = 130;
                              webVersionColor = Colors.blue;
                            });
                          }
                          if (!status) {
                            setState(() {
                              webVersionHeight = 40;
                              webVersionWidth = 140;
                              webVersionColor = Color(0xff32a060);
                            });
                          }
                        },
                        onTap: () {
                          if (webVersionLink == 'comming_soon') {
                          } else {
                            _launchURL(webVersionLink);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'نسخه وب',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.language,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Text(''),
        ],
      ),
    );
  }

  Widget sectionsContainer(int index) {
    EdgeInsets paddingValue;
    String firstText, secondText;
    if (index == 0) {
      paddingValue =
          EdgeInsets.only(top: 10, bottom: 5.5, left: 7.5, right: 7.5);
    } else {
      paddingValue = EdgeInsets.only(left: 7.5, right: 7.5, bottom: 5.5);
    }
    //////////////////////////////////////////////////////////////////////////////////
    if (index == 0) {
      if (appLanguage == 'fa') {
        firstText = 'سازنده :';
        secondText = 'عرفان رحمتی';
      } else {
        firstText = 'Creator :';
        secondText = 'Erfan Rahmati';
      }
      sectionIcon = Icon(
        Icons.code,
        color: Colors.white,
        size: 20,
      );
    } else if (index == 1) {
      if (appLanguage == 'fa') {
        firstText = 'نسخه برنامه :';
        secondText = appVersion;
      } else {
        firstText = 'AppVersion :';
        secondText = appVersion;
      }
      sectionIcon = Icon(
        Icons.verified_user_rounded,
        color: Colors.white,
        size: 20,
      );
    } else if (index == 2) {
      if (appLanguage == 'fa') {
        firstText = 'تاریخ انتشار  :';
        secondText = releaseDate;
      } else {
        firstText = 'ReleaseDate  :';
        secondText = releaseDate;
      }
      sectionIcon = Icon(
        Icons.date_range,
        color: Colors.white,
        size: 20,
      );
    } else if (index == 3) {
      if (appLanguage == 'fa') {
        firstText = 'حجم برنامه  :';
        secondText = '${appSize.toString()}مگابایت';
      } else {
        firstText = 'AppSize  :';
        secondText = '${appSize.toString()}Mb';
      }
      sectionIcon = Icon(
        Icons.data_usage,
        color: Colors.white,
        size: 20,
      );
    } else if (index == 4) {
      if (appLanguage == 'fa') {
        firstText = 'دانلود شده از :';
        secondText = appMarket;
      } else {
        firstText = 'Downloaded from  :';
        secondText = appMarket;
      }
      sectionIcon = Icon(
        Icons.get_app,
        color: Colors.white,
        size: 20,
      );
    }
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          if (instagramPage != 'null') {
            _launchURL(instagramPage);
          }
        }
      },
      child: Padding(
        padding: paddingValue,
        child: Container(
          padding: EdgeInsets.all(6.5),
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: appTheme),
          ),
          child: Padding(
            padding: appLanguage == 'fa'
                ? EdgeInsets.only(right: 5)
                : EdgeInsets.only(left: 10),
            child: Row(
              children: [
                sectionIcon,
                SizedBox(
                  width: 10,
                ),
                Text(
                  firstText,
                  style: TextStyle(
                      fontSize: appLanguage == 'fa' ? 18.0 : 13.5,
                      fontWeight: textWeight,
                      color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  secondText,
                  style: TextStyle(
                      fontSize: appLanguage == 'fa' ? 18.0 : 13.5,
                      fontWeight: textWeight,
                      fontFamily: appLanguage == 'fa' ? 'iran_sans' : '',
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
