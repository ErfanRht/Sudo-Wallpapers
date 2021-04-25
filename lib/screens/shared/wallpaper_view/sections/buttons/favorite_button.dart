import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:sudo/models/models/section_models/favorites_models.dart';
import 'package:sudo/screens/shared/wallpaper_view/wallpaper_view.dart';

// ignore: must_be_immutable
class FavoriteButton extends StatefulWidget {
  dynamic basicState;
  WalpaperViewState wallpaperViewState;
  bool favoritesList;
  FavoriteButton(this.basicState, this.wallpaperViewState, this.favoritesList);
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
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
          ? widget.favoritesList
              ? 'حذف از لیست موردعلاقه ها'
              : 'افزودن به لیست مورد علاقه ها'
          : widget.favoritesList
              ? 'remove from favorites list'
              : 'add to favorites list',
      textStyle: appLanguage == 'fa'
          ? TextStyle(color: Colors.white)
          : TextStyle(fontSize: 12, color: Colors.white),
      decoration: BoxDecoration(
          color: Colors.grey[700], borderRadius: BorderRadius.circular(10)),
      showDuration: Duration(milliseconds: 2000),
      child: Padding(
        padding: const EdgeInsets.only(right: 15, left: 5),
        child: LikeButton(
          isLiked: widget.favoritesList ? true : false,
          onTap: onLikeButtonTapped,
          size: 25,
          circleColor: CircleColor(start: Colors.red, end: Colors.redAccent),
          bubblesColor: BubblesColor(
            dotPrimaryColor: Colors.red,
            dotSecondaryColor: Colors.redAccent,
          ),
          // ignore: non_constant_identifier_names
          likeBuilder: (bool favorites_list) {
            return Icon(
              favorites_list ? Icons.favorite : Icons.favorite_outline,
              color: favorites_list ? Colors.red : Colors.white,
              size: 25,
            );
          },
        ),
      ),
    );
  }

  Future<bool> onLikeButtonTapped(bool favoritesList) async {
    favoritesList
        // ignore: unnecessary_statements
        ? {
            FavoritesData.removeFromFavorites(wallpaperID.toString())
                .then((response) {}),
            this.widget.basicState.update_favorites_list(''),
            this.widget.wallpaperViewState.snackBarCloseTrue('favorite'),
            this.widget.wallpaperViewState.snackBarOpenFalse('favorite'),
          }
        // ignore: unnecessary_statements
        : {
            FavoritesData.addToFavorites(wallpaperID.toString())
                .then((response) {}),
            this.widget.basicState.update_favorites_list(''),
            this.widget.wallpaperViewState.snackBarCloseFalse('favorite'),
            this.widget.wallpaperViewState.snackBarOpenTrue('favorite'),
          };
    return !favoritesList;
  }
}
