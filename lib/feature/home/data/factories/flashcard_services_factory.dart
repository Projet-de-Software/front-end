import 'package:pomodoro_app/feature/home/data/services/flashcard_mock_services.dart';
import 'package:pomodoro_app/feature/home/domain/services/flashcard_services.dart';

class FlashcardServicesFactory {
  static FlashcardServices create() {
    // Aqui você pode adicionar lógica para decidir qual implementação usar
    // Por exemplo, baseado em uma flag de ambiente ou configuração
    return FlashcardMockServices();
  }
}
