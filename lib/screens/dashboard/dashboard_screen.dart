import 'package:diabuddy/bloc/auth/auth_bloc.dart';
import 'package:diabuddy/bloc/auth/auth_event.dart';
import 'package:diabuddy/bloc/auth/auth_state.dart';
import 'package:diabuddy/bloc/user/user_bloc.dart';
import 'package:diabuddy/bloc/user/user_event.dart';
import 'package:diabuddy/bloc/user/user_state.dart';
import 'package:diabuddy/model/enitity/enum/time_period_type.dart';
import 'package:diabuddy/notification_service/notification_manager.dart';
import 'package:diabuddy/screens/dashboard/components/diagram_container.dart';
import 'package:diabuddy/screens/intro/final_intro_screen.dart';
import 'package:diabuddy/screens/reusable/app_bottom_navigation_bar.dart';
import 'package:diabuddy/screens/reusable/daily_glucose_indicator_container.dart';
import 'package:diabuddy/screens/reusable/daily_medication_indicator_container.dart';
import 'package:diabuddy/screens/reusable/dialog.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    DateTime start = DateTime.now();
    start = DateTime(start.year, start.month, start.day);
    DateTime end = start.add(const Duration(days: 1));
    end = DateTime(end.year, end.month, end.day);
    BlocProvider.of<UserBloc>(context).add(GetTodaysTherapyRecords());
    BlocProvider.of<UserBloc>(context)
        .add(GetGlucoseReadingsForPeriod(start, end));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Colors.white,
      ),
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                onPressed: () {
                  // logOut();
                  NotificationManager().scheduleNotification(
                      id: 1,
                      title: 'Prva notifikacija',
                      body: 'Hello world',
                      payload: 'id therapije je 4',
                      scheduleNotificationDateTime:
                          DateTime.now().add(const Duration(seconds: 5)));
                },
                icon: const Icon(
                  Icons.logout,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
          ],
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Diabuddy',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 40,
                  ),
            ),
          ),
          elevation: 0,
        ),
        backgroundColor: primaryColor.withOpacity(0.10),
        bottomNavigationBar: const AppBottomNavigationBar(
          selectedIndex: 0,
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is UserLoggedOut) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const FinalIntroScreen(),
                ),
              );
            } else if (state is UserLogOutFailed) {
              showSnackBar(
                context,
                AppLocalizations.of(context)!.logOutFailed,
              );
            }
          },
          child: SafeArea(
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
                  SizedBox(
                    height: 120,
                    child: BlocBuilder<UserBloc, UserState>(
                      buildWhen: (previous, current) =>
                          current is FetchedTherapyRecords,
                      builder: (context, state) {
                        if (state is FetchedTherapyRecords) {
                          if (state.records.isNotEmpty) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.records.length,
                              itemBuilder: (context, index) {
                                return DailyMedicationIndicatorContainer(
                                  record: state.records[index],
                                );
                              },
                            );
                          } else {
                            return Container(
                              decoration: BoxDecoration(
                                gradient: containerColorGradient,
                                borderRadius: borderRadius,
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .noRegisteredTherapyRecord,
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              ),
                            );
                          }
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 160,
                    child: BlocBuilder<UserBloc, UserState>(
                      buildWhen: (previous, current) =>
                          current is FetchedTodayGlucoseReadingsSuccess,
                      builder: (context, state) {
                        if (state is! FetchedTodayGlucoseReadingsSuccess) {
                          return Container();
                        } else {
                          if (state.readings.isNotEmpty) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.readings.length,
                              itemBuilder: (context, index) {
                                return DailyGlucoseIndicatorContainer(
                                  glucoseReading: state.readings[index],
                                );
                              },
                            );
                          } else {
                            return Container(
                              decoration: BoxDecoration(
                                gradient: containerColorGradient,
                                borderRadius: borderRadius,
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .noGlucoseReadingsToday,
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: BlocBuilder<UserBloc, UserState>(
                      buildWhen: (previous, current) =>
                          current is FetchedTodayGlucoseReadingsSuccess,
                      builder: (context, state) {
                        if (state is FetchedTodayGlucoseReadingsSuccess) {
                          return DiagramContainer(
                            backgroundColor: orangeColor.withOpacity(0.8),
                            diagramTitle:
                                AppLocalizations.of(context)!.glucoseDiagram,
                            isDiagramScreen: false,
                            toolTipColor: orangeColor,
                            timePeriodType: TimePeriodType.today,
                            readings: state.readings,
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  void logOut() {
    BlocProvider.of<AuthBloc>(context).add(UserLogOut());
  }
}
