import 'package:diabuddy/theme/custom_rectangle_shape.dart';
import 'package:flutter/material.dart';

class StartOnboardingScreen extends StatelessWidget {
  const StartOnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomPaint(
          painter: CustomRectangleShape(),
          size: Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 25,
            ),
            child: Column(
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
