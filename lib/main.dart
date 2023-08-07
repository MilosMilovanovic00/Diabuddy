import 'package:diabuddy/app/my_app.dart';
import 'package:diabuddy/preferences/user_simple_preferences.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserSimplePreferences.init();
  runApp(const MyApp());
}
