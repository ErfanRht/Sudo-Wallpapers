import 'package:sudo/screens/shared/wallpaper_view/sections/buttons/saveGallery_button.dart';
import 'package:sudo/screens/shared/wallpaper_view/sections/buttons/setWallpaper_button.dart';
import 'package:sudo/screens/shared/wallpaper_view/sections/buttons/favorite_button.dart';
import 'package:sudo/screens/shared/wallpaper_view/sections/dialogs/set_category.dart';
import 'package:sudo/screens/shared/wallpaper_view/sections/buttons/share_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:sudo/screens/basic/home/basic.dart';
import 'package:sudo/models/models/app_models.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:typed_data';
import 'dart:io';

// ignore: must_be_immutable
class WalpaperView extends StatefulWidget {
  int walpaperID;
  dynamic basicState;
  String parentClassName;
  WalpaperView(this.walpaperID, this.basicState, this.parentClassName);
  @override
  WalpaperViewState createState() => WalpaperViewState();
}

class WalpaperViewState extends State<WalpaperView> {
  bool _isDark,
      favoritesList,
      openedImage,
      snackBarTrueOpened,
      snackBarFalseOpened,
      // ignore: unused_field
      _setWallpaper,
      showSetWallpaperDialog,
      showSaveToGalleryAlert,
      showSetCategoryAlert,
      showSetWallpaperAlert,
      showInfoMenuNull,
      showInfoMenuNotNull,
      inTry;
  double _width,
      _height,
      downHeight,
      snackBarTrueHeight,
      snackBarFalseHeight,
      wallpaperSnackBarHeight;
  int walpaperID, _counter, _counter2, time;
  List wallpaperData, appTheme;
  String wallpaperTag, appLanguage;
  dynamic _dialogContext;

  @override
  void initState() {
    super.initState();
    walpaperID = widget.walpaperID;
    _isDark = this.widget.basicState.isDark;
    wallpaperData = this.widget.basicState.wallpaperData;
    appLanguage = widget.basicState.appLanguage;
    appTheme = widget.basicState.gradientColor;
    _setWallpaper = true;
    openedImage = false;
    snackBarTrueOpened = false;
    snackBarFalseOpened = false;
    showSaveToGalleryAlert = false;
    showSetWallpaperAlert = false;
    showSetWallpaperDialog = false;
    showInfoMenuNull = false;
    showInfoMenuNotNull = false;
    showSetCategoryAlert = false;
    inTry = false;
    _width = 0;
    _height = 0;
    downHeight = 0;
    snackBarTrueHeight = 0;
    snackBarFalseHeight = 0;
    wallpaperSnackBarHeight = 0;
    _counter = 0;
    _counter2 = 0;
    time = 0;
    widget.parentClassName == 'recent' || widget.parentClassName == 'most view'
        ? wallpaperTag = 'Walpapers${walpaperID.toString()}'
        : wallpaperTag = 'Walpapers${walpaperID.toString()} ';
  }

