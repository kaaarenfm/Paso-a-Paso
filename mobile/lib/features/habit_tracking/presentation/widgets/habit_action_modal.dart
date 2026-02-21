import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class HabitActionModal extends StatelessWidget {
  const HabitActionModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Acciones del Hábito", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.check_circle, color: AppTheme.greenDark),
            title: const Text("Marcar completado"),
            onTap: () => Navigator.pop(context, 'completed'),
          ),
          ListTile(
            leading: const Icon(Icons.note_add, color: AppTheme.greenDark),
            title: const Text("Agregar nota"),
            onTap: () => Navigator.pop(context, 'note'),
          ),
          ListTile(
            leading: const Icon(Icons.schedule, color: AppTheme.greenDark),
            title: const Text("Posponer"),
            onTap: () => Navigator.pop(context, 'postpone'),
          ),
        ],
      ),
    );
  }
}
