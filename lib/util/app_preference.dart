import 'dart:convert';
import 'package:omdb/model/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  static final AppPreference _appPreference = AppPreference._internal();

  factory AppPreference() {
    return _appPreference;
  }
  AppPreference._internal();

  static final String _favoriteList = "favoriteList";

  static Future<List<Search>> addItemFavorite(Search newValue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    favoriteList.then((value) {
      value.add(newValue);
      prefs.setString(_favoriteList, jsonEncode(value));
    });
    return favoriteList;
  }

  static Future<List<Search>> removeItemFromFavorite(Search newValue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    favoriteList.then((value) {
      var mList = value;
      mList.removeWhere((item) => item.imdbId == newValue.imdbId);
      prefs.setString(_favoriteList, jsonEncode(mList));
    });
    return favoriteList;
  }

  static Future<List<Search>> get favoriteList async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var item = ((json.decode(prefs.getString(_favoriteList) ?? "[]") ?? [])
            as List<dynamic>)
        .map<Search>((item) => Search.fromJson(item))
        .toList();

    return item;
  }
}
