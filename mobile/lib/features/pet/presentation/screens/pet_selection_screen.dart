import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/ui/layout/app_scaffold.dart';
import '../../../../core/theme/app_spacing.dart';

class PetSelectionScreen extends StatelessWidget {
  const PetSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pets = [
      {"name": "Rocky", "emoji": "🐶", "color": Colors.orange.shade100},
      {"name": "Luna", "emoji": "🐱", "color": Colors.purple.shade100},
      {"name": "Sparky", "emoji": "🐹", "color": Colors.yellow.shade100},
      {"name": "Coco", "emoji": "🦜", "color": Colors.green.shade100},
    ];

    return AppScaffold(
      title: "Elige tu compañero",
      child: GridView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: pets.length,
        itemBuilder: (context, index) {
          final pet = pets[index];
          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("¡Has seleccionado a ${pet['name']}!")),
              );
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: AppTheme.grayCustom.withOpacity(0.1)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: pet['color'] as Color,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        pet['emoji'] as String,
                        style: const TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    pet['name'] as String,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.dark,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
