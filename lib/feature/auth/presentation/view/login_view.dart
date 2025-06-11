import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodoro_app/feature/auth/presentation/widgets/custom_buttom.dart';
import 'package:pomodoro_app/feature/auth/presentation/widgets/custom_text_field_login.dart';
import '../../../../core/consts/app_colors.dart';
import '../viewmodels/login_viewmodel.dart';

class LoginView extends GetView<LoginViewModel> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Bem-vindo ao\nFocus App',
                    style: TextStyle(
                      color: AppColors.primaryTextColor,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  CustomTextFieldForm(
                    controller: controller,
                    labelText: 'Usuário',
                    onChanged: (value) => controller.username = value,
                    validatorMsg: 'Por favor, insira seu usuário',
                  ),
                  const SizedBox(height: 16),
                  CustomTextFieldForm(
                    controller: controller,
                    labelText: 'Senha',
                    validatorMsg: 'Por favor, insira sua senha',
                    onChanged: (value) => controller.password = value,
                    obscureText: true,
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                    controller: controller,
                    onPressed: controller.login,
                    text: 'Entrar',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
