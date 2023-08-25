import 'package:diabuddy/bloc/user/user_bloc.dart';
import 'package:diabuddy/bloc/user/user_event.dart';
import 'package:diabuddy/bloc/user/user_state.dart';
import 'package:diabuddy/model/enitity/therapy.dart';
import 'package:diabuddy/model/therapy_record.dart';
import 'package:diabuddy/screens/glucose_monitoring/components/medication_setup_container.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/screens/reusable/dialog.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MedicationSetupScreen extends StatefulWidget {
  const MedicationSetupScreen({
    Key? key,
    required this.glucoseReadingId,
    required this.newGlucoseReading,
  }) : super(key: key);

  final String glucoseReadingId;
  final bool newGlucoseReading;

  @override
  State<MedicationSetupScreen> createState() => _MedicationSetupScreenState();
}

class _MedicationSetupScreenState extends State<MedicationSetupScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(GetAllMedications());
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
                    .add(GetGlucoseReadingMedication(widget.glucoseReadingId));
                Navigator.pop(context);
              },
              icon: Icons.arrow_back_ios_new,
            ),
          ),
        ),
        backgroundColor: primaryColor.withOpacity(0.10),
        body: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is SavedGlucoseReadingTherapy) {
              BlocProvider.of<UserBloc>(context)
                  .add(GetGlucoseReadingMedication(widget.glucoseReadingId));
              Navigator.pop(context);
            } else if (state is SavingGlucoseReadingTherapyFailed) {
              showSnackBar(
                context,
                AppLocalizations.of(context)!.savingGlucoseReadingTherapyFailed,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppLocalizations.of(context)!
                        .chooseYourMedicationForThisMeal,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 32,
                        ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                    if (state is FetchedMedicationData) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: state.medicine.length,
                          itemBuilder: (context, index) {
                            return MedicationSetupContainer(
                              medication: state.medicine[index],
                              addMedication: addMedication,
                            );
                          },
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  void addMedication(Therapy therapy) {
    if (widget.newGlucoseReading) {
      TherapyRecord record = TherapyRecord(
        therapyName: therapy.name,
        isInsulin: therapy.isInsulin,
        time: DateTime.now(),
      );
      BlocProvider.of<UserBloc>(context).add(SaveTherapyRecord(record));
    }
    AddTherapyToGlucoseReading event =
        AddTherapyToGlucoseReading(therapy, widget.glucoseReadingId);
    BlocProvider.of<UserBloc>(context).add(event);
  }
}
