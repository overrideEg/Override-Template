import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/core/services/preference/preference.dart';

class Themes {
  static List<ThemeData> get all => [cyan, customTheme];

  static final cyan = ThemeData(
    primaryColor: Colors.white,
    primaryColorBrightness: Brightness.light,
    accentColor: Color.fromRGBO(0, 158, 164, 1),
    primarySwatch: Colors.yellow,
    textTheme: GoogleFonts.cairoTextTheme(TextTheme(
      headline: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
      title: TextStyle(fontSize: 24),
      body1: TextStyle(fontSize: 12),
      body2: TextStyle(fontSize: 18),
    )).apply(
      bodyColor: Colors.white,
      // displayColor: Colors.blue,
    ),
    buttonTheme: ButtonThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0))),
    accentIconTheme: IconThemeData(color: Colors.cyan),
  );

  static final customTheme = ThemeData(
      fontFamily: 'Tomica',
      primarySwatch: Colors.blue,
      iconTheme: IconThemeData(color: Colors.blue.withAlpha(230), size: 35),
      textTheme: TextTheme(
        body1: TextStyle(color: Colors.white),
      ));
}

class ThemeProvider with ChangeNotifier {
  int themeIndex;

  ThemeProvider() {
    setTheme(Preference.getInt(PrefKeys.themeIndex) ?? 0);
  }

  setTheme(int index) {
    themeIndex = index;
    notifyListeners();
  }

  getTheme(int index) => Themes.all[index];
}
