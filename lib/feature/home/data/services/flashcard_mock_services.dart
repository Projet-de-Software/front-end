import 'package:pomodoro_app/feature/home/domain/models/flashcard.dart';
import 'package:pomodoro_app/feature/home/domain/services/flashcard_services.dart';

class FlashcardMockServices implements FlashcardServices {
  final List<Flashcard> _flashcards = [
    Flashcard(
      id: '1',
      question: 'O que é Flutter?',
      response:
          'Flutter é um framework de UI do Google para criar aplicativos nativos para Android, iOS, web e desktop a partir de uma única base de código.',
    ),
    Flashcard(
      id: '2',
      question: 'O que é GetX?',
      response:
          'GetX é um framework para gerenciamento de estado, injeção de dependência e navegação em aplicativos Flutter.',
    ),
    Flashcard(
      id: '3',
      question: 'O que é um Widget?',
      response:
          'Widgets são os blocos de construção básicos de interfaces de usuário em Flutter. Tudo em Flutter é um widget.',
    ),
  ];

  @override
  Future<List<Flashcard>> getFlashcards() async {
    await Future.delayed(
      const Duration(seconds: 1),
    ); // Simula delay de rede
    return _flashcards;
  }

  @override
  Future<Flashcard> getFlashcardById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _flashcards.firstWhere((flashcard) => flashcard.id == id);
  }

  @override
  Future<void> addFlashcard(Flashcard flashcard) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _flashcards.add(flashcard);
  }

  @override
  Future<void> updateFlashcard(Flashcard flashcard) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _flashcards.indexWhere((f) => f.id == flashcard.id);
    if (index != -1) {
      _flashcards[index] = flashcard;
    }
  }

  @override
  Future<void> deleteFlashcard(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _flashcards.removeWhere((flashcard) => flashcard.id == id);
  }
}
