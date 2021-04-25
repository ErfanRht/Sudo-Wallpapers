import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sudo/screens/basic/home_tabs/recent/recent.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sudo/screens/shared/wallpaper_view/wallpaper_view.dart';

// ignore: must_be_immutable
class HomeTabsBody extends StatefulWidget {
  int index;
  dynamic parentClass;
  String parentClassName;
  HomeTabsBody(this.index, this.parentClass, this.parentClassName);
  @override
  _HomeTabsBodyState createState() => _HomeTabsBodyState();
}

class _HomeTabsBodyState extends State<HomeTabsBody> {
  // ignore: unused_field
  bool _compeleteLoading;
  int index, counter;
  Color appThemeColor;
  @override
  void initState() {
    super.initState();
    _compeleteLoading = false;
    index = widget.index;
    appThemeColor =
        widget.parentClass.widget.basicState.widget.stateLoaded.buttonTextColor;
    counter = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(5),
      child: GestureDetector(
        onLongPressStart: (details) {
          // _compeleteLoading
          //     ?
          widget.parentClass.showPopUpPageManage(true, index);
          // : null;
        },
        onLongPressEnd: (details) {
          // _compeleteLoading
          //     ?
          widget.parentClass.showPopUpPageManage(false, index);
          // : null;
        },
        onTap: () {
          widget.parentClass.showDialog
              // ignore: unnecessary_statements
              ? null
              : Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    childCurrent:
                        Recent(this.widget.parentClass.widget.basicState),
                    child: WalpaperView(
                        index,
                        this.widget.parentClass.widget.basicState,
                        widget.parentClassName),
                    duration: Duration(milliseconds: 600),
                    reverseDuration: Duration(milliseconds: 600),
                  ));
        },
        child: Hero(
            tag: 'Walpapers${index.toString()}',
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                child: CachedNetworkImage(
                  imageUrl: this
                      .widget
                      .parentClass
                      .widget
                      .basicState
                      .wallpaperData[widget.index]['img_url'],
                  fit: BoxFit.fitWidth,
                  placeholder: (context, url) => SpinKitThreeBounce(
                    color: appThemeColor,
                    size: 20.0,
                  ),
                  errorWidget: (context, url, error) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'خطا در برقراری ارتباط با سرور',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w500),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'تلاش مجدد',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              Icons.sync_outlined,
                              color: Colors.blue,
                              size: 18,
                            )
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            )),
      ),
    );
  }
}
