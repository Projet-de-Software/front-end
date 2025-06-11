import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodoro_app/feature/auth/data/repositories/auth_repository.dart';
import 'package:pomodoro_app/feature/home/presentation/viewmodel/flashcards_view_model.dart';
import 'package:pomodoro_app/feature/home/presentation/widgets/flashcards/flashcard_component.dart';
import 'package:pomodoro_app/feature/home/presentation/widgets/flashcards/next_or_previous_flashcard.dart';

class FlashcardsView extends StatelessWidget {
  const FlashcardsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(FlashcardsViewModel(Get.find<AuthRepository>()));

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    controller.errorMessage.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: controller.loadFlashcards,
                    child: const Text('Tentar Novamente'),
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
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: FlashcardComponent(
                  flashcard: controller.currentCard!,
                  showAnswer: controller.showAnswer.value,
                  onTap: controller.toggleAnswer,
                ),
              ),
              const SizedBox(height: 20),
              NextOrPreviousFlashcard(controller: controller),
            ],
          );
        }),
      ),
    );
  }
}
