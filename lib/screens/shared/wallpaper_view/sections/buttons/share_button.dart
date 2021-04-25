import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:sudo/screens/shared/wallpaper_view/wallpaper_view.dart';

// ignore: must_be_immutable
class ShareButton extends StatefulWidget {
  dynamic basicState;
  WalpaperViewState wallpaperViewState;
  ShareButton(this.basicState, this.wallpaperViewState);
  @override
  _ShareButtonState createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  int wallpaperID;
  String shareContent, appLanguage;
  @override
  void initState() {
    super.initState();
    wallpaperID = widget.wallpaperViewState.walpaperID;
    shareContent =
        widget.basicState.widget.stateLoaded.appData[6]['shareContent'];
    appLanguage = widget.basicState.appLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: appLanguage == 'fa' ? 'اشتراک گذاری' : 'share',
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
              Icons.share,
              color: Colors.white,
            ),
            onPressed: () {
              shareWallpaper(context);
            }),
      ),
    );
  }

  shareWallpaper(BuildContext context) async {
    // ignore: unused_local_variable
    var _dialogContext;
    String filePath =
        "/storage/emulated/0/Pictures/SudoWallpapers/Wallpapers${wallpaperID.toString()}.jpg";

    if (await File(filePath).exists()) {
      try {
        await Share.shareFiles([filePath], text: shareContent);
      } catch (error) {
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
        this.widget.wallpaperViewState.saveWallpaperToGallery(
            wallpaperID.toString(),
            this.widget.wallpaperViewState.wallpaperData[wallpaperID]
                ['img_url'],
            'share');
        Navigator.pop(_dialogContext);
        await Share.shareFiles([filePath], text: shareContent);
      }
    } else {
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
      await this.widget.wallpaperViewState.saveWallpaperToGallery(
          wallpaperID.toString(),
          this.widget.wallpaperViewState.wallpaperData[wallpaperID]['img_url'],
          'share');
      Navigator.pop(_dialogContext);
      await Share.shareFiles([filePath], text: shareContent);
    }
  }
}
