import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FirstIntroPage extends StatelessWidget {
  const FirstIntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(
          flex: 1,
        ),
        Align(
          alignment: Alignment.center,
          child: Image.asset('./assets/png/start_intro.png'),
        ),
        const Spacer(),
        Text(
          AppLocalizations.of(context)!.firstIntroPageTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Spacer(),
        Text(
          AppLocalizations.of(context)!.firstIntroPageSubtitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const Spacer(
          flex: 3,
        ),
      ],
    );
  }
}
