import 'package:flutter/material.dart';

const primaryColor = Color(0xFF4891FF);
const textFieldBackgroundColor = Color(0xFFF0F0F0);
const textFieldTextColor = Color(0xFF7C7C7C);

final containerColorGradient = LinearGradient(
  colors: [primaryColor.withOpacity(0.7), primaryColor],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
