import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FinalIntroScreen extends StatelessWidget {
  const FinalIntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor.withOpacity(0.7),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  AppLocalizations.of(context)!.diabuddy,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.poweredBySugarRush,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.white),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      AppButton(
                        callback: () {},
                        text: AppLocalizations.of(context)!.logIn,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      AppButton(
                        callback: () {},
                        backgroundColor: Colors.white,
                        textColor: primaryColor,
                        text: AppLocalizations.of(context)!.signUp,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
