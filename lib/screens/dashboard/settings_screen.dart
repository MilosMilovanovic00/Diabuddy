import 'package:diabuddy/screens/reusable/app_bottom_navigation_bar.dart';
import 'package:diabuddy/screens/reusable/settings_container.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
              child: Text(
                'Hi, Milos',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 40,
                    ),
              ),
            ),
          ),
          elevation: 0,
        ),
        backgroundColor: primaryColor.withOpacity(0.10),
        bottomNavigationBar: const AppBottomNavigationBar(),
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
                  text: 'Measurements',
                  callback: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                SettingsContainer(
                  text: 'Target glucose range',
                  callback: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                SettingsContainer(
                  text: 'Medication',
                  callback: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                SettingsContainer(
                  text: 'Profile settings',
                  callback: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                SettingsContainer(
                  text: 'Language',
                  callback: () {},
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
}
