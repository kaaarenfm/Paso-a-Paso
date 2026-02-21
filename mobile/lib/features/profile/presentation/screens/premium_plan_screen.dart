import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/ui/layout/app_scaffold.dart';

class PremiumPlanScreen extends StatelessWidget {
  const PremiumPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Plan Premium",
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, size: 80, color: Colors.amber),
            const SizedBox(height: AppSpacing.lg),
            const Text(
              "¡Sube de Nivel!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppTheme.dark,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
             const Text(
              "Accede a estadísticas avanzadas, mascotas exclusivas y rutinas ilimitadas.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.grayCustom,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            ElevatedButton(
              onPressed: () {
                // Fake purchase
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("¡Gracias por tu interés! Próximamente.")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.dark,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text("Obtener Premium"),
            ),
          ],
        ),
      ),
    );
  }
}
