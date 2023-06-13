import 'package:diabuddy/extensions/string_extenstions.dart';
import 'package:diabuddy/screens/onboarding/login_screen.dart';
import 'package:diabuddy/screens/reusable/app_button.dart';
import 'package:diabuddy/screens/reusable/app_icon_button.dart';
import 'package:diabuddy/screens/reusable/app_text_field_input.dart';
import 'package:diabuddy/theme/colours.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController repeatPasswordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    repeatPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    repeatPasswordController.dispose();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context)!.createAccount,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AppTextFieldInput(
                        hintText: AppLocalizations.of(context)!.fullName,
                        controller: nameController,
                        validator: (value) {
                          if (value == null) {
                            return '';
                          } else if (value.isEmpty) {
                            return 'You must full name';
                          }
                          return value;
                        },
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      AppTextFieldInput(
                        hintText: AppLocalizations.of(context)!.email,
                        controller: emailController,
                        validator: (value) {
                          if (value == null) {
                            return 'You must enter email';
                          } else if (value.isEmpty) {
                            return 'You must enter email';
                          } else if (!value.isValidEmail()) {
                            return 'Email pattern is wrong';
                          }
                          return value;
                        },
                        textInputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      AppTextFieldInput(
                        hintText: AppLocalizations.of(context)!.password,
                        isPasswordField: true,
                        controller: passwordController,
                        validator: (value) {
                          if (value == null) {
                            return 'You must enter password';
                          } else if (value.isEmpty) {
                            return 'You must enter password';
                          } else if (!value.isValidPassword()) {
                            return 'Password must contain at least one big, '
                                'one small letter and one number';
                          }
                          return value;
                        },
                        textInputType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      AppTextFieldInput(
                        hintText: AppLocalizations.of(context)!.repeatPassword,
                        isPasswordField: true,
                        textInputAction: TextInputAction.done,
                        controller: repeatPasswordController,
                        validator: (value) {
                          if (value == null) {
                            return 'You must enter password';
                          } else if (value.isEmpty) {
                            return 'You must enter password';
                          } else if (!value.isValidPassword()) {
                            return 'Password must contain at least one big, '
                                'one small letter and one number';
                          } else if (value == passwordController.value.text) {
                            return 'Password arent same';
                          }
                          return value;
                        },
                        textInputType: TextInputType.visiblePassword,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 44,
              ),
              AppButton(
                callback: () {
                  if (_formKey.currentState!.validate()) {}
                },
                text: AppLocalizations.of(context)!.signUp,
              ),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            AppLocalizations.of(context)!.alreadyHaveAnAccount,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      const TextSpan(text: '  '),
                      TextSpan(
                        text: AppLocalizations.of(context)!.logIn,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: primaryColor,
                            ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
