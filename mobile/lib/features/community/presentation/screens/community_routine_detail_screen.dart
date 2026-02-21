import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/ui/layout/app_scaffold.dart';

class CommunityRoutineDetailScreen extends StatelessWidget {
  const CommunityRoutineDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Detalle de Rutina",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.md),
          const Text(
            "Rutina de Mañana Productiva",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.dark,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const CircleAvatar(
                radius: 12,
                backgroundColor: AppTheme.neutralBg,
                child: Icon(Icons.person, size: 14, color: AppTheme.grayCustom),
              ),
              const SizedBox(width: 8),
              const Text(
                "por Usuario 1",
                style: TextStyle(color: AppTheme.grayCustom),
              ),
              const Spacer(),
              const Icon(Icons.favorite, color: Colors.red, size: 16),
              const SizedBox(width: 4),
              const Text("124", style: TextStyle(color: AppTheme.grayCustom, fontSize: 13)),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const Text(
            "Descripción",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Esta rutina está diseñada para maximizar tu productividad en las primeras horas del día. Incluye hidratación, enfoque mental y preparación física ligera.",
            style: TextStyle(color: AppTheme.dark, height: 1.5),
          ),
          const SizedBox(height: AppSpacing.lg),
          const Text(
            "Hábitos incluidos:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: ListView(
              children: [
                _HabitItem(emoji: "💧", title: "Beber agua", subtitle: "500ml nada más despertar"),
                _HabitItem(emoji: "🧘", title: "Meditar 10 min", subtitle: "Enfoque en la respiración"),
                _HabitItem(emoji: "📖", title: "Leer 15 min", subtitle: "Un libro de no ficción"),
                _HabitItem(emoji: "🏃", title: "Estiramiento", subtitle: "5 minutos de movilidad"),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("¡Rutina añadida a tus rutinas! 🚀"),
                    backgroundColor: AppTheme.greenDark,
                  ),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.greenDark,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.add),
              label: const Text("Añadir a mis rutinas"),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

class _HabitItem extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;

  const _HabitItem({required this.emoji, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.grayCustom.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.neutralBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(emoji, style: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.dark)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: AppTheme.grayCustom)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
