import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodoro_app/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // Inicializa o GetX
    await Get.putAsync<SharedPreferences>(() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs;
    }, permanent: true);

    runApp(const MyApp());
  } catch (e) {
    debugPrint('Erro na inicialização: $e');
    rethrow;
  }
}
