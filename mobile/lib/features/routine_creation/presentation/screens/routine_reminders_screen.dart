import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/ui/layout/app_scaffold.dart';
import '../state/routine_creation_controller.dart';

class RoutineRemindersScreen extends StatelessWidget {
  const RoutineRemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RoutineCreationController>();

    return AppScaffold(
      title: "Recordatorios",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.sm),
          const Text(
            "¿Quieres recordatorios?",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppTheme.dark,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            "Te ayudaremos a mantener el hábito con notificaciones.",
            style: TextStyle(fontSize: 14, color: AppTheme.grayCustom),
          ),
          const SizedBox(height: AppSpacing.lg),
          
          Expanded(
            child: ListView(
              children: [
                ...controller.draft.reminders.map((time) => _ReminderItem(
                  time: time,
                  onDelete: () => controller.removeReminder(time),
                )),
                const SizedBox(height: AppSpacing.md),
                _AddReminderButton(
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: AppTheme.greenDark,
                              onPrimary: Colors.white,
                              onSurface: AppTheme.dark,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (time != null) {
                      final formattedTime = "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
                      controller.addReminder(formattedTime);
                    }
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.routineConfirm);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.greenDark,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Continuar"),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

class _ReminderItem extends StatelessWidget {
  final String time;
  final VoidCallback onDelete;

  const _ReminderItem({required this.time, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.grayCustom.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.access_time, color: AppTheme.blueDark),
              const SizedBox(width: 12),
              Text(
                time,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.dark,
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}

class _AddReminderButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AddReminderButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.greenDark,
            style: BorderStyle.solid,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: AppTheme.greenDark),
            SizedBox(width: 8),
            Text(
              "Agregar recordatorio",
              style: TextStyle(
                color: AppTheme.greenDark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
