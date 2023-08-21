import 'package:diabuddy/app/my_app.dart';
import 'package:diabuddy/preferences/user_simple_preferences.dart';
import 'package:diabuddy/screens/onboarding/components/app_choice_container_controller.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  late bool isEnglish;

  @override
  void initState() {
    super.initState();
    isEnglish = UserSimplePreferences.getLanguagePreferences() ?? true;
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
                  AppLocalizations.of(context)!.language,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 50,
                ),
                const SizedBox(
                  height: 20,
                ),
                AppChoiceContainerController(
                  isFirstChoice: isEnglish,
                  firstChoiceText: AppLocalizations.of(context)!.english,
                  secondChoiceText: AppLocalizations.of(context)!.serbian,
                  setChoice: setEnglishPreferences,
                ),
                const Spacer(),
                AppButton(
                  callback: () {
                    changeLanguage();
                    Navigator.pop(context);
                  },
                  text: AppLocalizations.of(context)!.save,
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  void setEnglishPreferences(bool value) {
    setState(() {
      isEnglish = value;
    });
    UserSimplePreferences.setLanguagePreferences(value);
  }

  void changeLanguage() {
    MyApp.setLocale(context, Locale(isEnglish ? 'en' : 'sr'));
  }
}
