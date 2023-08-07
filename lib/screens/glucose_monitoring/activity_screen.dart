import 'package:diabuddy/bloc/user/user_bloc.dart';
import 'package:diabuddy/bloc/user/user_event.dart';
import 'package:diabuddy/bloc/user/user_state.dart';
import 'package:diabuddy/model/enitity/activity.dart';
import 'package:diabuddy/model/enitity/enum/activity_type.dart';
import 'package:diabuddy/screens/onboarding/components/simple_app_container.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_dropdown_container.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/screens/reusable/app_number_picker.dart';
import 'package:diabuddy/screens/reusable/app_text_field_input.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({
    Key? key,
    this.activity,
    required this.glucoseReadingId,
  }) : super(key: key);

  final String glucoseReadingId;
  final Activity? activity;

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController activityNameController;

  late int duration;
  late ActivityIntensity intensity;
  late bool isEditPage;

  @override
  void initState() {
    super.initState();
    isEditPage = widget.activity != null;
    intensity =
        isEditPage ? widget.activity!.intensity : ActivityIntensity.moderate;
    activityNameController = TextEditingController();
    activityNameController.text = isEditPage ? widget.activity!.name : '';
    duration = isEditPage ? widget.activity!.duration : 30;
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
                BlocProvider.of<UserBloc>(context)
                    .add(GetGlucoseReadingById(widget.glucoseReadingId));
                Navigator.pop(context);
              },
              icon: Icons.arrow_back_ios_new,
            ),
          ),
        ),
        backgroundColor: primaryColor.withOpacity(0.10),
        body: BlocListener<UserBloc, UserState>(
          listener: (BuildContext context, state) {
            if (state is SuccessfullyUpdatedGlucoseReadingActivity) {
              BlocProvider.of<UserBloc>(context)
                  .add(GetGlucoseReadingById(widget.glucoseReadingId));
              Navigator.pop(context);
            } else if (state is UpdateGlucoseReadingActivityFailed) {
              print('jooj');
              //TODO pop up
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
                    isEditPage
                        ? AppLocalizations.of(context)!.editYourActivity
                        : AppLocalizations.of(context)!.addYourActivity,
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
                        if (value == null || value.isEmpty) {
                          return 'You must enter activity name';
                        }
                        return null;
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
                                  choice: intensity,
                                  setChoice: setActivityType,
                                  choices: getAllActivityTypes(),
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
                      currentValue: duration,
                      setCurrentValue: setActivityDuration,
                    ),
                  ),
                  const Spacer(),
                  AppButton(
                    callback: () {
                      if (_formKey.currentState!.validate()) {
                        updateActivity();
                      }
                    },
                    text: isEditPage
                        ? AppLocalizations.of(context)!.edit
                        : AppLocalizations.of(context)!.add,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  void setActivityType(dynamic activityType) {
    setState(() {
      intensity = activityType;
    });
  }

  void setActivityDuration(int value) {
    setState(() {
      duration = value;
    });
  }

  void updateActivity() {
    Activity activity = Activity(
      name: activityNameController.text.trim(),
      intensity: intensity,
      duration: duration,
    );
    BlocProvider.of<UserBloc>(context).add(UpdateGlucoseReadingActivity(
      widget.glucoseReadingId,
      activity,
    ));
  }
}
