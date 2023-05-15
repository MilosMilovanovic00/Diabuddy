import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    Key? key,
    required this.callback,
    required this.icon,
  }) : super(key: key);

  final Function() callback;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 5.0,
        top: 5,
        bottom: 5,
      ),
      child: Container(
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(8),
            shape: BoxShape.rectangle),
        height: 30,
        width: 30,
        child: Center(
          child: IconButton(
            onPressed: callback,
            icon: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
