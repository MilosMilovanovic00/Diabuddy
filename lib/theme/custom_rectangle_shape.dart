import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomRectangleShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();
    paint.color = Colors.white;
    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    canvas.drawPath(mainBackground, paint);
    Path customRectangle = Path();
    customRectangle.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          -width * 0.15,
          height / 12,
          width * 0.82,
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
    return false;
  }
}
