import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData temaEscuro() {
  final baseTheme = ThemeData(
    fontFamily: "Open Sans",
  );
  return baseTheme.copyWith(
    brightness: Brightness.dark,
    primaryColor: const Color.fromARGB(255, 170, 0, 0),
    primaryColorLight: const Color.fromARGB(255, 170, 0, 0),
    primaryColorDark: Colors.black,    
    highlightColor: Colors.white,
    //primaryColorBrightness: Brightness.dark,
    //accentColor: Colors.white,
  );
}
