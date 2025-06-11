import 'package:get/get.dart';

abstract class BaseFormViewModel extends GetxController {
  final _isLoading = false.obs;
  final _errorMessage = RxnString();
  final _username = ''.obs;
  final _password = ''.obs;

  bool get isLoading => _isLoading.value;
  String? get errorMessage => _errorMessage.value;
  String get username => _username.value;
  String get password => _password.value;

  set username(String value) => _username.value = value;
  set password(String value) => _password.value = value;
  set isLoading(bool value) => _isLoading.value = value;
  set errorMessage(String? value) => _errorMessage.value = value;
}
