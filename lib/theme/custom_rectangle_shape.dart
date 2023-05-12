import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomRectangleShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();
    Path customRectangle = Path();
    customRectangle.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          -height / 10,
          width * 0.75,
          width * 8.05,
          height * 0.51,
        ),
        const Radius.circular(
          20,
        ),
      ),
    );
    Matrix4 matrix = Matrix4.identity();
    matrix.rotateZ(-20 * (math.pi / 180));
    customRectangle = customRectangle.transform(
      matrix.storage,
    );
    paint.color = primaryColor.withOpacity(0.7);
    canvas.drawPath(customRectangle, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
