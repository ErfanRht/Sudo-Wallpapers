import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:sudo/screens/loading/loading.dart';
import 'package:sudo/screens/shared/wallpaper_view/wallpaper_view.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart' as GradientText;
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:sudo/screens/basic/drawer/drawer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sudo/models/models/section_models/favorites_models.dart';
import 'package:sudo/screens/basic/home/basic.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Favorites extends StatefulWidget {
  BasicState parent;
  LoadingState stateLoaded;
  Favorites(this.parent, this.stateLoaded);
  @override
  FavoritesState createState() => FavoritesState();
}

class FavoritesState extends State<Favorites> {
  FavoritesState() {
    getFavoritesList();
  }
  // ignore: non_constant_identifier_names
  static List favorites_list = [];
  var wallpaperData;
  bool isDark, inHome;
  List gradientColor;
  Color appThemeColor;
  String appLanguage;

  @override
  void initState() {
    super.initState();
    gradientColor = widget.parent.gradientColor;
    wallpaperData = widget.parent.wallpaperData;
    appThemeColor = widget.parent.appThemeColor;
    appLanguage = widget.parent.appLanguage;
    inHome = widget.parent.inHome;
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    setState(() {
      isDark = brightnessValue == Brightness.dark;
    });
    return WillPopScope(
      onWillPop: back,
      child: Scaffold(
        backgroundColor: isDark ? Colors.black : Colors.white,
        drawer: Drawer(child: HomeDrawer(this)),
        appBar: AppBar(
          backgroundColor: isDark ? Colors.black : Colors.white,
          automaticallyImplyLeading: false,
          leadingWidth: 47.5,
          leading: Builder(
            builder: (context) => Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircularGradientButton(
                child: Icon(
                  this.widget.parent.openFavoritesFromHome
                      ? Icons.arrow_back
                      : Icons.menu,
                  size: 19,
                ),
                callback: () {
                  this.widget.parent.openFavoritesFromHome
                      ? _onWillPop()
                      : Scaffold.of(context).openDrawer();
                },
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: gradientColor),
                shadowColor: Gradients.rainbowBlue.colors.last.withOpacity(0.5),
              ),
            ),
          ),
          iconTheme: IconThemeData(color: Colors.blue),
          title: GradientText.GradientText(
            text: 'مورد علاقه ها',
            colors: gradientColor,
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
          ),
          //centerTitle: true,
        ),
        body: favorites_list.isNotEmpty
            ? Container(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(favorites_list.length, (index) {
                    return GestureDetector(
                      child: Hero(
                        tag: 'Walpapers${favorites_list[index].toString()} ',
                        child: Center(
                            child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(),
                          child: CachedNetworkImage(
                            imageUrl:
                                wallpaperData[int.parse(favorites_list[index])]
                                    ['img_url'],
                            fit: BoxFit.fitWidth,
                            placeholder: (context, url) => SpinKitThreeBounce(
                              color: appThemeColor,
                              size: 20.0,
                            ),
                          ),
                        )),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            childCurrent:
                                Favorites(widget.parent, widget.stateLoaded),
                            child: WalpaperView(
                                int.parse(favorites_list[index]),
                                this,
                                'favorites'),
                            duration: Duration(milliseconds: 600),
                            reverseDuration: Duration(milliseconds: 600),
                          ),
                        );
                      },
                    );
                  }),
                ),
              )
            : Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: MediaQuery.of(context).size.height - 200,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 500),
                        child: Center(
                          child: GradientText.GradientText(
                            colors: gradientColor,
                            text: 'لیست والپیپر های مورد علاقه شما خالی است.',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),

                      // Center(
                      //   child: Container(
                      //       margin: EdgeInsets.only(
                      //           top: MediaQuery.of(context).size.width /
                      //               3),
                      //       child: CircularProgressIndicator()),
                      // ),
                      // isDark
                      //     ? Image.asset(
                      //         'assets/images/404Error/404Error_dark.png')
                      //     : Image.asset(
                      //         'assets/images/404Error/404Error_light.jpg',
                      //       ),
                      Center(
                        child: UnDraw(
                          color: widget.parent.appThemeColor,
                          illustration: UnDrawIllustration.empty,
                          placeholder:
                              CircularProgressIndicator(), //optional, default is the CircularProgressIndicator().
                          errorWidget: Icon(Icons.error_outline,
                              color: Colors.red,
                              size:
                                  50), //optional, default is the Text('Could not load illustration!').
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void update_favorites_list(String ok) async {
    getFavoritesList();
  }

  getFavoritesList() {
    FavoritesData.getFavoritesData().then((response) {
      setState(() {
        favorites_list = response;
        //favorites_list = favorites_list.replaceAll('_ ', '');
        print(favorites_list);
      });
    });
  }

  // ignore: missing_return
  Future<bool> _onWillPop() async {
    if (this.widget.parent.openFavoritesFromHome) {
      Navigator.pop(context);
      this.widget.parent.setState(() {
        this.widget.parent.openFavoritesFromHome = false;
      });
    } else {
      //update_section_selected(0);
    }
  }

  Future<bool> back() async {
    if (!this.widget.parent.openFavoritesFromHome) {
      if (!inHome) {
        setState(() {
          inHome = true;
        });
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.rotate,
            childCurrent: Favorites(widget.parent, widget.stateLoaded),
            child: Basic(this.widget.parent.widget.stateLoaded),
            duration: Duration(milliseconds: 600),
            reverseDuration: Duration(milliseconds: 600),
          ),
        );
      }
    } else if (widget.parent.openFavoritesFromHome == true) {
      widget.parent.setState(() {
        widget.parent.openFavoritesFromHome = false;
      });
      Navigator.pop(context);
    } else {
      //update_section_selected(0);
    }

    return true;
  }

  changeAppSection() async {
    await Future.delayed(Duration(milliseconds: 400));
    setState(() {
      inHome = true;
    });
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.rotate,
        childCurrent: Favorites(widget.parent, widget.stateLoaded),
        child: Basic(widget.parent.widget.stateLoaded),
        duration: Duration(milliseconds: 600),
        reverseDuration: Duration(milliseconds: 600),
      ),
    );
  }
}
