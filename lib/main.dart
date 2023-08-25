import 'package:diabuddy/app/my_app.dart';
import 'package:diabuddy/notification_service/notification_manager.dart';
import 'package:diabuddy/preferences/user_simple_preferences.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timezone/data/latest.dart' as tz;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserSimplePreferences.init();
  await NotificationManager().initNotification();
  tz.initializeTimeZones();
  runApp(const MyApp());
}
