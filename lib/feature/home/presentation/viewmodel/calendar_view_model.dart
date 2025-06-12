import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pomodoro_app/feature/auth/data/repositories/auth_repository.dart';
import 'package:pomodoro_app/feature/home/data/services/task_api_services.dart';
import 'package:pomodoro_app/feature/home/domain/models/task.dart';
import 'package:pomodoro_app/feature/home/domain/services/task_services.dart';

class CalendarViewModel extends GetxController {
  late final TaskServices _taskServices;
  final RxList<Task> tasks = <Task>[].obs;
  final RxList<Task> selectedTasks = <Task>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<DateTime> focusedDay = DateTime.now().obs;
  final Rx<DateTime?> selectedDay = Rx<DateTime?>(DateTime.now());
  final Rx<CalendarFormat> calendarFormat = CalendarFormat.month.obs;

  CalendarViewModel(AuthRepository authRepository) {
    _taskServices = TaskApiServices(authRepository);
  }

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  Future<void> loadTasks() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final loadedTasks = await _taskServices.getTasks();
      tasks.value = loadedTasks;
      _updateSelectedTasks();
    } catch (e) {
      print('Erro ao carregar tarefas: $e');
      errorMessage.value = e.toString();
      if (e.toString().contains('ID do usuário não encontrado')) {
        Get.offAllNamed('/login');
      } else {
        Get.snackbar(
          'Erro',
          'Não foi possível carregar as tarefas: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xffFF0000),
          colorText: const Color(0xffFFFFFF),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  void _updateSelectedTasks() {
    if (selectedDay.value != null) {
      selectedTasks.value = getEventsForDay(selectedDay.value!);
    }
  }

  List<Task> getEventsForDay(DateTime day) {
    return tasks.where((task) => isSameDay(task.date, day)).toList();
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay.value = selectedDay;
    this.focusedDay.value = focusedDay;
    _updateSelectedTasks();
  }

  void onPageChanged(DateTime focusedDay) {
    this.focusedDay.value = focusedDay;
  }

  Future<void> addTask(Task task) async {
    try {
      await _taskServices.addTask(task);
      await loadTasks();
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Não foi possível adicionar a tarefa: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await _taskServices.updateTask(task);
      await loadTasks();
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Não foi possível atualizar a tarefa: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
