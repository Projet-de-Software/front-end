import 'package:flutter/material.dart';
import 'package:pomodoro_app/core/consts/app_colors.dart';
import 'package:pomodoro_app/feature/home/domain/models/flashcard.dart';

class FlashcardListItem extends StatelessWidget {
  final Flashcard flashcard;
  final VoidCallback? onEdit;

  const FlashcardListItem({
    super.key,
    required this.flashcard,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withAlpha(50),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: const Text(
              'Pergunta',
              style: TextStyle(
                color: AppColors.backgroundColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              flashcard.question,
              style: const TextStyle(
                color: AppColors.primaryTextColor,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.secondColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Resposta',
                  style: TextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  flashcard.response,
                  style: const TextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: onEdit,
                      icon: const Icon(
                        Icons.edit,
                        color: AppColors.primaryTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
