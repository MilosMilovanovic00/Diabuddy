import 'package:diabuddy/bloc/user/user_bloc.dart';
import 'package:diabuddy/bloc/user/user_event.dart';
import 'package:diabuddy/bloc/user/user_state.dart';
import 'package:diabuddy/screens/dashboard/dashboard_screen.dart';
import 'package:diabuddy/screens/onboarding/glucose_target_onboarding_screen.dart';
import 'package:diabuddy/screens/onboarding/login_screen.dart';
import 'package:diabuddy/screens/onboarding/profile_onboarding_screen.dart';
import 'package:diabuddy/screens/onboarding/registration_screen.dart';
import 'package:diabuddy/screens/onboarding/therapy_onboarding_screen.dart';
import 'package:diabuddy/screens/onboarding/units_onboarding_screen.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/custom_rectangle_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FinalIntroScreen extends StatefulWidget {
  const FinalIntroScreen({Key? key}) : super(key: key);

  @override
  State<FinalIntroScreen> createState() => _FinalIntroScreenState();
}

class _FinalIntroScreenState extends State<FinalIntroScreen> {
  late bool isVisible = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(CheckIfUserExists());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          painter: CustomRectangleShape(),
          size: Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height,
          ),
        ),
        Scaffold(
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
                    BlocListener<UserBloc, UserState>(
                      listener: (context, state) {
                        navigate(state, context);
                      },
                      child: Visibility(
                        visible: isVisible,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            children: [
                              AppButton(
                                callback: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                                },
                                text: AppLocalizations.of(context)!.logIn,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              AppButton(
                                callback: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegistrationScreen(),
                                    ),
                                  );
                                },
                                backgroundColor: Colors.white,
                                textColor: primaryColor,
                                text: AppLocalizations.of(context)!.signUp,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void navigate(UserState state, BuildContext context) {
    if (state is UserHasNoAccount) {
      setState(() {
        isVisible = true;
      });
    } else {
      setState(() {
        isVisible = false;
      });
      widget;
      if (state is UserSetupAccountNotFinished) {
        switch (state.screenNumber) {
          case 1:
            skipToOnboardingScreen(context, const ProfileOnboardingScreen());
            break;
          case 2:
            skipToOnboardingScreen(context, const TherapyOnboardingScreen());
            break;
          case 3:
            skipToOnboardingScreen(context, const UnitsOnboardingScreen());
            break;
          case 4:
            skipToOnboardingScreen(
                context, const GlucoseTargetOnboardingScreen());
            break;
        }
      } else if (state is UserSetupAccountFinished) {
        Future.delayed(const Duration(seconds: 5), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const DashboardScreen(),
            ),
          );
        });
      }
    }
  }

  void skipToOnboardingScreen(BuildContext context, StatefulWidget widget) {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
      );
    });
  }
}
