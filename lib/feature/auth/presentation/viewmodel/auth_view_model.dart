import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodoro_app/feature/auth/data/repositories/auth_repository.dart';
import 'package:pomodoro_app/feature/home/data/factories/task_services_factory.dart';
import 'package:pomodoro_app/feature/home/domain/services/task_services.dart';

class AuthViewModel extends GetxController {
  final AuthRepository _authRepository;
  final TaskServices _taskServices;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  AuthViewModel(AuthRepository authRepository)
      : _authRepository = authRepository,
        _taskServices = TaskServicesFactory.create(authRepository);

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      await _authRepository.login(email, password);
      await _taskServices.getTasks(); // Carrega as tarefas após o login
      Get.offAllNamed('/home');
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Erro',
        'Não foi possível fazer login: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      await _authRepository.signup(email, password);
      await _taskServices.getTasks();
      Get.offAllNamed('/home');
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Erro',
        'Não foi possível fazer o registro: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
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
