import 'package:diabuddy/model/enitity/medication.dart';
import 'package:diabuddy/screens/glucose_monitoring/components/medication_setup_container.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MedicationSetupScreen extends StatelessWidget {
  const MedicationSetupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Medication> medicine = [
      Medication(
        medicineName: 'NovoRapid',
        dailyMedicationIntake: 3,
        isInsulin: true,
        averageInsulinUnits: 10,
      ),
      Medication(
        medicineName: 'Tresiba',
        dailyMedicationIntake: 1,
        isInsulin: true,
        averageInsulinUnits: 24,
      ),
      Medication(
        medicineName: 'Glucagon-like peptide',
        dailyMedicationIntake: 5,
        isInsulin: false,
      ),
    ];

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
                  AppLocalizations.of(context)!.chooseYourMedicationForThisMeal,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: medicine.length,
                    itemBuilder: (context, index) {
                      return MedicationSetupContainer(medication: medicine[index],);
                    },
                  ),
                ),
                AppButton(
                  callback: () {},
                  text: AppLocalizations.of(context)!.add,
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
