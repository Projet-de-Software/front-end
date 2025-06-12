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
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
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
    final prefs = Get.find<SharedPreferences>();
    Get.put<AuthRepository>(AuthRepository(prefs), permanent: true);

    // Inicializa os ViewModels
    final authRepo = Get.find<AuthRepository>();
    Get.put<LoginViewModel>(LoginViewModel(authRepo), permanent: true);
    Get.put<SignupViewModel>(SignupViewModel(authRepo), permanent: true);
    Get.put<HomeViewModel>(HomeViewModel(authRepo), permanent: true);
    Get.put<CalendarViewModel>(CalendarViewModel(authRepo),
        permanent: true);
    Get.put<PerfilViewModel>(PerfilViewModel(authRepo), permanent: true);
    Get.put<FlashcardsListViewModel>(FlashcardsListViewModel(authRepo),
        permanent: true);
  }
}
