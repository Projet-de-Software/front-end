import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../data/repositories/auth_repository.dart';
import 'base_form_viewmodel.dart';

class LoginViewModel extends BaseFormViewModel {
  final AuthRepository _authRepository;

  LoginViewModel(this._authRepository);

  Future<void> login() async {
    isLoading = true;
    errorMessage = null;

    try {
      final result = await _authRepository.login(username, password);

      if (result['error'] == false) {
        Get.offAllNamed('/home');
      } else {
        errorMessage = result['message'];
        print(result['message']);
        Get.snackbar(
          'Erro',
          result['message'],
          backgroundColor: const Color(0xffFF0000),
          colorText: const Color(0xffFFFFFF),
        );
      }
    } catch (e) {
      errorMessage = 'Erro ao realizar login: $e';
      print('Erro ao realizar login: $e');
      Get.snackbar(
        'Erro',
        'Erro ao realizar login: $e',
        backgroundColor: const Color(0xffFF0000),
        colorText: const Color(0xffFFFFFF),
      );
    } finally {
      isLoading = false;
    }
  }
}
