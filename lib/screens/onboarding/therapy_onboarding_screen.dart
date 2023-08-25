import 'package:diabuddy/bloc/user/user_bloc.dart';
import 'package:diabuddy/bloc/user/user_event.dart';
import 'package:diabuddy/bloc/user/user_state.dart';
import 'package:diabuddy/screens/onboarding/add_medication_screen.dart';
import 'package:diabuddy/screens/onboarding/glucose_target_onboarding_screen.dart';
import 'package:diabuddy/screens/reusable/app_add_button.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/screens/reusable/dialog.dart';
import 'package:diabuddy/screens/reusable/medication_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TherapyOnboardingScreen extends StatefulWidget {
  const TherapyOnboardingScreen({
    Key? key,
    this.fromSettings = false,
  }) : super(key: key);

  final bool fromSettings;

  @override
  State<TherapyOnboardingScreen> createState() =>
      _TherapyOnboardingScreenState();
}

class _TherapyOnboardingScreenState extends State<TherapyOnboardingScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(GetAllMedications());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
              Navigator.pop(context);
            },
            icon: Icons.arrow_back_ios_new,
          ),
        ),
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (BuildContext context, state) {
          if (state is DeletedMedication) {
            BlocProvider.of<UserBloc>(context).add(GetAllMedications());
          } else if (state is DeletingMedicationFailed) {
            showSnackBar(
              context,
              AppLocalizations.of(context)!.deletingMedicationFailed,
            );
          } else if (state is DeletingMedicationNotificationsFailed) {
            showSnackBar(
              context,
              AppLocalizations.of(context)!
                  .deletingMedicationNotificationsFailed,
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  AppLocalizations.of(context)!.therapyOnboardingTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  AppLocalizations.of(context)!.therapyOnboardingBodyText,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 20,
                ),
                AppAddButton(
                  text: AppLocalizations.of(context)!.addMedication,
                  callback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddMedicationScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                  if (state is! FetchedMedicationData) {
                    return Container();
                  } else {
                    return SizedBox(
                      height: 330,
                      child: ListView.builder(
                        itemCount: state.medicine.length,
                        itemBuilder: (context, index) {
                          return MedicationContainer(
                            medication: state.medicine[index],
                            deleteMedication: deleteMedication,
                          );
                        },
                      ),
                    );
                  }
                }),
                const Spacer(),
                AppButton(
                  callback: () {
                    if (widget.fromSettings) {
                      Navigator.pop(context);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const GlucoseTargetOnboardingScreen(),
                        ),
                      );
                    }
                  },
                  text: AppLocalizations.of(context)!.save,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteMedication(String medicationId) {
    BlocProvider.of<UserBloc>(context).add(
      DeleteMedicationNotifications(medicationId),
    );
    BlocProvider.of<UserBloc>(context).add(
      DeleteMedication(
        medicationId: medicationId,
      ),
    );
    //TODO Obrisi notifikacije
  }
}
