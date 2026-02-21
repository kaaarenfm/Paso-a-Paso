import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class CalendarWeekStrip extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const CalendarWeekStrip({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Generate current week dates (starting from Monday)
    final now = DateTime.now();
    final currentWeekDay = now.weekday; // 1 = Mon, 7 = Sun
    final startOfWeek = now.subtract(Duration(days: currentWeekDay - 1));
    
    final weekDays = List.generate(7, (index) => startOfWeek.add(Duration(days: index)));

    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final date = weekDays[index];
          final isSelected = _isSameDay(date, selectedDate);
          final isToday = _isSameDay(date, now);
          
          return GestureDetector(
            onTap: () => onDateSelected(date),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 55,
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.greenDark : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? AppTheme.greenDark : AppTheme.grayCustom.withOpacity(0.2),
                  width: isToday && !isSelected ? 2 : 1, // Highlight today
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppTheme.greenDark.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : [],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _getDayName(date.weekday),
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.white.withOpacity(0.8) : AppTheme.grayCustom,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${date.day}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : AppTheme.dark,
                    ),
                  ),
                  if (isToday) ...[
                     const SizedBox(height: 4),
                     Container(
                       width: 4,
                       height: 4,
                       decoration: BoxDecoration(
                         color: isSelected ? Colors.white : AppTheme.greenDark,
                         shape: BoxShape.circle,
                       ),
                     ),
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _getDayName(int weekday) {
    const days = ["Lun", "Mar", "Mié", "Jue", "Vie", "Sáb", "Dom"];
    return days[weekday - 1];
  }
}
