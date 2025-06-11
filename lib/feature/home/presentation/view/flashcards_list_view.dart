import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodoro_app/core/consts/app_colors.dart';
import 'package:pomodoro_app/feature/auth/data/repositories/auth_repository.dart';
import 'package:pomodoro_app/feature/home/presentation/viewmodel/flashcards_list_viewmodel.dart';
import 'package:pomodoro_app/feature/home/presentation/widgets/flashcards/flashcard_list_item.dart';

class FlashcardsListView extends StatelessWidget {
  const FlashcardsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(FlashcardsListViewModel(Get.find<AuthRepository>()));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos os FlashCards'),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }

          if (controller.errorMessage.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: AppColors.errorColor,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    controller.errorMessage.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.errorColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: controller.loadFlashcards,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                    ),
                    child: const Text(
                      'Tentar Novamente',
                      style: TextStyle(
                        color: AppColors.backgroundColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (controller.flashcards.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum flashcard disponível',
                style: TextStyle(
                  color: AppColors.primaryTextColor,
                  fontSize: 18,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: controller.flashcards.length,
            itemBuilder: (context, index) {
              final flashcard = controller.flashcards[index];
              return FlashcardListItem(
                flashcard: flashcard,
                onEdit: () => controller.startEditing(flashcard),
              );
            },
          );
        }),
      ),
    );
  }
}
