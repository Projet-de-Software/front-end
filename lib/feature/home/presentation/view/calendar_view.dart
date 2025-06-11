import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodoro_app/core/consts/app_colors.dart';
import 'package:pomodoro_app/feature/home/presentation/viewmodel/calendar_view_model.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pomodoro_app/feature/home/presentation/widgets/tasks/edit_task_modal.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CalendarViewModel>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.errorMessage.isNotEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                controller.errorMessage.value,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: controller.loadTasks,
                child: const Text('Tentar Novamente'),
              ),
            ],
          ),
        );
      }

      return Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2025, 12, 31),
            focusedDay: controller.focusedDay.value,
            calendarFormat: CalendarFormat.month,
            eventLoader: controller.getEventsForDay,
            selectedDayPredicate: (day) =>
                isSameDay(controller.selectedDay.value, day),
            onDaySelected: controller.onDaySelected,
            onPageChanged: controller.onPageChanged,
            calendarStyle: const CalendarStyle(
              markersMaxCount: 1,
              markerDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              defaultTextStyle: TextStyle(
                color: AppColors.primaryColor,
              ),
              weekendTextStyle: TextStyle(
                color: Color.fromARGB(255, 224, 224, 224),
              ),
              outsideDaysVisible: false,
              todayDecoration: BoxDecoration(
                color: Colors.transparent,
              ),
              todayTextStyle: TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
              ),
              selectedDecoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(
                color: Colors.black,
              ),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                color: Color.fromARGB(255, 160, 160, 160),
                fontWeight: FontWeight.bold,
              ),
              weekendStyle: TextStyle(
                color: Color(0xFF9E9E9E),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: controller.selectedTasks.isEmpty
                ? const Center(
                    child: Text('Nenhuma tarefa para este dia'),
                  )
                : ListView.builder(
                    itemCount: controller.selectedTasks.length,
                    itemBuilder: (context, index) {
                      final task = controller.selectedTasks[index];
                      return _buildTaskItem(
                        context,
                        controller,
                        task.title,
                        task.description,
                        '${task.date.hour.toString().padLeft(2, '0')}:${task.date.minute.toString().padLeft(2, '0')}',
                      );
                    },
                  ),
          ),
        ],
      );
    });
  }

  Widget _buildTaskItem(BuildContext context, CalendarViewModel controller,
      String title, String description, String time) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.secondTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.secondTextColor,
                    ),
                  ),
                ],
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              final task = controller.selectedTasks.firstWhere(
                (t) => t.title == title && t.description == description,
                orElse: () => controller.selectedTasks.first,
              );

              if (context.mounted) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: EditTaskModal(
                      viewModel: controller,
                      task: task,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
