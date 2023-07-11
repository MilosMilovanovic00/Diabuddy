import 'package:diabuddy/screens/onboarding/components/simple_app_container.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void showCustomDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: Colors.white,
          ),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.setTimeForYourNotification,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 30,
                    ),
              ),
              SimpleAppContainer(
                fontSize: 18,
                text: AppLocalizations.of(context)!.setTimeForYourNotification,
                widget: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
