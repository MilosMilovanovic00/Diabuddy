import 'package:diabuddy/screens/dashboard/dashboard_screen.dart';
import 'package:diabuddy/screens/dashboard/notification_screen.dart';
import 'package:diabuddy/screens/dashboard/settings_screen.dart';
import 'package:diabuddy/screens/glucose_monitoring/logbook_screen.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 30.0,
          top: 20.0,
          right: 26,
          left: 26,
        ),
        child: GNav(
          tabBorderRadius: 10,
          tabActiveBorder: const Border.fromBorderSide(BorderSide.none),
          tabBorder: Border.all(color: primaryColor, width: 1),
          duration: const Duration(milliseconds: 300),
          gap: 10,
          selectedIndex: 2,
          color: primaryColor,
          activeColor: Colors.white,
          iconSize: 30,
          rippleColor: primaryColor,
          tabBackgroundColor: primaryColor.withOpacity(0.5),
          padding: const EdgeInsets.all(10),
          tabs: [
            GButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardScreen(),
                  ),
                );
              },
              icon: Icons.home,
            ),
            GButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
              icon: Icons.settings,
            ),
            const GButton(
              //TODO treba da ode na stranicu da se doda nov glucose entry
              icon: Icons.add,
            ),
            GButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LogBookScreen(),
                  ),
                );
              },
              icon: Icons.description,
            ),
            GButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationScreen(),
                  ),
                );
              },
              icon: Icons.notifications,
            )
          ],
        ),
      ),
    );
  }
}
