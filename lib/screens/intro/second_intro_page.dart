import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SecondIntroPage extends StatelessWidget {
  const SecondIntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(
          flex: 3,
        ),
        Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Image.asset('./assets/png/therapy_intro_1.png'),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Image.asset('./assets/png/therapy_intro_2.png'),
            ),
          ],
        ),
        const Spacer(),
        Text(
          AppLocalizations.of(context)!.secondIntroPageTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Spacer(),
        Text(
          AppLocalizations.of(context)!.secondIntroPageSubtitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const Spacer(
          flex: 3,
        ),
      ],
    );
  }
}
