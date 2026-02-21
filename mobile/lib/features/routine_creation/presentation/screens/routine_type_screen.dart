import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/ui/layout/app_scaffold.dart';
import '../state/routine_creation_controller.dart';

class RoutineTypeScreen extends StatelessWidget {
  const RoutineTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<RoutineCreationController>();
    final moment = context.select<RoutineCreationController, String?>((c) => c.draft.moment);

    return AppScaffold(
      title: "Tipo de Rutina",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.sm),
          Text(
            "¿Qué buscas para tu ${moment?.toLowerCase() ?? 'día'}?",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppTheme.dark,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            "Selecciona el enfoque de esta rutina.",
            style: TextStyle(fontSize: 14, color: AppTheme.grayCustom),
          ),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 0.9,
              children: [
                _TypeCard(
                  emoji: "🚀",
                  title: "Productividad",
                  color: Colors.blue.shade50,
                  iconColor: Colors.blue,
                  onTap: () {
                    controller.setType("Productividad");
                    Navigator.pushNamed(context, AppRouter.routineHabits);
                  },
                ),
                _TypeCard(
                  emoji: "🧘‍♀️",
                  title: "Bienestar",
                  color: Colors.purple.shade50,
                  iconColor: Colors.purple,
                  onTap: () {
                    controller.setType("Bienestar");
                    Navigator.pushNamed(context, AppRouter.routineHabits);
                  },
                ),
                _TypeCard(
                  emoji: "🏋️",
                  title: "Ejercicio",
                  color: Colors.orange.shade50,
                  iconColor: Colors.orange,
                  onTap: () {
                    controller.setType("Ejercicio");
                    Navigator.pushNamed(context, AppRouter.routineHabits);
                  },
                ),
                _TypeCard(
                  emoji: "📚",
                  title: "Estudio",
                  color: Colors.green.shade50,
                  iconColor: Colors.green,
                  onTap: () {
                    controller.setType("Estudio");
                    Navigator.pushNamed(context, AppRouter.routineHabits);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TypeCard extends StatelessWidget {
  final String emoji;
  final String title;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;

  const _TypeCard({
    required this.emoji,
    required this.title,
    required this.color,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: iconColor.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: iconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
