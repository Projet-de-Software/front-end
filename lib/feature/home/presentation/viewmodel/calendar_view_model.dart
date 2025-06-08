import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pomodoro_app/feature/home/domain/models/task.dart';

class CalendarViewModel extends GetxController {
  final Rx<DateTime> focusedDay = DateTime.now().obs;
  final Rx<DateTime?> selectedDay = Rx<DateTime?>(DateTime.now());
  final RxList<Task> selectedTasks = <Task>[].obs;

  // Lista de eventos de exemplo (substitua com dados reais no futuro)
  final Map<DateTime, List<Task>> events = {
    DateTime.utc(2025, 6, 26): [
      Task(
        id: '1',
        title: 'Estudar História',
        description: 'Como foi a morte de Napoleão?',
        date: DateTime.utc(2025, 6, 26, 8, 0),
      ),
      Task(
        id: '2',
        title: 'Revisar Matemática',
        description: 'Resolver exercícios de cálculo',
        date: DateTime.utc(2025, 6, 26, 10, 0),
      ),
    ],
    DateTime.utc(2025, 6, 10): [
      Task(
        id: '3',
        title: 'Reunião de Projeto',
        description: 'Discussão sobre o MVP',
        date: DateTime.utc(2025, 6, 10, 14, 0),
      ),
    ],
  };

  @override
  void onInit() {
    super.onInit();
    // Inicializa as tarefas para o dia selecionado (hoje)
    _getTasksForDay(selectedDay.value ?? DateTime.now());
  }

  void onDaySelected(DateTime day, DateTime focusDay) {
    if (!isSameDay(selectedDay.value, day)) {
      selectedDay.value = day;
      focusedDay.value = focusDay;
      _getTasksForDay(day);
    }
  }

  void _getTasksForDay(DateTime day) {
    selectedTasks.value =
        events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  List<Task> getEventsForDay(DateTime day) {
    return events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  void onPageChanged(DateTime focusedDay) {
    this.focusedDay.value = focusedDay;
  }
}
