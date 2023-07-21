import 'package:diabuddy/bloc/user/user_bloc.dart';
import 'package:diabuddy/bloc/user/user_event.dart';
import 'package:diabuddy/bloc/user/user_state.dart';
import 'package:diabuddy/model/enitity/user_model.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/screens/reusable/app_number_input_field.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GlucoseTargetOnboardingScreen extends StatefulWidget {
  const GlucoseTargetOnboardingScreen({Key? key}) : super(key: key);

  @override
  State<GlucoseTargetOnboardingScreen> createState() =>
      _GlucoseTargetOnboardingScreenState();
}

class _GlucoseTargetOnboardingScreenState
    extends State<GlucoseTargetOnboardingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController chGlucoseController;
  late TextEditingController amGlucoseController;
  late TextEditingController bmGlucoseController;
  late TextEditingController lGlucoseController;
  late TextEditingController clGlucoseController;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(GetGlucoseTargets());
    chGlucoseController = TextEditingController();
    bmGlucoseController = TextEditingController();
    amGlucoseController = TextEditingController();
    lGlucoseController = TextEditingController();
    clGlucoseController = TextEditingController();
  }

  @override
  void dispose() {
    chGlucoseController.dispose();
    amGlucoseController.dispose();
    bmGlucoseController.dispose();
    lGlucoseController.dispose();
    clGlucoseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        AppLocalizations.of(context)!
                            .glucoseTargetOnboardingTitle,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        AppLocalizations.of(context)!
                            .glucoseTargetOnboardingBodyText,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      buildGlucoseInputFields(context),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AppButton(
                callback: () {
                  saveGlucoseTargets();
                },
                text: AppLocalizations.of(context)!.save,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Form buildGlucoseInputFields(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocBuilder<UserBloc, UserState>(
        builder: (BuildContext context, state) {
          chGlucoseController.text = "15.4";
          amGlucoseController.text = "8.8";
          bmGlucoseController.text = "5.5";
          lGlucoseController.text = "3.9";
          clGlucoseController.text = "2.8";
          if (state is FetchedGlucoseTargets) {
            chGlucoseController.text =
                state.glucoseTargets.criticalHigh.toString();
            amGlucoseController.text =
                state.glucoseTargets.afterMeal.toString();
            bmGlucoseController.text =
                state.glucoseTargets.beforeMeal.toString();
            lGlucoseController.text = state.glucoseTargets.low.toString();
            clGlucoseController.text =
                state.glucoseTargets.criticalLow.toString();
            return Column(
              children: [
                AppNumberInputField(
                  text: AppLocalizations.of(context)!.criticalHigh,
                  containerColor: highSugarColor,
                  controller: chGlucoseController,
                  initialValue: chGlucoseController.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "You must fill this field";
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                AppNumberInputField(
                  text: AppLocalizations.of(context)!.afterMeal,
                  containerColor: goodSugarColor,
                  controller: amGlucoseController,
                  containerBorderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                  initialValue: amGlucoseController.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "You must fill this field";
                    }
                  },
                ),
                AppNumberInputField(
                  text: AppLocalizations.of(context)!.beforeMeal,
                  containerColor: goodSugarColor,
                  controller: bmGlucoseController,
                  containerBorderRadius: BorderRadius.zero,
                  initialValue: bmGlucoseController.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "You must fill this field";
                    }
                  },
                ),
                AppNumberInputField(
                  text: AppLocalizations.of(context)!.low,
                  containerColor: goodSugarColor,
                  controller: lGlucoseController,
                  containerBorderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                  initialValue: lGlucoseController.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "You must fill this field";
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                AppNumberInputField(
                  text: AppLocalizations.of(context)!.criticalLow,
                  containerColor: lowSugarColor,
                  controller: clGlucoseController,
                  textInputAction: TextInputAction.done,
                  initialValue: clGlucoseController.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "You must fill this field";
                    }
                  },
                ),
              ],
            );
          } else if (state is FetchedGlucoseTargetsFailed) {
            return Container();
          }
          return Container();
        },
      ),
    );
  }

  void saveGlucoseTargets() {
    GlucoseTargets glucoseTargets = GlucoseTargets(
      afterMeal: double.parse(amGlucoseController.text.trim()),
      beforeMeal: double.parse(bmGlucoseController.text.trim()),
      criticalHigh: double.parse(chGlucoseController.text.trim()),
      criticalLow: double.parse(clGlucoseController.text.trim()),
      low: double.parse(lGlucoseController.text.trim()),
    );
    BlocProvider.of<UserBloc>(context).add(SaveGlucoseTargets(glucoseTargets));
  }
}
