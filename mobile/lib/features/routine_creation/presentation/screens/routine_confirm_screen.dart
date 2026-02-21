import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/ui/layout/app_scaffold.dart';
import '../../../../core/state/app_state.dart';
import '../state/routine_creation_controller.dart';

class RoutineConfirmScreen extends StatelessWidget {
  const RoutineConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RoutineCreationController>();
    final draft = controller.draft;
    final appState = context.read<AppState>();

    return AppScaffold(
      title: "Confirmar",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.sm),
          const Text(
            "¡Todo listo!",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppTheme.dark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            controller.getMotivationalQuote(),
            style: const TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: AppTheme.greenDark,
            ),
          ),
          
          const SizedBox(height: AppSpacing.xl),

          // Resumen
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
             child: Column(
              children: [
                _SummaryRow(icon: Icons.wb_sunny_outlined, label: "Momento", value: draft.moment ?? "-"),
                const Divider(),
                _SummaryRow(icon: Icons.category_outlined, label: "Tipo", value: draft.name ?? "-"),
                const Divider(),
                _SummaryRow(
                  icon: Icons.list,
                  label: "Hábitos",
                  value: "${draft.habits.length} hábitos",
                ),
                 const Divider(),
                _SummaryRow(
                  icon: Icons.calendar_today,
                  label: "Frecuencia",
                  value: draft.frequency.join(", "),
                ),
              ],
            ),
          ),

          const Spacer(),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Guardar en estado global y navegar a Home
                context.read<AppState>().addRoutine();
                controller.reset();
                Navigator.pushNamedAndRemoveUntil(context, AppRouter.mainContainer, (_) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.greenDark,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Crear Rutina 🎉", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  
  const _SummaryRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.grayCustom, size: 20),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: AppTheme.grayCustom)),
          const Spacer(),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.dark),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
