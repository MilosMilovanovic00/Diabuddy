import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThirdIntroPage extends StatelessWidget {
  const ThirdIntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(
          flex: 4,
        ),
        Image.asset('./assets/png/glucose_intro.png'),
        const Spacer(
          flex: 4,
        ),
        Text(
          AppLocalizations.of(context)!.thirdIntroPageTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Spacer(),
        Text(
          AppLocalizations.of(context)!.thirdIntroPageSubtitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const Spacer(
          flex: 4,
        ),
      ],
    );
  }
}
