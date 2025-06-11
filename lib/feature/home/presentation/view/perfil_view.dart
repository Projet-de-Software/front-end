import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/consts/app_colors.dart';
import '../viewmodel/perfil_viewmodel.dart';

class PerfilView extends GetView<PerfilViewModel> {
  const PerfilView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Perfil',
                style: TextStyle(
                  color: AppColors.primaryTextColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 48),
              Obx(() => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: controller.isLoading ? 50 : 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed:
                          controller.isLoading ? null : controller.logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            controller.isLoading ? 25 : 8,
                          ),
                        ),
                      ),
                      child: controller.isLoading
                          ? const CircularProgressIndicator(
                              color: AppColors.backgroundColor,
                            )
                          : const Text(
                              'Sair da Conta',
                              style: TextStyle(
                                color: AppColors.backgroundColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
