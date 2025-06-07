import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pomodoro_app/core/consts/app_colors.dart';
import 'package:pomodoro_app/feature/home/presentation/view/flashcards_view.dart';
import 'package:pomodoro_app/feature/home/presentation/view/pomodoro_view.dart';
import 'package:pomodoro_app/feature/home/presentation/viewmodel/home_view_model.dart';
// Importe as views para as outras páginas aqui, se existirem (ex: import '../tasks/view/tasks_view.dart';)

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeViewModel>();

    final List<String> icons = [
      'assets/icons/home.svg',
      'assets/icons/flashcards.svg',
      'assets/icons/calendar.svg',
      'assets/icons/monitoramento.svg',
      'assets/icons/user.svg',
      'assets/icons/home_select.svg',
      'assets/icons/flashcard_select.svg',
      'assets/icons/calendar_select.svg',
      'assets/icons/monitoramento_select.svg',
      'assets/icons/user_select.svg',
    ];

    final List<String> appBarTitles = [
      'Pomodoro',
      'FlashCards',
      'Calendário',
      'Monitoramento',
      'Perfil',
    ];

    // Placeholder views para as 5 páginas. Substitua com suas views reais.
    final List<Widget> pages = [
      const PomodoroView(),
      const FlashcardsView(),
      const Center(child: Text('Página do Pomodoro')),
      const Center(child: Text('Página do Calendário')),
      const Center(child: Text('Página do Perfil')),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            appBarTitles[controller.currentIndex.value],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: pages,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                icons[0],
                semanticsLabel: 'Home',
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                icons[5],
                semanticsLabel: 'Home Selected',
                colorFilter: const ColorFilter.mode(
                  Color(0xFFC8E6C9),
                  BlendMode.srcIn,
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                icons[1],
                semanticsLabel: 'Flashcards',
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                icons[6],
                semanticsLabel: 'Flashcards Selected',
                colorFilter: const ColorFilter.mode(
                  Color(0xFFC8E6C9),
                  BlendMode.srcIn,
                ),
              ),
              label: 'FlashCards',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                icons[2],
                semanticsLabel: 'Calendar',
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                icons[7],
                semanticsLabel: 'Calendar Selected',
                colorFilter: const ColorFilter.mode(
                  Color(0xFFC8E6C9),
                  BlendMode.srcIn,
                ),
              ),
              label: 'Calendário',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                icons[3],
                semanticsLabel: 'Monitoramento',
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                icons[8],
                semanticsLabel: 'Monitoramento Selected',
                colorFilter: const ColorFilter.mode(
                  Color(0xFFC8E6C9),
                  BlendMode.srcIn,
                ),
              ),
              label: 'Monitoramento',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                icons[4],
                semanticsLabel: 'User',
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                icons[9],
                semanticsLabel: 'User Selected',
                colorFilter: const ColorFilter.mode(
                  Color(0xFFC8E6C9),
                  BlendMode.srcIn,
                ),
              ),
              label: 'Perfil',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.backgroundColor,
          showUnselectedLabels: false,
          elevation: 10, // Remove sombra para se parecer com a imagem
        ),
      ),
    );
  }
}
