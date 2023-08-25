import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';

class ColouredIconButton extends StatelessWidget {
  const ColouredIconButton({
    Key? key,
    required this.backgroundColor,
    required this.icon,
    this.callback,
  }) : super(key: key);

  final Color backgroundColor;
  final Widget icon;
  final Function()? callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (callback != null) {
          callback!();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 3),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: borderRadius,
          ),
          child: icon,
        ),
      ),
    );
  }
}
