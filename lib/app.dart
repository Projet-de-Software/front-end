import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodoro_app/core/consts/app_route.dart';
import 'package:pomodoro_app/core/theme/theme_app.dart';
import 'package:pomodoro_app/feature/auth/data/repositories/auth_repository.dart';
import 'package:pomodoro_app/feature/auth/presentation/view/login_view.dart';
import 'package:pomodoro_app/feature/auth/presentation/view/signup_view.dart';
import 'package:pomodoro_app/feature/auth/presentation/viewmodels/login_viewmodel.dart';
import 'package:pomodoro_app/feature/auth/presentation/viewmodels/signup_viewmodel.dart';
import 'package:pomodoro_app/feature/home/presentation/view/calendar_view.dart';
import 'package:pomodoro_app/feature/home/presentation/view/home_view.dart';
import 'package:pomodoro_app/feature/home/presentation/view/perfil_view.dart';
import 'package:pomodoro_app/feature/home/presentation/viewmodel/calendar_view_model.dart';
import 'package:pomodoro_app/feature/home/presentation/viewmodel/home_view_model.dart';
import 'package:pomodoro_app/feature/home/presentation/viewmodel/perfil_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Inicializando os controllers antes da construção do app
    Get.putAsync<SharedPreferences>(() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs;
    });

    final authRepository = AuthRepository(Get.find<SharedPreferences>());
    Get.put(authRepository);
    Get.put(LoginViewModel(authRepository));
    Get.put(SignupViewModel(authRepository));
    Get.put(HomeViewModel(authRepository));
    Get.put(CalendarViewModel(authRepository));
    Get.put(PerfilViewModel(authRepository));

    return GetMaterialApp(
      title: 'Pomodoro App',
      theme: ThemeApp.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.login,
      getPages: [
        GetPage(name: AppRoute.login, page: () => const LoginView()),
        GetPage(name: AppRoute.signup, page: () => const SignupView()),
        GetPage(name: AppRoute.home, page: () => const HomeView()),
        GetPage(name: AppRoute.calendar, page: () => const CalendarView()),
        GetPage(name: AppRoute.perfil, page: () => const PerfilView()),
      ],
    );
  }
}
