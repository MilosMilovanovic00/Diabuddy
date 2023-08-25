import 'package:flutter/material.dart';

const primaryColor = Color(0xFF4891FF);
const textFieldBackgroundColor = Color(0xFFF0F0F0);
const textFieldTextColor = Color(0xFF7C7C7C);

const highSugarColor = Color(0xFFF4BC0D);
const goodSugarColor = Color(0xFF4EBFA0);
const lowSugarColor = Color(0xFFFB3244);
const orangeColor = Color(0xFFFFA654);

final containerColorGradient = LinearGradient(
  colors: [primaryColor.withOpacity(0.7), primaryColor],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
