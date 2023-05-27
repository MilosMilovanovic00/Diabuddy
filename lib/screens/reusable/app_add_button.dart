import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';

class AppAddButton extends StatelessWidget {
  const AppAddButton({
    Key? key,
    required this.text,
    required this.callback,
  }) : super(key: key);

  final String text;
  final Function() callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.7),
        shape: BoxShape.rectangle,
        borderRadius: borderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextButton(
          onPressed: callback,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_circle_outline,
                color: Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: 18,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
