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
import 'package:pomodoro_app/feature/home/presentation/view/flashcards_list_view.dart';
import 'package:pomodoro_app/feature/home/presentation/view/home_view.dart';
import 'package:pomodoro_app/feature/home/presentation/view/perfil_view.dart';
import 'package:pomodoro_app/feature/home/presentation/viewmodel/calendar_view_model.dart';
import 'package:pomodoro_app/feature/home/presentation/viewmodel/flashcards_list_viewmodel.dart';
import 'package:pomodoro_app/feature/home/presentation/viewmodel/home_view_model.dart';
import 'package:pomodoro_app/feature/home/presentation/viewmodel/perfil_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pomodoro App',
      theme: ThemeApp.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.login,
      initialBinding: InitialBinding(),
      getPages: [
        GetPage(name: AppRoute.login, page: () => const LoginView()),
        GetPage(name: AppRoute.signup, page: () => const SignupView()),
        GetPage(name: AppRoute.home, page: () => const HomeView()),
        GetPage(name: AppRoute.calendar, page: () => const CalendarView()),
        GetPage(name: AppRoute.perfil, page: () => const PerfilView()),
        GetPage(
            name: AppRoute.flashcardsList,
            page: () => const FlashcardsListView()),
      ],
    );
  }
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Inicializa SharedPreferences primeiro
    Get.putAsync<SharedPreferences>(() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs;
    }, permanent: true);

    // Inicializa AuthRepository
    Get.put(AuthRepository(Get.find<SharedPreferences>()),
        permanent: true);

    // Inicializa os ViewModels
    Get.put(LoginViewModel(Get.find<AuthRepository>()), permanent: true);
    Get.put(SignupViewModel(Get.find<AuthRepository>()), permanent: true);
    Get.put(HomeViewModel(Get.find<AuthRepository>()), permanent: true);
    Get.put(CalendarViewModel(Get.find<AuthRepository>()),
        permanent: true);
    Get.put(PerfilViewModel(Get.find<AuthRepository>()), permanent: true);
    Get.put(FlashcardsListViewModel(Get.find<AuthRepository>()),
        permanent: true);
  }
}
