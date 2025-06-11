import 'package:pomodoro_app/feature/home/domain/models/task.dart';

abstract class TaskServices {
  Future<List<Task>> getTasks();
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
}
