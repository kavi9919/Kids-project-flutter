import 'package:flutter/material.dart';

const Color blueClr = Color(0xff0E99FF);
const Color yellowClr = Color(0xffffb746);
const Color pinkClr = Color(0xFFff4667);
const Color darkGrayClr = Color(0xff121212);
const Color darkHeadClr = Color(0xff424242);
const Color borderClr = Color(0xff757272);
const Color surfaceClr = Colors.grey;
Color onSurfaceClr = Colors.white;
const primaryClr = blueClr;

class Themes {
  static final light = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primaryClr,
      onPrimary: onSurfaceClr,
      secondary: Colors.white,
      onSecondary: Colors.black,
      error: pinkClr,
      onError: onSurfaceClr,
      background: Colors.white,
      onBackground: onSurfaceClr,
      surface: surfaceClr,
      onSurface: onSurfaceClr,
    ),
  );

  static final dark = ThemeData(
      primaryColor: const Color(0xff121212), brightness: Brightness.dark);
}