  @override
  Widget build(BuildContext context) {
    print(widget.basicState.section_selected);
    AppModels.systemUIOverlayStyle(_isDark, 'wallpaper_view');
    openAndCloseImageManage(context);
    return WillPopScope(
      onWillPop: closeWallpaperView,
      child: Scaffold(
        backgroundColor: _isDark ? Colors.black : Colors.white,
        body: Stack(
          children: [
            GestureDetector(
              child: Container(
                child: Hero(
                  tag: wallpaperTag,
                  child: Center(
                      child: AnimatedContainer(
                          duration: Duration(
                            milliseconds: 250,
                          ),
                          width: _width,
                          height: _height,
                          decoration: BoxDecoration(),
                          child: _height !=
                                  (MediaQuery.of(context).size.height / 2)
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (showInfoMenuNotNull) {
                                        showInfoMenuNotNull = false;
                                      }
                                      if (showInfoMenuNull) {
                                        showInfoMenuNull = false;
                                      }
                                    });
                                  },
                                  child: CachedNetworkImage(
                                    imageUrl: wallpaperData[walpaperID]
                                        ['img_url'],
                                    fit: BoxFit.fitHeight,
                                  ),
                                )
                              : _height != 0
                                  ? CachedNetworkImage(
                                      imageUrl: wallpaperData[walpaperID]
                                          ['img_url'],
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: wallpaperData[walpaperID]
                                          ['img_url'],
                                      fit: BoxFit.fitHeight,
                                    ))),
                ),
              ),
            ),
            snackBarTrueOpened ? snackBarFavoriteAdded() : nullWidget(),
            snackBarFalseOpened ? snackBarFavoriteRemove() : nullWidget(),
            AnimatedContainer(
              duration: Duration(
                milliseconds: 250,
              ),
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height - downHeight),
              height: downHeight,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent.withOpacity(0.50),
              child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Stack(
                    children: [
                      appLanguage == 'fa'
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    FavoriteButton(
                                        widget.basicState, this, favoritesList),
                                    SaveGalleryButton(widget.basicState, this),
                                    SetWallpaperButton(widget.basicState, this),
                                    ShareButton(widget.basicState, this)
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, bottom: 5),
                                  child: GradientText(
                                    text: 'Sudo Walpapers',
                                    colors: appTheme,
                                    style: TextStyle(
                                        //color: Colors.blue,
                                        fontSize: 18.0,
                                        fontFamily: 'pacifico',
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, bottom: 5),
                                  child: GradientText(
                                    text: 'Sudo Walpapers',
                                    colors: appTheme,
                                    style: TextStyle(
                                        //color: Colors.blue,
                                        fontSize: 18.0,
                                        fontFamily: 'pacifico',
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Row(
                                  children: [
                                    ShareButton(widget.basicState, this),
                                    SetWallpaperButton(widget.basicState, this),
                                    SaveGalleryButton(widget.basicState, this),
                                    FavoriteButton(
                                        widget.basicState, this, favoritesList),
                                  ],
                                ),
                              ],
                            )
                    ],
                  )),
            ),
            SafeArea(
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Tooltip(
                        message: appLanguage == 'fa'
                            ? 'بازگشت به صفحه اصلی'
                            : 'Back to main page',
                        textStyle: appLanguage == 'fa'
                            ? TextStyle(color: Colors.white)
                            : TextStyle(fontSize: 12, color: Colors.white),
                        decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(10)),
                        showDuration: Duration(milliseconds: 2000),
                        child: GestureDetector(
                          onTap: () {
                            closeWallpaperView();
                          },
                          child: Padding(
                            padding: appLanguage == 'fa'
                                ? EdgeInsets.only(top: 5, right: 5)
                                : EdgeInsets.only(top: 5, left: 5),
                            // ignore: missing_required_param
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          //closeWallpaperView();
                          if (wallpaperData[walpaperID]['category'] == 'null') {
                            setState(() {
                              if (showInfoMenuNull) {
                                showInfoMenuNull = false;
                              } else {
                                showInfoMenuNull = true;
                              }
                            });
                          } else {
                            setState(() {
                              if (showInfoMenuNotNull) {
                                showInfoMenuNotNull = false;
                              } else {
                                showInfoMenuNotNull = true;
                              }
                            });
                          }
                        },
                        child: Padding(
                          padding: appLanguage == 'fa'
                              ? EdgeInsets.only(top: 5, left: 5)
                              : EdgeInsets.only(top: 5, right: 5),
                          // ignore: missing_required_param
                          child: IconButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Stack(
                        children: [
                          AnimatedOpacity(
                            opacity: showInfoMenuNotNull ? 1 : 0,
                            duration: Duration(milliseconds: 150),
                            child: Container(
                              margin: EdgeInsets.only(top: 37.5, left: 30),
                              height: 35,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(7.5)),
                              child: infoMenuReport(),
                            ),
                          ),
                          AnimatedOpacity(
                            opacity: showInfoMenuNull ? 1 : 0,
                            duration: Duration(milliseconds: 150),
                            child: Container(
                              margin: EdgeInsets.only(top: 37.5, left: 30),
                              height: 70,
                              width: 110,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(7.5)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  infoMenuReport(),
                                  SizedBox(
                                    height: 2.5,
                                  ),
                                  infoMenuCategory()
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            appLanguage == 'fa'
                ? Stack(
                    children: [
                      notiferAlert(
                          'والپیپر در گالری ذخیره شد', showSaveToGalleryAlert),
                      notiferAlert('والپیپر به عنوان پس زمینه قرار داده شد',
                          showSetWallpaperAlert),
                      notiferAlert(
                          'دسته بندی والپیپر تایید شد', showSetCategoryAlert)
                    ],
                  )
                : Stack(
                    children: [
                      notiferAlert('Wallpaper was saved in the gallery',
                          showSaveToGalleryAlert),
                      notiferAlert('Wallpaper was placed as a background',
                          showSetWallpaperAlert),
                      notiferAlert(
                          'Wallpaper category approved', showSetCategoryAlert)
                    ],
                  )
          ],
        ),
      ),
    );
  }

  ////////////////////////////////////////////////Voids////////////////////////////////////////////////////

  Future<bool> closeWallpaperView() async {
    if (openedImage) {
      setState(() {
        _counter = 0;
        openedImage = false;
        snackBarTrueOpened = false;
        snackBarFalseOpened = false;
        showSaveToGalleryAlert = false;
        showSetWallpaperAlert = false;
        inTry = false;
      });
      //wallpaperSnackBarManage(false);
      openAndCloseImageManage(context);
      await Future.delayed(Duration(milliseconds: 250));
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
    return true;
  }

  openAndCloseImageManage(BuildContext context) async {
    if (_counter == 0) {
      setState(() {
        if (BasicState.favorites_list != null) {
          if (BasicState.favorites_list.indexOf(walpaperID.toString()) >= 0) {
            favoritesList = true;
          } else {
            favoritesList = false;
          }
        } else {
          favoritesList = false;
        }
        _width = MediaQuery.of(context).size.width / 2;
        _height = MediaQuery.of(context).size.height / 2;
        downHeight = 0;
        _counter++;
        _counter2++;
      });
      await Future.delayed(Duration(milliseconds: 620));
      if (_counter2 == 1) {
        setState(() {
          openedImage = true;
          _width = MediaQuery.of(context).size.width;
          _height = MediaQuery.of(context).size.height;
          downHeight = 60;
        });
      }
    }
  }

  saveWallpaperToGallery(String wallpaperId, String imgUrl, String mode) async {
    String filePath =
        "/storage/emulated/0/Pictures/SudoWallpapers/Wallpaper${wallpaperId.toString()}.jpg";
    if (await File(filePath).exists()) {
      setState(() {
        time++;
        inTry = true;
      });
      saveWallpaperToGallery('${walpaperID.toString()}(${time.toString()})',
          wallpaperData[walpaperID]['img_url'], 'saveTogallery');
    } else {
      var response = await Dio()
          .get(imgUrl, options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 100,
          name: "SudoWallpapers/Wallpaper${wallpaperId.toString()}");
      if (result.toString() ==
          '{filePath: null, errorMessage: java.io.FileNotFoundException: /storage/emulated/0/Pictures/SudoWallpapers/Wallpaper${wallpaperId.toString()}.jpg: open failed: EACCES (Permission denied), isSuccess: false}') {
        getStorageAccess(wallpaperId, imgUrl);
      }
      print(result);
      if (result.toString() ==
          '{filePath: file:///storage/emulated/0/Pictures/SudoWallpapers/Wallpaper${wallpaperId.toString()}.jpg, errorMessage: null, isSuccess: true}') {
        if (mode == 'saveTogallery') {
          try {
            Navigator.pop(_dialogContext);
            setState(() {
              inTry = false;
            });
          } catch (error) {}
          setState(() {
            inTry = false;
            showSaveToGalleryAlert = true;
          });
          await Future.delayed(Duration(milliseconds: 2500));
          setState(() {
            showSaveToGalleryAlert = false;
          });
        }
      }
    }
  }

  saveWallpaperToGalleryManage(String wallpaperId, String imgUrl) async {
    print(time);
    !inTry
        ? showDialog(
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
          )
        : null;
    await saveWallpaperToGallery(wallpaperId, imgUrl, 'saveTogallery');
  }

  getStorageAccess(String wallpaperId, String imgUrl) async {
    bool returnedStatus = false;
    String imgUrl =
        'https://androidwalls.net/wp-content/uploads/2015/03/Abstract%20Glass%20Shards%20Universe%20Space%20Colors%20Android%20Wallpaper.jpg';

    await GallerySaver.saveImage(imgUrl).then((bool success) {
      if (success) {
        setState(() {
          returnedStatus = true;
        });
      }
    });
    print(returnedStatus);
    if (returnedStatus == true) {
      saveWallpaperToGalleryManage(wallpaperId, imgUrl);
    } else {
      Navigator.pop(_dialogContext);
    }
  }

  snackBarOpenTrue(String snackBarMode) async {
    setState(() {
      snackBarTrueHeight = MediaQuery.of(context).size.height;
      favoritesList ? favoritesList = false : favoritesList = true;
      snackBarTrueOpened = true;
    });
    await Future.delayed(Duration(milliseconds: 100));
    setState(() {
      snackBarTrueHeight = MediaQuery.of(context).size.height - 200;
    });
    await Future.delayed(Duration(milliseconds: 1700));
    setState(() {
      snackBarTrueHeight = MediaQuery.of(context).size.height;
    });
    await Future.delayed(Duration(milliseconds: 250));
    setState(() {
      snackBarTrueOpened = false;
      snackBarTrueHeight = 0;
    });
  }

  snackBarCloseTrue(String snackBarMode) async {
    setState(() {
      snackBarTrueOpened = false;
    });
  }

  snackBarOpenFalse(String snackBarMode) async {
    setState(() {
      snackBarFalseHeight = MediaQuery.of(context).size.height;
      favoritesList ? favoritesList = false : favoritesList = true;
      snackBarFalseOpened = true;
    });
    await Future.delayed(Duration(milliseconds: 100));
    setState(() {
      snackBarFalseHeight = MediaQuery.of(context).size.height - 200;
    });
    await Future.delayed(Duration(milliseconds: 1700));
    setState(() {
      snackBarFalseHeight = MediaQuery.of(context).size.height;
    });
    await Future.delayed(Duration(milliseconds: 250));
    setState(() {
      snackBarFalseOpened = false;
      snackBarFalseHeight = 0;
    });
  }

  snackBarCloseFalse(String snackBarMode) async {
    setState(() {
      snackBarFalseOpened = false;
    });
  }

  setWallpaper(String mode) async {
    String filePath =
        "/storage/emulated/0/Pictures/SudoWallpapers/Wallpaper${walpaperID.toString()}.jpg";
    int location;
    String result;
    if (await File(filePath).exists()) {
      try {
        if (mode == 'homeScreen') {
          location = WallpaperManager.HOME_SCREEN;
          result =
              await WallpaperManager.setWallpaperFromFile(filePath, location);
        } else if (mode == 'lockScreen') {
          location = WallpaperManager.LOCK_SCREEN;
          result =
              await WallpaperManager.setWallpaperFromFile(filePath, location);
        } else if (mode == 'both') {
          location = WallpaperManager.LOCK_SCREEN;
          result =
              await WallpaperManager.setWallpaperFromFile(filePath, location);
          location = WallpaperManager.HOME_SCREEN;
          result =
              await WallpaperManager.setWallpaperFromFile(filePath, location);
        }
      } catch (e) {
        await getStorageAccess(
            walpaperID.toString(), wallpaperData[walpaperID]['img_url']);
        setWallpaper(mode);
      }
    } else {
      await saveWallpaperToGallery(walpaperID.toString(),
          wallpaperData[walpaperID]['img_url'], 'setWallpaper');
      await setWallpaper(mode);
    }
    print(result);
  }

  setWallpaperManage(String mode) async {
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
    await setWallpaper(mode);
    try {
      Navigator.pop(_dialogContext);
    } catch (e) {}
    setState(() {
      showSetWallpaperAlert = true;
    });
    await Future.delayed(Duration(milliseconds: 2500));
    setState(() {
      showSetWallpaperAlert = false;
    });
  }

////////////////////////////////////////////////Widgets////////////////////////////////////////////////////

  Widget nullWidget() {
    return Text(
      '',
      style: TextStyle(fontSize: 0),
    );
  }

  Widget notiferAlert(String text, bool active) {
    return Center(
      child: AnimatedOpacity(
        opacity: active ? 1.0 : 0.0,
        duration: Duration(milliseconds: 250),
        child: Stack(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                width: 125.0,
                height: 125.0,
              ),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: appTheme),
                ),
                width: 110.0,
                height: 110.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 5.0,
                    ),
                    Icon(
                      Icons.check_outlined,
                      color: Colors.white,
                      size: 42.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                      child: Text(
                        text,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: appLanguage == 'fa' ? 12 : 9,
                            fontWeight: appLanguage == 'fa'
                                ? FontWeight.w500
                                : FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget snackBarFavoriteAdded() {
    return Center(
      child: AnimatedContainer(
        margin: EdgeInsets.only(top: snackBarTrueHeight),
        duration: Duration(milliseconds: 250),
        height: 45,
        width: MediaQuery.of(context).size.width - 50,
        decoration: BoxDecoration(
            color: _isDark ? Colors.black : Colors.grey[200],
            borderRadius: BorderRadius.circular(7)),
        child: Row(
          children: [
            SizedBox(
              width: 15,
            ),
            Icon(
              Icons.favorite,
              color: Colors.blue[800],
            ),
            SizedBox(
              width: 15,
            ),
            Text(
                appLanguage == 'fa'
                    ? 'والپیپر به لیست مورد علاقه ها افزوده شد.'
                    : 'Wallpaper added to fevorites list.',
                style: TextStyle(
                  color: Colors.blue[800],
                  fontWeight:
                      appLanguage == 'fa' ? FontWeight.normal : FontWeight.bold,
                  fontSize: appLanguage == 'fa' ? 18 : 14,
                ))
          ],
        ),
      ),
    );
  }

  Widget snackBarFavoriteRemove() {
    return Center(
      child: AnimatedContainer(
        margin: EdgeInsets.only(top: snackBarFalseHeight),
        duration: Duration(milliseconds: 250),
        height: 45,
        width: MediaQuery.of(context).size.width - 50,
        decoration: BoxDecoration(
            color: _isDark ? Colors.black : Colors.grey[200],
            borderRadius: BorderRadius.circular(7)),
        child: Row(
          children: [
            SizedBox(
              width: 15,
            ),
            Icon(
              Icons.favorite_outline,
              color: Colors.blue[800],
            ),
            SizedBox(
              width: 15,
            ),
            Text(
                appLanguage == 'fa'
                    ? 'والپیپر از لیست مورد علاقه ها حذف شد.'
                    : 'Wallpaper removed from favorites list.',
                style: TextStyle(
                  color: Colors.blue[800],
                  fontWeight:
                      appLanguage == 'fa' ? FontWeight.normal : FontWeight.bold,
                  fontSize: appLanguage == 'fa' ? 18 : 14,
                )),
          ],
        ),
      ),
    );
  }

  Widget infoMenuReport() {
    return GestureDetector(
      onTap: () {
        showInfoMenuNull ? print('report') : null;
        showInfoMenuNotNull ? print('report') : null;
      },
      child: Row(
        children: [
          SizedBox(
            width: 5,
          ),
          Icon(
            Icons.info_outline,
            color: Colors.grey[700],
            size: 20,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'گزارش',
            style: TextStyle(fontSize: 17.5, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }

  Widget infoMenuCategory() {
    return GestureDetector(
      onTap: () async {
        if (showInfoMenuNull) {
          showDialog(
              context: context,
              builder: (context) {
                return SetWallpaperCategoryDialog(this);
              });
          await Future.delayed(Duration(milliseconds: 200));
          setState(() {
            showInfoMenuNull = false;
          });
        }
      },
      child: Row(
        children: [
          SizedBox(
            width: 5,
          ),
          Icon(
            Icons.category_outlined,
            color: Colors.grey[700],
            size: 20,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'دسته بندی',
            style: TextStyle(fontSize: 17.5, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
