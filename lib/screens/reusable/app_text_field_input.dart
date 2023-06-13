import 'package:diabuddy/theme/colours.dart';
import 'package:diabuddy/theme/theme.dart';
import 'package:flutter/material.dart';

class AppTextFieldInput extends StatelessWidget {
  const AppTextFieldInput({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.validator,
    required this.textInputType,
    this.isPasswordField,
    this.textInputAction,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final TextInputAction? textInputAction;
  final bool? isPasswordField;
  final String Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction ?? TextInputAction.next,
      keyboardType: textInputType,
      validator: validator,
      obscureText: isPasswordField ?? false,
      controller: controller,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        filled: true,
        fillColor: textFieldBackgroundColor,
        errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.red,
              fontSize: 14,
            ),
        enabledBorder: textFieldBorder,
        errorBorder: textFieldBorder,
        border: textFieldBorder,
        errorMaxLines: 3,
        hintText: hintText,
        contentPadding: const EdgeInsets.only(
          left: 24,
        ),
      ),
    );
  }
}
