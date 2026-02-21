import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/ui/layout/app_scaffold.dart';
import '../state/routine_creation_controller.dart';

class RoutineMomentScreen extends StatelessWidget {
  const RoutineMomentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<RoutineCreationController>();

    return AppScaffold(
      title: "Nuevo Hábito",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.sm),
          const Text(
            "¿En qué momento del día?",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppTheme.dark,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            "Elige el mejor momento para realizar tu rutina.",
            style: TextStyle(fontSize: 14, color: AppTheme.grayCustom),
          ),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: ListView(
              children: [
                _MomentCard(
                  emoji: "🌅",
                  title: "Mañana",
                  subtitle: "Empieza el día con energía",
                  onTap: () {
                    controller.setMoment("Mañana");
                    Navigator.pushNamed(context, AppRouter.routineType);
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                _MomentCard(
                  emoji: "☀️",
                  title: "Tarde",
                  subtitle: "Mantén el ritmo",
                  onTap: () {
                    controller.setMoment("Tarde");
                    Navigator.pushNamed(context, AppRouter.routineType);
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                _MomentCard(
                  emoji: "🌙",
                  title: "Noche",
                  subtitle: "Prepárate para descansar",
                  onTap: () {
                    controller.setMoment("Noche");
                    Navigator.pushNamed(context, AppRouter.routineType);
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

class _MomentCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MomentCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.grayCustom.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.neutralBg,
                shape: BoxShape.circle,
              ),
              child: Text(emoji, style: const TextStyle(fontSize: 24)),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.dark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.grayCustom,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.grayCustom),
          ],
        ),
      ),
    );
  }
}
