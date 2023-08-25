import 'package:diabuddy/bloc/user/user_bloc.dart';
import 'package:diabuddy/bloc/user/user_event.dart';
import 'package:diabuddy/bloc/user/user_state.dart';
import 'package:diabuddy/screens/dashboard/language_settings_screen.dart';
import 'package:diabuddy/screens/dashboard/profile_settings_screen.dart';
import 'package:diabuddy/screens/onboarding/glucose_target_onboarding_screen.dart';
import 'package:diabuddy/screens/onboarding/therapy_onboarding_screen.dart';
import 'package:diabuddy/screens/onboarding/units_onboarding_screen.dart';
import 'package:diabuddy/screens/reusable/app_bottom_navigation_bar.dart';
import 'package:diabuddy/screens/reusable/settings_container.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Colors.white,
      ),
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child:
                  BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                if (state is FetchedUserData) {
                  return Text(
                    AppLocalizations.of(context)!
                        .hiWithName(state.user.fullName!),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 40,
                        ),
                  );
                } else {
                  return Text(
                    AppLocalizations.of(context)!.settings,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 40,
                        ),
                  );
                }
              }),
            ),
          ),
          elevation: 0,
        ),
        backgroundColor: primaryColor.withOpacity(0.10),
        bottomNavigationBar: const AppBottomNavigationBar(
          selectedIndex: 1,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 20,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                SettingsContainer(
                  text: AppLocalizations.of(context)!.measurements,
                  callback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UnitsOnboardingScreen(
                          fromSettings: true,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SettingsContainer(
                  text: AppLocalizations.of(context)!.targetGlucoseRange,
                  callback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const GlucoseTargetOnboardingScreen(
                          fromSettings: true,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SettingsContainer(
                  text: AppLocalizations.of(context)!.medication,
                  callback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TherapyOnboardingScreen(
                          fromSettings: true,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SettingsContainer(
                  text: AppLocalizations.of(context)!.profileSettings,
                  callback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileSettingsScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SettingsContainer(
                  text: AppLocalizations.of(context)!.language,
                  callback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LanguageSettingsScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(GetUserProfileData());
  }
}
