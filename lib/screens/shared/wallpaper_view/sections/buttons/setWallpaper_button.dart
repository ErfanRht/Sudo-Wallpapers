import 'package:sudo/screens/shared/wallpaper_view/sections/dialogs/set_wallpaper.dart';
import 'package:sudo/screens/shared/wallpaper_view/wallpaper_view.dart';
import 'package:sudo/screens/basic/home/basic.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SetWallpaperButton extends StatefulWidget {
  dynamic basicState;
  WalpaperViewState wallpaperViewState;
  SetWallpaperButton(
    this.basicState,
    this.wallpaperViewState,
  );
  @override
  _SetWallpaperButtonState createState() => _SetWallpaperButtonState();
}

class _SetWallpaperButtonState extends State<SetWallpaperButton> {
  int wallpaperID;
  String appLanguage;

  @override
  void initState() {
    super.initState();
    wallpaperID = this.widget.wallpaperViewState.walpaperID;
    appLanguage = widget.basicState.appLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: appLanguage == 'fa'
          ? 'قرار دادن به عنوان پس زمینه'
          : 'set as background',
      textStyle: appLanguage == 'fa'
          ? TextStyle(color: Colors.white)
          : TextStyle(fontSize: 12, color: Colors.white),
      decoration: BoxDecoration(
          color: Colors.grey[700], borderRadius: BorderRadius.circular(10)),
      showDuration: Duration(milliseconds: 2000),
      child: Padding(
        padding: const EdgeInsets.only(right: 5, left: 5),
        child: IconButton(
            icon: Icon(
              Icons.format_paint,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return SetWallpaperDialog(widget.wallpaperViewState);
                  });
            }),
      ),
    );
  }
}
