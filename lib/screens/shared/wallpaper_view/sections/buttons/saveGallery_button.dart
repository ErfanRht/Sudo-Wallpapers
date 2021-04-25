import 'package:sudo/screens/shared/wallpaper_view/wallpaper_view.dart';
import 'package:sudo/screens/basic/home/basic.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SaveGalleryButton extends StatefulWidget {
  dynamic basicState;
  WalpaperViewState wallpaperViewState;
  SaveGalleryButton(this.basicState, this.wallpaperViewState);
  @override
  _SaveGalleryButtonState createState() => _SaveGalleryButtonState();
}

class _SaveGalleryButtonState extends State<SaveGalleryButton> {
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
      message: appLanguage == 'fa' ? 'ذخیره در گالری' : 'save in gallery',
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
              Icons.download_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              this.widget.wallpaperViewState.saveWallpaperToGalleryManage(
                  wallpaperID.toString(),
                  this.widget.wallpaperViewState.wallpaperData[wallpaperID]
                      ['img_url']);
            }),
      ),
    );
  }
}
