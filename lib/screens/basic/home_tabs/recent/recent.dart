import 'package:sudo/screens/shared/homeTabs_body/homeTabs_body.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sudo/screens/basic/home/basic.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

// ignore: must_be_immutable
class Recent extends StatefulWidget {
  BasicState basicState;
  Recent(this.basicState);
  @override
  RecentState createState() => RecentState();
}

class RecentState extends State<Recent> {
  double _pupUpPageWidth, _pupUpPageHeight;
  bool _isDark, showDialog;
  int wallpaperSelectedIndex, _popUpSpeed;
  // ignore: unused_field
  List _wallpaperData, wallpaperData;

  @override
  void initState() {
    super.initState();
    _isDark = this.widget.basicState.isDark;
    wallpaperData = this.widget.basicState.wallpaperData;
    wallpaperData = wallpaperData.reversed.toList();
    showDialog = false;
    _pupUpPageWidth = 0;
    _pupUpPageHeight = 0;
    _popUpSpeed = 250;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          GridView.count(
            crossAxisCount: 2,
            children: List.generate(wallpaperData.length, (index) {
              return HomeTabsBody(
                  wallpaperData.length - 1 - index, this, 'recent');
            }),
          ),
          Center(child: showDialog ? pupUp() : nullWidget())
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
      await Future.delayed(Duration(milliseconds: 20));
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
      await Future.delayed(Duration(milliseconds: _popUpSpeed));
      setState(() {
        showDialog = false;
        wallpaperSelectedIndex = index;
      });
    }
  }

  Widget pupUp() {
    return AnimatedContainer(
        duration: Duration(milliseconds: _popUpSpeed),
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
              backgroundColor: _isDark ? Colors.black87 : Colors.grey[100],
              child: Container(
                height: 530,
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: wallpaperData[wallpaperData.length -
                        1 -
                        wallpaperSelectedIndex]['img_url'],
                    fit: BoxFit.fitHeight,
                    height: 500,
                  ),
                ),
              ),
            ),
          ),
        ));
  }

// ignore: missing_return
  Widget nullWidget() {
    return Text(
      '',
      style: TextStyle(fontSize: 0),
    );
  }
}
