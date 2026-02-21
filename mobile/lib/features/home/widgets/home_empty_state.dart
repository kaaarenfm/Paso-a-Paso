import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/ui/cards/app_card.dart';
import '../../../../core/router/app_router.dart';

class HomeEmptyState extends StatelessWidget {
  const HomeEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          /// Ilustración
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppTheme.greenLight,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text("🌱", style: TextStyle(fontSize: 48)),
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          const Text(
            "Aún no tienes rutinas",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.dark,
            ),
          ),

          const SizedBox(height: AppSpacing.xs),

          Text(
            "Crea tu primera rutina y empieza\na construir hábitos hoy.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.grayCustom,
              height: 1.5,
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          /// Botón principal
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.greenDark,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () => Navigator.pushNamed(context, AppRouter.routineMoment),
              icon: const Icon(Icons.add_rounded, size: 20),
              label: const Text(
                "Crear primera rutina",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          /// Sugerencia
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppTheme.neutralBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.lightbulb_outline,
                  size: 15,
                  color: AppTheme.grayCustom,
                ),
                const SizedBox(width: 6),
                Text(
                  "Tip: Empieza con 1 hábito sencillo",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.grayCustom,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}