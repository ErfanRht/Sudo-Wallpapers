import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesData {
  static Future<bool> addToFavorites(String wallpaper_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.remove('favorite_wallpapers');
    String wallpapers_id = prefs.getString("favorite_wallpapers");

    if (wallpapers_id != null) {
      if (wallpapers_id.indexOf(wallpaper_id) >= 0) {
      } else {
        String data = wallpapers_id + wallpaper_id + '_';
        prefs.setString('favorite_wallpapers', data);
      }
    } else {
      String data = wallpaper_id + '_';
      prefs.setString('favorite_wallpapers', data);
    }
    return true;
  }

  static Future<bool> removeFromFavorites(String wallpaper_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String wallpapers_id = prefs.getString("favorite_wallpapers");
    wallpapers_id = wallpapers_id.replaceAll(wallpaper_id + "_", "");
    if (wallpapers_id.isEmpty) {
      prefs.remove('favorite_wallpapers');
    } else {
      prefs.setString('favorite_wallpapers', wallpapers_id);
    }
    return true;
  }

  static Future<List> getFavoritesData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String products_id = prefs.getString("favorite_wallpapers");
    List<String> favoritesList;
    if (products_id != null) {
      favoritesList = products_id.split('_');
      favoritesList.removeAt(favoritesList.length - 1);
    } else {
      favoritesList = [];
    }
    return favoritesList;
  }
}
