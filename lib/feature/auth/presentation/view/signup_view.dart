import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodoro_app/feature/auth/presentation/widgets/custom_buttom.dart';
import 'package:pomodoro_app/feature/auth/presentation/widgets/custom_text_field_login.dart';
import '../../../../core/consts/app_colors.dart';
import '../viewmodels/signup_viewmodel.dart';

class SignupView extends GetView<SignupViewModel> {
  const SignupView({super.key});

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
                    'Criar Conta',
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
                    onPressed: controller.signup,
                    text: 'Cadastrar',
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text(
                      'Já tem uma conta? Faça login',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                      ),
                    ),
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
