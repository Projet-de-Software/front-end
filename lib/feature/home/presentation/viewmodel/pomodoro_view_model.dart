import 'dart:async';
import 'package:get/get.dart';

class PomodoroViewModel extends GetxController {
  final RxBool isRunning = false.obs;
  final RxInt minutes = 25.obs;
  final RxInt seconds = 0.obs;
  Timer? timer;

  void toggleTimer() {
    if (isRunning.value) {
      pauseTimer();
    } else {
      startTimer();
    }
  }

  void startTimer() {
    isRunning.value = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value > 0) {
        seconds.value--;
      } else if (minutes.value > 0) {
        minutes.value--;
        seconds.value = 59;
      } else {
        pauseTimer();
      }
    });
  }

  void pauseTimer() {
    isRunning.value = false;
    timer?.cancel();
  }

  void resetTimer() {
    pauseTimer();
    minutes.value = 25;
    seconds.value = 0;
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
