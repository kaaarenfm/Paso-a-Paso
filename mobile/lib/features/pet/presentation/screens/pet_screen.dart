import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/ui/layout/app_scaffold.dart';
import '../../../../core/theme/app_spacing.dart';
import '../widgets/pet_avatar.dart';
import '../widgets/pet_dialog_bubble.dart';

import 'package:provider/provider.dart';
import '../../../../core/state/app_state.dart';
import '../../../../core/state/pet_state.dart';

class PetScreen extends StatefulWidget {
  const PetScreen({super.key});

  @override
  State<PetScreen> createState() => _PetScreenState();
}

class _PetScreenState extends State<PetScreen> {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final pet = appState.pet;

    return AppScaffold(
      title: "Mascota Emocional",
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.lg),
            
            // Pet Phrase - Dynamic based on emotion
            PetDialogBubble(text: _getEmotionPhrase(pet.emotion)),

            const SizedBox(height: AppSpacing.sm),

            // Pet Avatar (Emotional)
            PetAvatar(
              emotion: pet.emotion,
              size: 280,
            ),

             const SizedBox(height: AppSpacing.md),
            
            Text(
              pet.name,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppTheme.dark,
              ),
            ),
             const SizedBox(height: AppSpacing.sm),
            
            // Emotion Label
             _buildEmotionChip(pet.emotion),

             const SizedBox(height: AppSpacing.xl),

            // Description of why the pet feels this way
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                _getEmotionDescription(pet.emotion, appState.routine.completedToday),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.grayCustom,
                  height: 1.5,
                ),
              ),
            ),

             const SizedBox(height: AppSpacing.xl),

            // Actions
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.mainContainer);
              },
              icon: const Icon(Icons.home_outlined),
              label: const Text("Ir a mis hábitos"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.greenDark,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmotionChip(PetEmotion emotion) {
    Color color;
    String text;
    switch (emotion) {
      case PetEmotion.happy: color = AppTheme.greenDark; text = "Feliz"; break;
      case PetEmotion.sad: color = AppTheme.blueDark; text = "Triste"; break;
      case PetEmotion.angry: color = AppTheme.redDark; text = "Enojado"; break;
      case PetEmotion.proud: color = Colors.orangeAccent; text = "Orgulloso"; break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  String _getEmotionPhrase(PetEmotion emotion) {
    switch (emotion) {
      case PetEmotion.happy: return "¡Estoy muy feliz de verte avanzar! 🐾";
      case PetEmotion.sad: return "Me siento un poco triste... ¿completamos algo hoy? 🥺";
      case PetEmotion.angry: return "¡Aún no has hecho nada! Vamos, ¡tú puedes! 😤";
      case PetEmotion.proud: return "¡Guau! ¡Estoy súper orgulloso de tu constancia! 🏆";
    }
  }

  String _getEmotionDescription(PetEmotion emotion, int completedCount) {
    if (completedCount == 0) {
      return "Rocky se siente triste porque hoy no han completado ningún hábito juntos.";
    } else if (completedCount < 3) {
      return "¡Va mejorando! Rocky está feliz de que estés dando los primeros pasos hoy.";
    } else {
      return "¡Increíble! Rocky está muy orgulloso por tu disciplina inquebrantable.";
    }
  }
}
