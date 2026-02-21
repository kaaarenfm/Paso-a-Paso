import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/ui/cards/app_card.dart';

class _Routine {
  final String emoji;
  final String title;
  final String time;
  final int totalHabits;
  final int completedHabits;

  const _Routine({
    required this.emoji,
    required this.title,
    required this.time,
    required this.totalHabits,
    required this.completedHabits,
  });
}

/// 🔥 Datos temporales
const _mockRoutines = [
  _Routine(
    emoji: "🌅",
    title: "Rutina matutina",
    time: "7:00 am",
    totalHabits: 4,
    completedHabits: 2,
  ),
];

class HomeRoutinesList extends StatelessWidget {
  const HomeRoutinesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Título sección
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Rutinas de hoy",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.dark,
              ),
            ),
            Row(
              children: [
                GestureDetector(
                onTap: () => Navigator.pushNamed(context, "/routines"),
                child: Text(
                  "Ver todas",
                  style: TextStyle(
                    fontSize: 13,
                    color: AppTheme.greenDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                onPressed: () => Navigator.pushNamed(context, AppRouter.routineMoment),
                icon: const Icon(Icons.add_circle, color: AppTheme.greenDark),
                tooltip: "Nueva Rutina",
              ),
              ],
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.sm),

        /// Lista de rutinas
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _mockRoutines.length,
          separatorBuilder: (_, __) =>
              const SizedBox(height: AppSpacing.sm),
          itemBuilder: (context, index) {
            final routine = _mockRoutines[index];
            final progress = routine.completedHabits / routine.totalHabits;
            final isDone = progress == 1.0;

            return GestureDetector(
              onTap: () {
                // Navegar al detalle de hábitos (o lista de hábitos de la rutina)
                Navigator.pushNamed(context, AppRouter.habitDetail);
              },
              child: AppCard(
                child: Row(
                  children: [
                  /// Emoji
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isDone
                          ? AppTheme.greenLight
                          : AppTheme.neutralBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        routine.emoji,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),

                  const SizedBox(width: AppSpacing.sm),

                  /// Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              routine.title,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.dark,
                              ),
                            ),
                            if (isDone)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.greenLight,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  "✓ Listo",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.greenDark,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: 13,
                              color: AppTheme.grayCustom,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              routine.time,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppTheme.grayCustom,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Text(
                              "${routine.completedHabits}/${routine.totalHabits} hábitos",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppTheme.grayCustom,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        /// Progress bar
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progress,
                            backgroundColor:
                                AppTheme.grayCustom.withOpacity(0.12),
                            valueColor: AlwaysStoppedAnimation(
                              isDone
                                  ? AppTheme.greenDark
                                  : AppTheme.blueDark,
                            ),
                            minHeight: 5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.share, size: 20, color: AppTheme.grayCustom),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          title: const Text("Compartir rutina"),
                          content: const Text("¿Quieres publicar esta rutina en la comunidad para inspirar a otros?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancelar", style: TextStyle(color: AppTheme.grayCustom)),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("¡Rutina compartida en la comunidad! 🌏"),
                                    backgroundColor: AppTheme.greenDark,
                                  ),
                                );
                              },
                              child: const Text("Compartir", style: TextStyle(color: AppTheme.greenDark, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
          },
        ),
      ],
    );
  }
}