import 'package:get/get.dart';
import 'package:pomodoro_app/feature/home/data/factories/flashcard_services_factory.dart';
import 'package:pomodoro_app/feature/home/domain/models/flashcard.dart';
import 'package:pomodoro_app/feature/home/domain/services/flashcard_services.dart';

class FlashcardsViewModel extends GetxController {
  final FlashcardServices _service = FlashcardServicesFactory.create();
  final RxList<Flashcard> flashcards = <Flashcard>[].obs;
  final RxBool isLoading = false.obs;
  final RxInt currentIndex = 0.obs;
  final RxBool showAnswer = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadFlashcards();
  }

  Future<void> loadFlashcards() async {
    isLoading.value = true;
    try {
      final loadedFlashcards = await _service.getFlashcards();
      flashcards.value = loadedFlashcards;
    } catch (e) {
      // TODO: Implementar tratamento de erro
      print('Erro ao carregar flashcards: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void toggleAnswer() {
    showAnswer.value = !showAnswer.value;
  }

  void nextCard() {
    if (currentIndex.value < flashcards.length - 1) {
      currentIndex.value++;
      showAnswer.value = false;
    }
  }

  void previousCard() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      showAnswer.value = false;
    }
  }

  Flashcard? get currentCard {
    if (flashcards.isEmpty) return null;
    return flashcards[currentIndex.value];
  }
}
