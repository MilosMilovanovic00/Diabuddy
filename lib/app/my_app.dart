import 'package:diabuddy/bloc/auth/auth_bloc.dart';
import 'package:diabuddy/bloc/notification/notification_bloc.dart';
import 'package:diabuddy/bloc/user/user_bloc.dart';
import 'package:diabuddy/preferences/user_simple_preferences.dart';
import 'package:diabuddy/repository/auth_repository.dart';
import 'package:diabuddy/repository/dish_repository.dart';
import 'package:diabuddy/repository/glucose_repository.dart';
import 'package:diabuddy/repository/notification_repository.dart';
import 'package:diabuddy/repository/user_repository.dart';
import 'package:diabuddy/screens/intro/final_intro_screen.dart';
import 'package:diabuddy/screens/intro/intro_screen.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  late Locale? locale;
  AuthRepository authRepository = AuthRepository();
  UserRepository userRepository = UserRepository();
  GlucoseRepository glucoseRepository = GlucoseRepository();
  DishRepository dishRepository = DishRepository();
  NotificationRepository notificationRepository = NotificationRepository();

  late bool skipOnboarding;

  @override
  void initState() {
    super.initState();
    skipOnboarding = UserSimplePreferences.getOnboardingScreenSkip() ?? false;
    if (UserSimplePreferences.getLanguagePreferences() == null) {
      locale = const Locale('en');
    } else if (UserSimplePreferences.getLanguagePreferences()) {
      locale = const Locale('en');
    } else {
      locale = const Locale('sr');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authRepository: authRepository),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(
            userRepository: userRepository,
            glucoseRepository: glucoseRepository,
            dishRepository: dishRepository,
          ),
        ),
        BlocProvider<NotificationBloc>(
          create: (context) => NotificationBloc(
            notificationRepository: notificationRepository,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Diabuddy',
        theme: applicationTheme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        home: skipOnboarding ? const FinalIntroScreen() : const IntroScreen(),
      ),
    );
  }

  void setLocale(Locale newLocale) {
    setState(() {
      locale = newLocale;
    });
  }
}
