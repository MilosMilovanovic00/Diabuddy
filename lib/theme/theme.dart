import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';

var applicationTheme = ThemeData(
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.w700,
      fontFamily: 'Lexend',
      color: Colors.black,
    ),
    headlineSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: 'SourceSansPro',
      color: primaryColor,
    ),
    displayMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      fontFamily: 'Lexend',
      color: Colors.white,
    ),
    headlineLarge: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w700,
      fontFamily: 'Lexend',
      color: Colors.white,
    ),
    displaySmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: 'SourceSansPro',
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'SourceSansPro',
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: textFieldTextColor,
    ),
    bodySmall: TextStyle(
      fontSize: 15,
      fontFamily: 'SourceSansPro',
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
  ),
);

final borderRadius = BorderRadius.circular(10.0);

final textFieldBorder = OutlineInputBorder(
  borderRadius: borderRadius,
  borderSide: const BorderSide(
    style: BorderStyle.solid,
    color: Colors.grey,
    width: 2,
  ),
);

final numberFieldBorder = OutlineInputBorder(
  borderRadius: borderRadius,
  borderSide: BorderSide.none,
);

final medicationInBorderRadius=BorderRadius.circular(15);