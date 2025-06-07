import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodoro_app/core/consts/app_route.dart';
import 'package:pomodoro_app/core/theme/theme_app.dart';
import 'package:pomodoro_app/feature/home/presentation/view/home_view.dart';
import 'package:pomodoro_app/feature/home/presentation/view/pomodoro_view.dart';
import 'package:pomodoro_app/feature/home/presentation/viewmodel/home_view_model.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Inicializando o controller antes da construção do app
    Get.put(HomeViewModel());

    return GetMaterialApp(
      title: 'Pomodoro App',
      theme: ThemeApp.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.home,
      getPages: [
        GetPage(name: AppRoute.home, page: () => HomeView()),
        GetPage(name: AppRoute.pomodoro, page: () => PomodoroView()),
      ],
    );
  }
}
