import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodoro_app/feature/home/presentation/viewmodel/pomodoro_view_model.dart';
import 'package:pomodoro_app/feature/home/presentation/widgets/pomodoro.dart/pomodoro_timer.dart';

class PomodoroView extends StatelessWidget {
  const PomodoroView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PomodoroViewModel());

    return SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const PomodoroTimer(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => IconButton(
                    onPressed: controller.toggleTimer,
                    icon: Icon(
                      controller.isRunning.value
                          ? Icons.pause_circle_outline
                          : Icons.play_circle_outline_sharp,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                Obx(
                  () =>
                      !controller.isRunning.value &&
                          (controller.minutes.value < 25 ||
                              controller.seconds.value > 0)
                      ? IconButton(
                          onPressed: controller.resetTimer,
                          icon: const Icon(
                            Icons.restart_alt_rounded,
                            size: 40,
                            color: Colors.white,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
