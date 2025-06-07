import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodoro_app/core/consts/app_colors.dart';
import 'package:pomodoro_app/feature/home/presentation/viewmodel/pomodoro_view_model.dart';

class PomodoroTimer extends StatelessWidget {
  const PomodoroTimer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PomodoroViewModel>();

    return Obx(
      () => Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          color: controller.isRunning.value
              ? AppColors.secondColor
              : AppColors.primaryColor,
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${controller.minutes.value.toString().padLeft(2, '0')}:${controller.seconds.value.toString().padLeft(2, '0')}',
              style: TextStyle(
                color: AppColors.secondTextColor,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'FOCUS',
              style: TextStyle(
                color: AppColors.secondTextColor,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
