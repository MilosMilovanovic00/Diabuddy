import 'package:diabuddy/bloc/auth/auth_bloc.dart';
import 'package:diabuddy/bloc/user/user_bloc.dart';
import 'package:diabuddy/repository/auth_repository.dart';
import 'package:diabuddy/repository/user_repository.dart';
import 'package:diabuddy/screens/glucose_monitoring/add_meal_screen.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AuthRepository authRepository = AuthRepository();
    UserRepository userRepository = UserRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authRepository: authRepository),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(
            userRepository: userRepository,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Diabuddy',
        theme: applicationTheme,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          // Locale('sr'),
        ],
        home: const AddMealScreen(),
      ),
    );
  }
}
