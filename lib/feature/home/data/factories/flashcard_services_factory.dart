import 'package:pomodoro_app/feature/auth/data/repositories/auth_repository.dart';
import 'package:pomodoro_app/feature/home/data/services/flashcard_api_services.dart';
import 'package:pomodoro_app/feature/home/domain/services/flashcard_services.dart';

class FlashcardServicesFactory {
  static FlashcardServices create(AuthRepository authRepository) {
    return FlashcardApiServices(authRepository);
  }
}
