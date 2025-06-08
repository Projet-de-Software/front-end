import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodoro_app/core/consts/app_colors.dart';
import 'package:pomodoro_app/feature/home/presentation/viewmodel/calendar_view_model.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    final CalendarViewModel controller = Get.put(CalendarViewModel());

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => TableCalendar(
                focusedDay: controller.focusedDay.value,
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                selectedDayPredicate: (day) =>
                    isSameDay(controller.selectedDay.value, day),
                onDaySelected: controller.onDaySelected,
                onPageChanged: controller.onPageChanged,
                eventLoader: controller.getEventsForDay,
                calendarFormat: CalendarFormat.month,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: false,
                  titleTextStyle: TextStyle(
                    color: AppColors.secondColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  leftChevronIcon: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.secondColor,
                    size: 20,
                  ),
                  rightChevronIcon: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.secondColor,
                    size: 20,
                  ),
                  titleTextFormatter: (date, locale) =>
                      '${_getMonthName(date.month)} ${date.year}',
                ),
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  defaultTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  weekendTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: AppColors.secondColor,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  todayTextStyle: TextStyle(
                    color: AppColors.secondColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  markerDecoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    color: AppColors.secondColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  weekendStyle: TextStyle(
                    color: AppColors.secondColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.white.withAlpha(100), thickness: 1),
            const SizedBox(height: 16),
            Obx(
              () => Text(
                'Dia ${controller.selectedDay.value?.day ?? '--'}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemCount: controller.selectedTasks.length,
                  itemBuilder: (context, index) {
                    final task = controller.selectedTasks[index];
                    return _buildTaskItem(
                      task.title,
                      task.description,
                      '${task.date.hour}:${task.date.minute.toString().padLeft(2, '0')} as ${task.date.hour + 1}:${task.date.minute.toString().padLeft(2, '0')}',
                    ); // Exemplo de tempo
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskItem(String category, String title, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$category - $title',
            style: TextStyle(
              color: AppColors.secondColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            time,
            style: TextStyle(
              color: Colors.white.withAlpha(150),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Janeiro';
      case 2:
        return 'Fevereiro';
      case 3:
        return 'Março';
      case 4:
        return 'Abril';
      case 5:
        return 'Maio';
      case 6:
        return 'Junho';
      case 7:
        return 'Julho';
      case 8:
        return 'Agosto';
      case 9:
        return 'Setembro';
      case 10:
        return 'Outubro';
      case 11:
        return 'Novembro';
      case 12:
        return 'Dezembro';
      default:
        return '';
    }
  }
}
