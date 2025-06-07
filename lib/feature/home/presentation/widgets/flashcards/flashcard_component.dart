import 'package:flutter/material.dart';
import 'package:pomodoro_app/core/consts/app_colors.dart';
import 'package:pomodoro_app/feature/home/domain/models/flashcard.dart';

class FlashcardComponent extends StatelessWidget {
  final Flashcard flashcard;
  final bool showAnswer;
  final VoidCallback onTap;

  const FlashcardComponent({
    super.key,
    required this.flashcard,
    required this.showAnswer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(100),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              showAnswer ? flashcard.response : flashcard.question,
              style: const TextStyle(
                color: AppColors.secondTextColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              showAnswer
                  ? 'Toque para ver a pergunta'
                  : 'Toque para ver a resposta',
              style: TextStyle(color: AppColors.quintoColor, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
