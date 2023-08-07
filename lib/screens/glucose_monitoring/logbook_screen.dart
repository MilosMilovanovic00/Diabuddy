import 'package:diabuddy/bloc/user/user_bloc.dart';
import 'package:diabuddy/bloc/user/user_event.dart';
import 'package:diabuddy/bloc/user/user_state.dart';
import 'package:diabuddy/model/enitity/glucose_reading.dart';
import 'package:diabuddy/screens/glucose_monitoring/components/glucose_entry_container.dart';
import 'package:diabuddy/screens/reusable/app_bottom_navigation_bar.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogBookScreen extends StatefulWidget {
  const LogBookScreen({Key? key}) : super(key: key);

  @override
  State<LogBookScreen> createState() => _LogBookScreenState();
}

class _LogBookScreenState extends State<LogBookScreen> {
  late List<GlucoseReading> glucoseReadings = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(GetAllGlucoseReadings());
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
          title: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                AppLocalizations.of(context)!.logbook,
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
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is! FetchedAllGlucoseReadings) {
              return Container();
            } else {
              return SafeArea(
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
                      itemCount: state.glucoseReadings.length,
                      itemBuilder: (context, index) {
                        return GlucoseEntryContainer(
                          glucoseReading: state.glucoseReadings[index],
                        );
                      },
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    ]);
  }
}
