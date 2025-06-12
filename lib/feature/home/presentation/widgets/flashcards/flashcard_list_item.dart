import 'package:flutter/material.dart';
import 'package:pomodoro_app/core/consts/app_colors.dart';
import 'package:pomodoro_app/feature/home/domain/models/flashcard.dart';

class FlashcardListItem extends StatelessWidget {
  final Flashcard flashcard;
  final VoidCallback onEdit;

  const FlashcardListItem({
    super.key,
    required this.flashcard,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: const Color(0xff336E6C),
      child: ListTile(
        title: Text(
          flashcard.question,
          style: const TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          flashcard.response,
          style: const TextStyle(
            color: Color(0xff73ECBF),
            fontSize: 14,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.edit,
            color: Color(0xff73ECBF),
          ),
          onPressed: onEdit,
        ),
      ),
    );
  }
}
