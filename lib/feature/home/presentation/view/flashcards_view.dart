import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodoro_app/feature/home/presentation/viewmodel/flashcards_view_model.dart';
import 'package:pomodoro_app/feature/home/presentation/widgets/flashcards/flashcard_component.dart';

class FlashcardsView extends StatelessWidget {
  const FlashcardsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FlashcardsViewModel());

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.flashcards.isEmpty) {
            return const Center(
              child: Text('Nenhum flashcard disponível'),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: controller.previousCard,
                    icon: const Icon(Icons.arrow_back_ios, size: 30),
                  ),
                  IconButton(
                    onPressed: controller.toggleAnswer,
                    icon: Icon(
                      controller.showAnswer.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: controller.nextCard,
                    icon: const Icon(Icons.arrow_forward_ios, size: 30),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
