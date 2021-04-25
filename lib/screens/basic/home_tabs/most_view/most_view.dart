import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sudo/screens/basic/home/basic.dart';
import 'package:sudo/screens/shared/homeTabs_body/homeTabs_body.dart';

class MostView extends StatefulWidget {
  BasicState basicState;
  MostView(this.basicState);
  @override
  MostViewState createState() => MostViewState();
}

class MostViewState extends State<MostView> {
  // ignore: unused_field
  double _pupUpPageWidth, _pupUpPageHeight;
  bool _isDark, showDialog;
  int wallpaperSelectedIndex;
  List wallpaperData;

  @override
  void initState() {
    super.initState();
    _isDark = this.widget.basicState.isDark;
    wallpaperData = this.widget.basicState.wallpaperData;
    showDialog = false;
    _pupUpPageWidth = 0;
    _pupUpPageHeight = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          GridView.count(
            crossAxisCount: 2,
            children: List.generate(wallpaperData.length, (index) {
              return HomeTabsBody(index, this, 'most view');
            }),
          ),
          Center(
            child: showDialog
                ? AnimatedContainer(
                    duration: Duration(milliseconds: 130),
                    width: _pupUpPageWidth,
                    height: _pupUpPageHeight,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5.0,
                        sigmaY: 5.0,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                          backgroundColor:
                              _isDark ? Colors.black87 : Colors.grey[100],
                          child: Container(
                            height: 530,
                            child: Center(
                              child: CachedNetworkImage(
                                imageUrl: wallpaperData[wallpaperSelectedIndex]
                                    ['img_url'],
                                fit: BoxFit.fitHeight,
                                height: 500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ))
                : Text(
                    '',
                    style: TextStyle(fontSize: 0),
                  ),
          )
        ],
      ),
    );
  }

  showPopUpPageManage(bool open, int index) async {
    if (open) {
      setState(() {
        showDialog = true;
        wallpaperSelectedIndex = index;
      });
      await Future.delayed(Duration(milliseconds: 100));
      setState(() {
        _pupUpPageHeight = MediaQuery.of(context).size.height;
        _pupUpPageWidth = MediaQuery.of(context).size.width;
      });
    }
    if (open == false) {
      setState(() {
        _pupUpPageHeight = 0;
        _pupUpPageWidth = 0;
      });
      await Future.delayed(Duration(milliseconds: 100));
      setState(() {
        showDialog = false;
        wallpaperSelectedIndex = index;
      });
    }
  }
}
