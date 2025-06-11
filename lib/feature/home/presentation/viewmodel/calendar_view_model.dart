import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pomodoro_app/feature/auth/data/repositories/auth_repository.dart';
import 'package:pomodoro_app/feature/home/data/factories/task_services_factory.dart';
import 'package:pomodoro_app/feature/home/domain/models/task.dart';
import 'package:pomodoro_app/feature/home/domain/services/task_services.dart';

class CalendarViewModel extends GetxController {
  final TaskServices _service;
  final Rx<DateTime> focusedDay = DateTime.now().obs;
  final Rx<DateTime?> selectedDay = Rx<DateTime?>(DateTime.now());
  final RxList<Task> selectedTasks = <Task>[].obs;
  final RxList<Task> allTasks = <Task>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final AuthRepository _authRepository;

  CalendarViewModel(AuthRepository authRepository)
      : _service = TaskServicesFactory.create(authRepository),
        _authRepository = authRepository;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  Future<void> loadTasks() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final tasks = await _service.getTasks();
      allTasks.value = tasks;
      _getTasksForDay(selectedDay.value ?? DateTime.now());
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Erro',
        'Não foi possível carregar as tarefas: ${e.toString()}',
        backgroundColor: const Color(0xffFF0000),
        colorText: const Color(0xffFFFFFF),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void onDaySelected(DateTime day, DateTime focusDay) {
    if (!isSameDay(selectedDay.value, day)) {
      selectedDay.value = day;
      focusedDay.value = focusDay;
      _getTasksForDay(day);
    }
  }

  void _getTasksForDay(DateTime day) {
    selectedTasks.value = allTasks.where((task) {
      final taskDate = task.date;
      return taskDate.year == day.year &&
          taskDate.month == day.month &&
          taskDate.day == day.day;
    }).toList();
  }

  List<Task> getEventsForDay(DateTime day) {
    return allTasks.where((task) {
      final taskDate = task.date;
      return taskDate.year == day.year &&
          taskDate.month == day.month &&
          taskDate.day == day.day;
    }).toList();
  }

  void onPageChanged(DateTime focusedDay) {
    this.focusedDay.value = focusedDay;
  }

  Future<void> addTask(
      String title, String description, DateTime date) async {
    try {
      isLoading.value = true;
      final userId = await _authRepository.getUserId();
      if (userId == null) {
        throw Exception('ID do usuário não encontrado');
      }

      final task = Task(
        id: '', // O ID será gerado pelo backend
        title: title,
        description: description,
        date: date,
      );

      await _service.addTask(task);
      await loadTasks(); // Recarrega a lista de tarefas
      Get.back(); // Fecha o modal de adicionar tarefa
      Get.snackbar(
        'Sucesso',
        'Tarefa adicionada com sucesso',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Erro ao adicionar tarefa: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      isLoading.value = true;
      await _service.updateTask(task);
      await loadTasks(); // Recarrega a lista de tarefas
      Get.back(); // Fecha o modal de editar tarefa
      Get.snackbar(
        'Sucesso',
        'Tarefa atualizada com sucesso',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Erro ao atualizar tarefa: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
