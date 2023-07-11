import 'package:diabuddy/bloc/user/user_bloc.dart';
import 'package:diabuddy/bloc/user/user_event.dart';
import 'package:diabuddy/bloc/user/user_state.dart';
import 'package:diabuddy/model/enitity/medication.dart';
import 'package:diabuddy/screens/onboarding/add_medication_screen.dart';
import 'package:diabuddy/screens/onboarding/glucose_target_onboarding_screen.dart';
import 'package:diabuddy/screens/reusable/app_add_button.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/screens/reusable/medication_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TherapyOnboardingScreen extends StatefulWidget {
  const TherapyOnboardingScreen({Key? key}) : super(key: key);

  @override
  State<TherapyOnboardingScreen> createState() =>
      _TherapyOnboardingScreenState();
}

class _TherapyOnboardingScreenState extends State<TherapyOnboardingScreen> {
  late List<Medication> medicine = [];

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
                        );
                      },
                    ),
                  );
                }
              }),
              const Spacer(),
              AppButton(
                callback: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const GlucoseTargetOnboardingScreen()),);
                },
                text: AppLocalizations.of(context)!.next,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
