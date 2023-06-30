import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';


class MealEntryContainer extends StatelessWidget {
  const MealEntryContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 8,
      ),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade700,
              offset: const Offset(0, 3),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Bread \n\t',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontSize: 22,
                          ),
                    ),
                    TextSpan(
                      text: '120 g',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
              Text(
                '55 UH',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
