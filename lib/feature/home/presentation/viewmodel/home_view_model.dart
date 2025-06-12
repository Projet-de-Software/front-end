import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodoro_app/feature/auth/data/repositories/auth_repository.dart';
import 'package:pomodoro_app/feature/home/presentation/viewmodel/calendar_view_model.dart';

class HomeViewModel extends GetxController {
  final AuthRepository _authRepository;
  final RxInt currentIndex = 0.obs;

  HomeViewModel(this._authRepository);

  void changeIndex(int index) {
    currentIndex.value = index;

    // Se o usuário estiver indo para a tela de calendário (índice 1), carrega as tasks
    if (index == 3) {
      Get.find<CalendarViewModel>().loadTasks();
    }
  }

  Future<void> logout() async {
    try {
      await _authRepository.logout();
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Não foi possível fazer logout: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
