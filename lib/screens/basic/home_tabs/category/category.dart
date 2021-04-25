import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:convert' as convert;
import 'package:sudo/models/data/app_data.dart';
import 'package:sudo/screens/basic/home/basic.dart';
import 'package:sudo/screens/basic/home_tabs/category/category_view.dart';

class Category extends StatefulWidget {
  BasicState basicState;
  Category(this.basicState);
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  var categoryJs;
  String appLanguage;
  List appTheme, category;
  @override
  void initState() {
    super.initState();
    appLanguage = widget.basicState.appLanguage;
    appLanguage == 'fa'
        ? categoryJs = AppData.wallpapersCategory
        : categoryJs = AppData.englishWallpapersCategory;
    appTheme = widget.basicState.gradientColor;
    category = convert.jsonDecode(categoryJs);
  }

  @override
  Widget build(BuildContext context) {
    //var device_height = MediaQuery.of(context).size.height;
    double device_width = MediaQuery.of(context).size.width;
    return Container(
        child: ListView.builder(
      itemCount: category.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.topToBottom,
                childCurrent: Category(widget.basicState),
                child: CategoryView(index, widget.basicState),
                duration: Duration(milliseconds: 500),
                reverseDuration: Duration(milliseconds: 500),
              ),
            );
          },
          child: Column(
            children: [
              Stack(
                fit: StackFit.loose,
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: device_width / 5),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(100)),
                      child: CircularProgressIndicator(
                        value: 0.01,
                        backgroundColor: Colors.grey[100],
                      ),
                    ),
                  ),
                  Container(
                    width: device_width,
                    height: device_width / 2,
                    child: Image.asset(
                      "assets/images/category/${category[index]['img_url']}.jpg",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: appLanguage == 'fa'
                            ? EdgeInsets.only(
                                top: device_width - 260, right: 10)
                            : EdgeInsets.only(
                                top: device_width - 260, left: 10),
                        width: 130,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          color: Colors.white,
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            margin: appLanguage == 'fa'
                                ? EdgeInsets.only(
                                    top: device_width - 257.5, right: 12.25)
                                : EdgeInsets.only(
                                    top: device_width - 257.5, left: 12.25),
                            width: 125,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: appTheme),
                            ),
                            child: Center(
                              child: Text(
                                category[index]['name'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: appLanguage == 'fa' ? 20 : 15.5,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: device_width,
                height: 1,
              ),
            ],
          ),
        );
      },
    ));
  }
}
