import 'package:flutter/material.dart';
import 'package:pomodoro_app/feature/home/presentation/viewmodel/flashcards_view_model.dart';

class NextOrPreviousFlashcard extends StatelessWidget {
  const NextOrPreviousFlashcard({
    super.key,
    required this.controller,
  });

  final FlashcardsViewModel controller;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
