import 'package:flutter/material.dart';
import 'package:sudo/models/data/app_data.dart';
import 'package:sudo/screens/loading/loading.dart';

class gradientButton extends StatefulWidget {
  String mode;
  double height;
  double width;
  dynamic child;
  dynamic onClick;
  dynamic buttonParent;
  gradientButton(
      this.mode, this.height, this.width, this.child, this.buttonParent);
  @override
  _gradientButtonState createState() =>
      _gradientButtonState(mode, height, width);
}

class _gradientButtonState extends State<gradientButton> {
  List<Color> appTheme;
  String mode;
  double height;
  double width;
  _gradientButtonState(this.mode, this.height, this.width);
  @override
  void initState() {
    super.initState();
    appTheme =
        widget.buttonParent.widget.basicState.widget.stateLoaded.appTheme;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return InkWell(
        onHighlightChanged: (status) {
          if (status) {
            setState(() {
              height = height - 2;
              width = width - 5;
            });
          }
          if (!status) {
            setState(() {
              height = widget.height;
              width = widget.width;
            });
          }
        },
        onTap: () {
          this.widget.buttonParent.onClick(mode);
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 50),
          height: height,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: appTheme),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: this.widget.buttonParent.widget.basicState.isDark
                    ? Colors.transparent
                    : Colors.blueGrey.withOpacity(0.5),
                spreadRadius: 1.75,
                blurRadius: 6,
                offset: Offset(0, 7), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: widget.child,
          ),
        ),
      );
    });
  }
}
