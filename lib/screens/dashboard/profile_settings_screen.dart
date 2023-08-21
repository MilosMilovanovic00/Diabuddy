import 'package:diabuddy/bloc/user/user_bloc.dart';
import 'package:diabuddy/bloc/user/user_event.dart';
import 'package:diabuddy/bloc/user/user_state.dart';
import 'package:diabuddy/screens/onboarding/components/simple_app_container.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/screens/reusable/app_number_picker.dart';
import 'package:diabuddy/screens/reusable/app_text_field_input.dart';
import 'package:diabuddy/screens/reusable/dialog.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late int weight;

  @override
  void initState() {
    super.initState();
    weight = 45;
    nameController = TextEditingController();
    BlocProvider.of<UserBloc>(context).add(GetUserProfileData());
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
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
        body: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserProfileUpdateSuccessful) {
              Navigator.pop(context);
            } else {
              showSnackBar(
                context,
                AppLocalizations.of(context)!.updatingProfileFailed,
              );
            }
          },
          builder: (BuildContext context, state) {
            if (state is FetchedUserData) {
              nameController.text = state.user.fullName ?? "";
              weight = state.user.weight ?? 45;
            }
            return SafeArea(
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
                      AppLocalizations.of(context)!.profileUpdate,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AppTextFieldInput(
                            hintText: AppLocalizations.of(context)!.fullName,
                            controller: nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .youMustEnterFullName;
                              }
                              return null;
                            },
                            textInputType: TextInputType.text,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SimpleAppContainer(
                      text: AppLocalizations.of(context)!.weight,
                      widget: AppNumberPicker(
                        minValue: 0,
                        maxValue: 100,
                        currentValue: weight,
                        setCurrentValue: setWeight,
                      ),
                    ),
                    const Spacer(),
                    AppButton(
                      callback: () {
                        updateProfile();
                      },
                      text: AppLocalizations.of(context)!.save,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ]);
  }

  void setWeight(int value) {
    weight = value;
  }

  void updateProfile() {
    BlocProvider.of<UserBloc>(context).add(UpdateUserData(
      weight,
      nameController.text.trim(),
    ));
  }
}
