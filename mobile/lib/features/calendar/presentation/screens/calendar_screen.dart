import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/state/app_state.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/ui/layout/app_scaffold.dart';
import '../widgets/calendar_week_strip.dart';
import '../../../../core/ui/widgets/pattern_background.dart';
import '../../../pet/presentation/widgets/pet_avatar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        children: [
          // Weekly Strip
          CalendarWeekStrip(
            selectedDate: _selectedDate,
            onDateSelected: (date) {
              setState(() {
                _selectedDate = date;
              });
            },
          ),

          const SizedBox(height: AppSpacing.md),

          // Daily Progress Summary
          _buildDayProgress(),

          const SizedBox(height: AppSpacing.lg),

          // Habits List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
              children: [
                 const Text(
                  "Hábitos del día",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.dark,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                
                _buildHabitItem(
                  title: "Meditación Mañanera",
                  time: "07:00 AM",
                  isCompleted: true,
                  emoji: "🧘",
                ),
                _buildHabitItem(
                  title: "Beber Agua",
                  time: "Todo el día",
                  isCompleted: false,
                  emoji: "💧",
                ),
                 _buildHabitItem(
                  title: "Leer 20 min",
                  time: "09:00 PM",
                  isCompleted: false,
                  emoji: "📚",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayProgress() {
    final appState = context.watch<AppState>();
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      decoration: BoxDecoration(
        color: AppTheme.blueDark, // Dark background card
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Programmatic Pattern
            const Positioned.fill(
              child: PatternBackground(
                opacity: 0.1,
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  // Circular Progress
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(
                          value: appState.routine.completedToday / 3.0,
                          strokeWidth: 6,
                          backgroundColor: Colors.white.withOpacity(0.2),
                          valueColor: const AlwaysStoppedAnimation(AppTheme.greenLight),
                        ),
                      ),
                      Text(
                        "${(appState.routine.completedToday / 3.0 * 100).toInt()}%",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: AppSpacing.md),
                  
                  // Text Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Progreso de Hoy",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Has completado ${appState.routine.completedToday} de 3 hábitos.",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Small Pet Avatar integrated here
                  PetAvatar(
                    emotion: appState.pet.emotion,
                    size: 60,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHabitItem({
    required String title,
    required String time,
    required bool isCompleted,
    required String emoji,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRouter.habitDetail); // Navigate to detail
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isCompleted ? AppTheme.greenDark.withOpacity(0.2) : Colors.transparent,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isCompleted ? AppTheme.greenLight.withOpacity(0.3) : AppTheme.neutralBg,
                shape: BoxShape.circle,
              ),
              child: Text(emoji, style: const TextStyle(fontSize: 20)),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isCompleted ? AppTheme.dark.withOpacity(0.6) : AppTheme.dark,
                      decoration: isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.grayCustom,
                    ),
                  ),
                ],
              ),
            ),
            if (isCompleted)
              const Icon(Icons.check_circle, color: AppTheme.greenDark)
            else
              const Icon(Icons.circle_outlined, color: AppTheme.grayCustom),
          ],
        ),
      ),
    );
  }
}
