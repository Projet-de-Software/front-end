import 'package:pomodoro_app/feature/home/domain/models/flashcard.dart';

abstract class FlashcardServices {
  Future<List<Flashcard>> getFlashcards();
  Future<Flashcard> getFlashcardById(String id);
  Future<void> addFlashcard(Flashcard flashcard);
  Future<void> updateFlashcard(Flashcard flashcard);
  Future<void> deleteFlashcard(String id);
}
