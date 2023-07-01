import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.callback,
    required this.text,
    this.padding,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  final Function() callback;
  final String text;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: TextButton(
              onPressed: callback,
              style: TextButton.styleFrom(
                backgroundColor: backgroundColor ?? primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: borderRadius,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  text,
                  style:
                      Theme.of(context).textTheme.displayMedium!.copyWith(
                            color: textColor ?? Colors.white,
                          ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
