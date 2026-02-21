import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/ui/layout/app_scaffold.dart';
import '../state/routine_creation_controller.dart';

class RoutineFrequencyScreen extends StatefulWidget {
  const RoutineFrequencyScreen({super.key});

  @override
  State<RoutineFrequencyScreen> createState() => _RoutineFrequencyScreenState();
}

class _RoutineFrequencyScreenState extends State<RoutineFrequencyScreen> {
  TimeOfDay _selectedTime = const TimeOfDay(hour: 8, minute: 0);

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
      // Opcionalmente agregar el recordatorio automáticamente tras seleccionar
      // context.read<RoutineCreationController>().addReminder(picked.format(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RoutineCreationController>();
    final draft = controller.draft;

    final days = ["Lun", "Mar", "Mié", "Jue", "Vie", "Sáb", "Dom"];
    final isEveryDaySelected = draft.frequency.length == days.length;

    return AppScaffold(
      title: "Horario y Frecuencia",
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.sm),
            const Text(
              "¿Cuándo realizarás esta rutina?",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppTheme.dark,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            const Text(
              "Elige los días y configura recordatorios.",
              style: TextStyle(fontSize: 14, color: AppTheme.grayCustom),
            ),
            
            const SizedBox(height: AppSpacing.lg),

            // SECCIÓN: FRECUENCIA (DÍAS)
            const Text(
              "Frecuencia",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.dark,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),

            // Boton "Todos los días"
            InkWell(
              onTap: () => controller.toggleEveryDay(),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isEveryDaySelected ? AppTheme.greenDark.withOpacity(0.1) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isEveryDaySelected ? AppTheme.greenDark : AppTheme.grayCustom.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isEveryDaySelected ? Icons.check_circle : Icons.circle_outlined,
                      color: isEveryDaySelected ? AppTheme.greenDark : AppTheme.grayCustom,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Todos los días",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: isEveryDaySelected ? AppTheme.greenDark : AppTheme.dark,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // Selección individual de días
            if (!isEveryDaySelected || true) // Mostrar siempre por si quiere deseleccionar uno específico
              Center(
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: days.map((day) {
                    final isSelected = draft.frequency.contains(day);
                    return GestureDetector(
                      onTap: () => controller.toggleDay(day),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: isSelected ? AppTheme.greenDark : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? AppTheme.greenDark : AppTheme.grayCustom.withOpacity(0.3),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          day.substring(0, 1),
                          style: TextStyle(
                            color: isSelected ? Colors.white : AppTheme.dark,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

            const SizedBox(height: AppSpacing.xl),

            // Botón Continuar (Ahora va a recordatorios)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: draft.frequency.isNotEmpty
                    ? () => Navigator.pushNamed(context, AppRouter.routineReminders)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.greenDark,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  disabledBackgroundColor: AppTheme.grayCustom.withOpacity(0.3),
                ),
                child: const Text("Continuar", style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }
}
