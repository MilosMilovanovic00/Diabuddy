import 'package:diabuddy/screens/onboarding/simple_app_container.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_dropdown_container.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/screens/reusable/app_number_picker.dart';
import 'package:diabuddy/screens/reusable/app_text_field_input.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddActivityScreen extends StatefulWidget {
  const AddActivityScreen({Key? key}) : super(key: key);

  @override
  State<AddActivityScreen> createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController activityNameController;

  String activity = '';
  int activityDuration = 0;

  @override
  void initState() {
    super.initState();
    activityNameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    activityNameController.dispose();
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
                  AppLocalizations.of(context)!.addYourActivity,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: AppTextFieldInput(
                    hintText: AppLocalizations.of(context)!.activityName,
                    controller: activityNameController,
                    validator: (value) {
                      if (value == null) {
                        return '';
                      } else if (value.isEmpty) {
                        return 'You must enter activity name';
                      }
                      return value;
                    },
                    textInputType: TextInputType.text,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.7),
                    borderRadius: borderRadius,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.activityIntensity,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: borderRadius,
                            boxShadow: [simpleBoxShadow],
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.7),
                                borderRadius: borderRadius),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: AppDropdownContainer(
                                setChoice: setActivityType,
                                choices: [
                                  AppLocalizations.of(context)!.light,
                                  AppLocalizations.of(context)!.intense,
                                  AppLocalizations.of(context)!.moderate,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SimpleAppContainer(
                  text: AppLocalizations.of(context)!.activityDuration,
                  widget: AppNumberPicker(
                    minValue: 0,
                    step: 10,
                    maxValue: 240,
                    setCurrentValue: setActivityDuration,
                  ),
                ),
                const Spacer(),
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

  void setActivityType(String activityType) {
    setState(() {
      activity = activityType;
    });
  }

  void setActivityDuration(int value) {
    setState(() {
      activityDuration = value;
    });
  }
}
