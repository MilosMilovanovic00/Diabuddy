import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';

class SimpleAppContainer extends StatelessWidget {
  const SimpleAppContainer({
    Key? key,
    required this.text,
    required this.widget,
    this.fontSize,
  }) : super(key: key);

  final String text;
  final double? fontSize;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        shape: BoxShape.rectangle,
        gradient: containerColorGradient,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 25,
          horizontal: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 130,
              child: Text(
                text,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: fontSize ?? 20.0,
                    ),
              ),
            ),
            widget,
          ],
        ),
      ),
    );
  }
}
