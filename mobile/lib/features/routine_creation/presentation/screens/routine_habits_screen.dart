import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/ui/layout/app_scaffold.dart';
import '../state/routine_creation_controller.dart';

class RoutineHabitsScreen extends StatefulWidget {
  const RoutineHabitsScreen({super.key});

  @override
  State<RoutineHabitsScreen> createState() => _RoutineHabitsScreenState();
}

class _RoutineHabitsScreenState extends State<RoutineHabitsScreen> {
  final TextEditingController _customHabitController = TextEditingController();

  @override
  void dispose() {
    _customHabitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RoutineCreationController>();
    final draft = controller.draft;
    final suggested = controller.getSuggestedHabits(draft.moment ?? "Mañana");

    return AppScaffold(
      title: "Hábitos",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.sm),
          const Text(
            "Selecciona tus hábitos",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppTheme.dark,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            "Puedes elegir de la lista o agregar los tuyos.",
            style: TextStyle(fontSize: 14, color: AppTheme.grayCustom),
          ),
          
          const SizedBox(height: AppSpacing.lg),

          // Input personalizado
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.grayCustom.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _customHabitController,
                    decoration: const InputDecoration(
                      hintText: "Escribe un hábito nuevo...",
                      border: InputBorder.none,
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        controller.toggleHabit(value);
                        _customHabitController.clear();
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: AppTheme.greenDark),
                  onPressed: () {
                    if (_customHabitController.text.isNotEmpty) {
                      controller.toggleHabit(_customHabitController.text);
                      _customHabitController.clear();
                    }
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          // Lista de seleccionados + sugeridos
          Expanded(
            child: ListView(
              children: [
                if (draft.habits.isNotEmpty) ...[
                  const Text(
                    "Seleccionados",
                    style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.greenDark),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: draft.habits.map((habit) {
                      return Chip(
                        label: Text(habit),
                        backgroundColor: AppTheme.greenDark.withOpacity(0.1),
                        labelStyle: const TextStyle(color: AppTheme.greenDark),
                        deleteIcon: const Icon(Icons.close, size: 16),
                        onDeleted: () => controller.toggleHabit(habit),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: AppTheme.greenDark.withOpacity(0.2)),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],

                const Text(
                  "Sugerencias",
                  style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.dark),
                ),
                const SizedBox(height: AppSpacing.sm),
                ...suggested.map((habit) {
                  final isSelected = draft.habits.contains(habit);
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.neutralBg,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.star_outline, size: 20, color: AppTheme.grayCustom),
                    ),
                    title: Text(habit),
                    trailing: Checkbox(
                      value: isSelected,
                      activeColor: AppTheme.greenDark,
                      onChanged: (_) => controller.toggleHabit(habit),
                    ),
                  );
                }),
              ],
            ),
          ),

          // Botón Continuar
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: draft.habits.isNotEmpty
                  ? () => Navigator.pushNamed(context, AppRouter.routineFrequency)
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
        ],
      ),
    );
  }
}
