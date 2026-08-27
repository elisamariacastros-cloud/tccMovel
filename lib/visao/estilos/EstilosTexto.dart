import 'dart:ui';

import 'package:flutter/material.dart';
class EstilosTextosCustomizado {

  static const String font = "Poppins";

  static TextStyle formField(BuildContext context) {
    return TextStyle(
      fontFamily: font,
      fontSize: 18.0,
      fontWeight: FontWeight.normal,
      color: const Color.fromARGB(255, 0, 0, 0),
    );
  }

  static TextStyle title(BuildContext context) {
    return TextStyle(
      fontFamily: font,
      fontSize: 34,
      fontWeight: FontWeight.bold,
      color: const Color.fromARGB(255, 170, 0, 0),
    );
  }

  static TextStyle subTitle(BuildContext context) {
    return TextStyle(
      fontFamily: font,
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: const Color.fromARGB(255, 170, 0, 0),
    );
  }

  static TextStyle button(BuildContext context) {
    return TextStyle(
      fontFamily: font,
      fontSize: 20,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.6,
      color: const Color.fromARGB(255, 0, 0, 0),
    );
  }

  static TextStyle button2(BuildContext context) {
    return TextStyle(
      fontFamily: font,
      fontSize: 20,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.8,
      color: Colors.white,
    );
  }

  static TextStyle body(BuildContext context) {
    return TextStyle(
      fontFamily: font,
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: const Color.fromARGB(255, 170, 0, 0),
    );
  }
}