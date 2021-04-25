import 'package:flutter/material.dart';
import 'package:sudo/models/data/app_data.dart';
import 'package:sudo/screens/shared/wallpaper_view/wallpaper_view.dart';
import 'package:http/http.dart' as http;

import 'dart:convert' as convert;

class SetWallpaperCategoryDialog extends StatefulWidget {
  WalpaperViewState walpaperViewState;
  SetWallpaperCategoryDialog(this.walpaperViewState);
  @override
  _SetWallpaperCategoryDialogState createState() =>
      _SetWallpaperCategoryDialogState();
}

class _SetWallpaperCategoryDialogState
    extends State<SetWallpaperCategoryDialog> {
  bool _isDark;
  var categoryJs;
  var appData;
  List category;
  int wallpaperID;
  dynamic _dialogContext;

  @override
  void initState() {
    super.initState();
    _isDark = widget.walpaperViewState.widget.basicState.isDark;
    appData =
        widget.walpaperViewState.widget.basicState.widget.stateLoaded.appData;
    wallpaperID = widget.walpaperViewState.walpaperID;
    categoryJs = AppData.wallpapersCategory;
    category = convert.jsonDecode(categoryJs);
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)), //this right here
          child: Container(
            height: 200.0,
            width: 200.0,
            decoration: BoxDecoration(
                color: _isDark ? Colors.black87 : Colors.white,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 15, top: 15, bottom: 6),
                      child: Text(
                        'دسته بندی این والپیپر را مشخص کنید:',
                        style: TextStyle(
                            fontSize: 17.5, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    button(0),
                    SizedBox(
                      width: 20,
                    ),
                    button(1),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    button(2),
                    SizedBox(
                      width: 20,
                    ),
                    button(3),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    button(4),
                    SizedBox(
                      width: 20,
                    ),
                    button(5),
                  ],
                ),
              ],
            ),
          ));
    });
  }

  Widget button(int index) {
    return GestureDetector(
      onTap: () {
        setWallpaperCategory(index);
      },
      child: Container(
        height: 30,
        width: 75,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.5), color: Colors.blue),
        child: Center(
          child: Text(category[index]['name'],
              style: TextStyle(fontSize: 20, color: Colors.white)),
        ),
      ),
    );
  }

  setWallpaperCategory(int categoryNumber) async {
    showDialog(
      context: context,
      builder: (dialogContext) {
        _dialogContext = dialogContext;
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        );
      },
    );
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'X-Master-Key':
          '\$2b\$10\$i/Us68p8zvnmxmI.gpuJve8H7q5JO3qTB2rOobIsR/SOKv/5SmDiG',
    };
    appData[0]['wallpapersData'][wallpaperID]['category'] =
        category[categoryNumber]['name'];
    var url = Uri.https('api.jsonbin.io', '/v3/b/605c9e6f16da904608a13caa');
    var response;
    setState(() {
      appData = convert.jsonEncode(appData);
    });
    try {
      response = await http
          .put(url, headers: requestHeaders, body: appData)
          .timeout(Duration(seconds: 15));
      if (response.statusCode == 200) {
        widget.walpaperViewState.setState(() async {
          Navigator.pop(_dialogContext);
          Navigator.pop(context);
          widget.walpaperViewState.showSetCategoryAlert = true;
          await Future.delayed(Duration(milliseconds: 2500));
          widget.walpaperViewState.showSetCategoryAlert = false;
        });
      } else {
        Navigator.pop(_dialogContext);
        Navigator.pop(context);
        setState(() {
          appData = widget
              .walpaperViewState.widget.basicState.widget.stateLoaded.appData;
        });
      }
    } catch (error) {
      Navigator.pop(_dialogContext);
      Navigator.pop(context);
      print(error);
      setState(() {
        appData = widget
            .walpaperViewState.widget.basicState.widget.stateLoaded.appData;
      });
      // setState(() {
      //   //_loadingCompeleted = false;
      // });
    }
  }
}
