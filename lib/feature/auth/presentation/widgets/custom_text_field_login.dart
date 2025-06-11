import 'package:flutter/material.dart';
import 'package:pomodoro_app/core/consts/app_colors.dart';
import 'package:pomodoro_app/feature/auth/presentation/viewmodels/base_form_viewmodel.dart';

class CustomTextFieldForm extends StatelessWidget {
  const CustomTextFieldForm({
    super.key,
    required this.controller,
    required this.labelText,
    this.onChanged,
    required this.validatorMsg,
    this.obscureText = false,
  });

  final String labelText;
  final Function(String)? onChanged;
  final String validatorMsg;
  final bool obscureText;
  final BaseFormViewModel controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: AppColors.primaryTextColor,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: AppColors.subtitleColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.secondColor,
            width: 2,
          ),
        ),
      ),
      obscureText: obscureText,
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorMsg;
        }
        return null;
      },
    );
  }
}
