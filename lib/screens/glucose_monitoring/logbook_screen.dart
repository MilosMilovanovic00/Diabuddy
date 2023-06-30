import 'package:diabuddy/screens/glucose_monitoring/components/glucose_entry_container.dart';
import 'package:diabuddy/screens/reusable/app_bottom_navigation_bar.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';

class LogBookScreen extends StatelessWidget {
  const LogBookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<double> nums = [7.2, 4.7, 8.1, 1.6, 3.9, 9.3, 2.8, 5.4, 6.8, 5.2];
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
                'Logbook',
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
            padding: const EdgeInsets.only(
              left: 30.0,
              right: 30.0,
              top: 50,
              bottom: 20,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView.builder(
                itemCount: nums.length,
                itemBuilder: (context, index) {
                  return const GlucoseEntryContainer();
                },
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
