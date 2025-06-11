import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../auth/data/repositories/auth_repository.dart';

class PerfilViewModel extends GetxController {
  final AuthRepository _authRepository;
  final _isLoading = false.obs;

  PerfilViewModel(this._authRepository);

  bool get isLoading => _isLoading.value;

  Future<void> logout() async {
    _isLoading.value = true;

    try {
      await _authRepository.logout();
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Erro ao realizar logout: $e',
        backgroundColor: const Color(0xffFF0000),
        colorText: const Color(0xffFFFFFF),
      );
    } finally {
      _isLoading.value = false;
    }
  }
}
