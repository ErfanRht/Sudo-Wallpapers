import 'package:flutter/material.dart';
import 'package:sudo/screens/shared/wallpaper_view/wallpaper_view.dart';

// ignore: must_be_immutable
class SetWallpaperDialog extends StatefulWidget {
  WalpaperViewState walpaperViewState;
  SetWallpaperDialog(this.walpaperViewState);
  @override
  _SetWallpaperDialogState createState() => _SetWallpaperDialogState();
}

class _SetWallpaperDialogState extends State<SetWallpaperDialog> {
  bool _isDark;
  String appLanguage;
  @override
  void initState() {
    super.initState();
    _isDark = widget.walpaperViewState.widget.basicState.isDark;
    appLanguage = widget.walpaperViewState.widget.basicState.appLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)), //this right here
          child: Container(
              height: 185.0,
              width: 330.0,
              decoration: BoxDecoration(
                  color: _isDark ? Colors.black87 : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  appLanguage == "fa"
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 15, top: 15, bottom: 6),
                              child: Text(
                                'قراردادن والپیپر به عنوان :',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, top: 15, bottom: 6),
                              child: Text(
                                ': Set wallpaper as',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                  button(0),
                  button(1),
                  button(2),
                ],
              )));
    });
  }

  button(int index) {
    // ignore: unused_local_variable
    String buttonText, buttonJob;
    // ignore: unused_local_variable
    Icon buttonIcon;
    if (appLanguage == 'fa') {
      if (index == 0) {
        buttonText = 'صفحه خانه';
        buttonJob = 'homeScreen';
        buttonIcon = Icon(Icons.home);
      } else if (index == 1) {
        buttonText = 'صفحه قفل';
        buttonJob = 'lockScreen';
        buttonIcon = Icon(Icons.lock);
      } else if (index == 2) {
        buttonText = 'هردو';
        buttonJob = 'both';
        buttonIcon = Icon(Icons.phone_android);
      }
    } else if (appLanguage == 'en') {
      if (index == 0) {
        buttonText = 'Home Screen';
        buttonJob = 'homeScreen';
        buttonIcon = Icon(Icons.home);
      } else if (index == 1) {
        buttonText = 'Lock Screen';
        buttonJob = 'lockScreen';
        buttonIcon = Icon(Icons.lock);
      } else if (index == 2) {
        buttonText = 'Both';
        buttonJob = 'both';
        buttonIcon = Icon(Icons.phone_android);
      }
    }
    return Container(
      height: 40,
      // ignore: deprecated_member_use
      child: FlatButton(
        onPressed: () {
          Navigator.pop(context);
          widget.walpaperViewState.setWallpaperManage(buttonJob);
        },
        highlightColor: _isDark ? Colors.grey[900] : Colors.grey[200],
        splashColor: _isDark ? Colors.grey[900] : Colors.grey[200],
        color: _isDark ? Colors.black : Colors.white,
        child: appLanguage == 'fa'
            ? Row(
                children: [
                  buttonIcon,
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    buttonText,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    buttonText,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  buttonIcon,
                ],
              ),
      ),
    );
  }
}
