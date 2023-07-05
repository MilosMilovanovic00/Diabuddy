import 'package:diabuddy/model/enitity/enum/time_period_type.dart';
import 'package:diabuddy/screens/dashboard/components/diagram_container.dart';
import 'package:diabuddy/screens/dashboard/time_period_selector.dart';
import 'package:diabuddy/screens/reusable/app_bottom_navigation_bar.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiagramScreen extends StatefulWidget {
  const DiagramScreen({Key? key}) : super(key: key);

  @override
  State<DiagramScreen> createState() => _DiagramScreenState();
}

class _DiagramScreenState extends State<DiagramScreen> {
  late TimePeriodType timePeriodType=TimePeriodType.today;

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
                'Diabuddy',
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 40,
                ),
                TimePeriodSelector(
                  callback: setTimePeriod,
                  timePeriodType: timePeriodType,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.7),
                    borderRadius: borderRadius,
                  ),
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.averageBloodGlucose,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(fontSize: 22),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "6.5 mmol/L",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(fontSize: 34),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: DiagramContainer(
                    backgroundColor: primaryColor.withOpacity(0.7),
                    diagramTitle:
                        getDiagramByTimePeriodType(context, timePeriodType),
                    isDiagramScreen: true,
                    toolTipColor: primaryColor,
                    timePeriodType: timePeriodType,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  void setTimePeriod(TimePeriodType type) {
    setState(() {
      timePeriodType = type;
    });
  }
}
