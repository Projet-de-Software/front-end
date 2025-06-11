import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pomodoro_app/core/consts/app_colors.dart';
import 'package:pomodoro_app/core/consts/app_route.dart';
import 'package:pomodoro_app/feature/auth/data/repositories/auth_repository.dart';
import 'package:pomodoro_app/feature/home/presentation/view/calendar_view.dart';
import 'package:pomodoro_app/feature/home/presentation/view/flashcards_view.dart';
import 'package:pomodoro_app/feature/home/presentation/view/monitoramento_view.dart';
import 'package:pomodoro_app/feature/home/presentation/view/perfil_view.dart';
import 'package:pomodoro_app/feature/home/presentation/view/pomodoro_view.dart';
import 'package:pomodoro_app/feature/home/presentation/viewmodel/home_view_model.dart';
import 'package:pomodoro_app/feature/home/presentation/viewmodel/flashcards_list_viewmodel.dart';
// Importe as views para as outras páginas aqui, se existirem (ex: import '../tasks/view/tasks_view.dart';)

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeViewModel>();
    final authRepository = Get.find<AuthRepository>();

    // Registra o FlashcardsListViewModel se ainda não estiver registrado
    if (!Get.isRegistered<FlashcardsListViewModel>()) {
      Get.put(FlashcardsListViewModel(authRepository));
    }

    final List<String> icons = [
      'assets/icons/home.svg',
      'assets/icons/flashcards.svg',
      'assets/icons/monitoramento.svg',
      'assets/icons/calendar.svg',
      'assets/icons/user.svg',
      'assets/icons/home_select.svg',
      'assets/icons/flashcard_select.svg',
      'assets/icons/monitoramento_select.svg',
      'assets/icons/calendar_select.svg',
      'assets/icons/user_select.svg',
    ];

    final List<String> appBarTitles = [
      'Pomodoro',
      'FlashCards',
      'Monitoramento',
      'Calendário',
      'Perfil',
    ];

    // Placeholder views para as 5 páginas. Substitua com suas views reais.
    final List<Widget> pages = [
      const PomodoroView(),
      const FlashcardsView(),
      const MonitoramentoView(),
      const CalendarView(),
      const PerfilView(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            appBarTitles[controller.currentIndex.value],
            style:
                const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Obx(() {
            if (controller.currentIndex.value == 1) {
              return Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.list),
                    onPressed: () => Get.toNamed(AppRoute.flashcardsList),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      final flashcardsController =
                          Get.find<FlashcardsListViewModel>();
                      flashcardsController.showAddFlashcardDialog();
                    },
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          }),
        ],
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
                semanticsLabel: 'Monitor',
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                icons[7],
                semanticsLabel: 'Monitoramento Selected',
                colorFilter: const ColorFilter.mode(
                  Color(0xFFC8E6C9),
                  BlendMode.srcIn,
                ),
              ),
              label: 'Monitor',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                icons[3],
                semanticsLabel: 'Calendar',
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                icons[8],
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
