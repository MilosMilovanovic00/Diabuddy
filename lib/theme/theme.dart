import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';

var applicationTheme = ThemeData(
  textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.bold,
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
        fontWeight: FontWeight.bold,
        fontFamily: 'Lexend',
        color: Colors.white,
      ),
      displaySmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'SourceSansPro',
        color: Colors.white,
      )),
);

final borderRadius = BorderRadius.circular(10.0);
