import 'package:diabuddy/bloc/user/user_bloc.dart';
import 'package:diabuddy/bloc/user/user_event.dart';
import 'package:diabuddy/bloc/user/user_state.dart';
import 'package:diabuddy/screens/glucose_monitoring/components/therapy_entry_container.dart';
import 'package:diabuddy/screens/glucose_monitoring/medication_setup_screen.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditMedicationScreen extends StatefulWidget {
  const EditMedicationScreen({
    super.key,
    required this.glucoseReadingId,
  });

  final String glucoseReadingId;

  @override
  State<EditMedicationScreen> createState() => _EditMedicationScreenState();
}

class _EditMedicationScreenState extends State<EditMedicationScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context)
        .add(GetGlucoseReadingMedication(widget.glucoseReadingId));
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
          elevation: 0,
          leadingWidth: 75,
          toolbarHeight: 70,
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 30.0,
              top: 20,
            ),
            child: AppIconButton(
              callback: () {
                BlocProvider.of<UserBloc>(context)
                    .add(GetGlucoseReadingById(widget.glucoseReadingId));
                Navigator.pop(context);
              },
              icon: Icons.arrow_back_ios_new,
            ),
          ),
        ),
        backgroundColor: primaryColor.withOpacity(0.10),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  // 'Edit your meal',
                  AppLocalizations.of(context)!.editYourMedication,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 32),
                ),
                const SizedBox(
                  height: 30,
                ),
                BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                  if (state is FetchedGlucoseReadingMedication) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.therapies.length,
                        itemBuilder: (context, index) {
                          return TherapyEntryContainer(
                            therapy: state.therapies[index],
                            deleteTherapy: () {
                              deleteTherapy(state.therapies[index].id!);
                            },
                          );
                        },
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
                const SizedBox(
                  height: 20,
                ),
                AppButton(
                  callback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MedicationSetupScreen(
                          glucoseReadingId: widget.glucoseReadingId,
                        ),
                      ),
                    );
                  },
                  text: AppLocalizations.of(context)!.addMedication,
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  void deleteTherapy(String therapyId) {
    BlocProvider.of<UserBloc>(context).add(DeleteGlucoseReadingTherapy(
      widget.glucoseReadingId,
      therapyId,
    ));
  }
}
