import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';

var applicationTheme = ThemeData(
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.bold,
      fontFamily: 'Lexend',
    ),
    headlineSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: 'SourceSansPro',
      color: primaryColor,
    ),
  ),
);
