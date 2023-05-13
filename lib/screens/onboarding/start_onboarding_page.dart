import 'package:flutter/material.dart';

class StartOnboardingPage extends StatelessWidget {
  const StartOnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(
          flex: 2,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Image.asset('./assets/png/start_onboarding.png'),
        ),
        const Spacer(),
        Text(
          'Lets start the journey together',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Spacer(),
        Text(
          'Start your journey towards better diabetes management with our app.',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const Spacer(
          flex: 3,
        ),
      ],
    );
  }
}
