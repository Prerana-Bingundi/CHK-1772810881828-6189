import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'locale_constants.dart';

const String LANGUAGE_CODE = 'languageCode';

/// Save selected language
Future<Locale> setLocale(String languageCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(LANGUAGE_CODE, languageCode);

  return _locale(languageCode);
}

/// Get saved language
Future<Locale> getLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String languageCode = prefs.getString(LANGUAGE_CODE) ?? "en";

  return _locale(languageCode);
}

/// Convert language code to Locale
Locale _locale(String languageCode) {
  switch (languageCode) {
    case 'hi':
      return const Locale('hi', '');
    case 'en':
    default:
      return const Locale('en', '');
  }
}

/// Change language
void changeLanguage(BuildContext context, String selectedLanguageCode) async {
  var locale = await setLocale(selectedLanguageCode);

  // IMPORTANT: use your app class name
  KrishiSahayakApp.setLocale(context, locale);
}