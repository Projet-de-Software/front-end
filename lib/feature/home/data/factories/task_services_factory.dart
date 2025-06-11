import 'package:pomodoro_app/feature/auth/data/repositories/auth_repository.dart';
import 'package:pomodoro_app/feature/home/data/services/task_api_services.dart';
import 'package:pomodoro_app/feature/home/domain/services/task_services.dart';

class TaskServicesFactory {
  static TaskServices create(AuthRepository authRepository) {
    return TaskApiServices(authRepository);
  }
}
