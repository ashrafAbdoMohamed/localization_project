import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

final Account account = Account._private();

class Account {
  late SharedPreferences _prefs;
  late Future<SharedPreferences> prefsFuture;

  String get language => _prefs.getString('language') ?? "ar";
  set language(field) => _prefs.setString('language', field);

  clear() {
    _prefs.clear();
  }

  Account._private() {
    getPreferencesFuture();
    getPreferences();
  }

  void getPreferencesFuture() {
    prefsFuture = SharedPreferences.getInstance();
  }

  Future<void> getPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }
}
