// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import '../../data/repositories/auth_repository.dart';
// import 'base_form_viewmodel.dart';

// class SignupViewModel extends BaseFormViewModel {
//   final AuthRepository _authRepository;

//   SignupViewModel(this._authRepository);

//   Future<void> signup() async {
//     isLoading = true;
//     errorMessage = null;

//     try {
//       final result = await _authRepository.signup(username, password);

//       if (result['error'] == false) {
//         Get.offAllNamed('/home');
//       } else {
//         errorMessage = result['message'];
//         Get.snackbar(
//           'Erro',
//           result['message'],
//           backgroundColor: const Color(0xffFF0000),
//           colorText: const Color(0xffFFFFFF),
//         );
//       }
//     } catch (e) {
//       errorMessage = 'Erro ao realizar cadastro: $e';
//       Get.snackbar(
//         'Erro',
//         'Erro ao realizar cadastro: $e',
//         backgroundColor: const Color(0xffFF0000),
//         colorText: const Color(0xffFFFFFF),
//       );
//     } finally {
//       isLoading = false;
//     }
//   }
// }
