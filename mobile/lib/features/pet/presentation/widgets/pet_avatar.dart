import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/state/pet_state.dart';

class PetAvatar extends StatelessWidget {
  final PetEmotion emotion;
  final double size;

  const PetAvatar({
    super.key,
    required this.emotion,
    this.size = 200,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: size,
      height: size,
      curve: Curves.elasticOut,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Glow based on emotion
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  _getEmotionColor().withOpacity(0.3),
                  _getEmotionColor().withOpacity(0),
                ],
              ),
            ),
          ),
          
          // Emotional Icon Placeholder (In a real app, these would be assets)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getEmotionIcon(),
                size: size * 0.5,
                color: _getEmotionColor(),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: _getEmotionColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _getEmotionText(),
                  style: TextStyle(
                    color: _getEmotionColor(),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getEmotionIcon() {
    switch (emotion) {
      case PetEmotion.happy: return Icons.sentiment_satisfied_alt;
      case PetEmotion.sad: return Icons.sentiment_very_dissatisfied;
      case PetEmotion.angry: return Icons.sentiment_very_dissatisfied_outlined;
      case PetEmotion.proud: return Icons.auto_awesome;
    }
  }

  Color _getEmotionColor() {
    switch (emotion) {
      case PetEmotion.happy: return AppTheme.greenDark;
      case PetEmotion.sad: return AppTheme.blueDark;
      case PetEmotion.angry: return AppTheme.redDark;
      case PetEmotion.proud: return Colors.orangeAccent;
    }
  }

  String _getEmotionText() {
    switch (emotion) {
      case PetEmotion.happy: return "¡FELIZ!";
      case PetEmotion.sad: return "TRISTE";
      case PetEmotion.angry: return "ENOJADO";
      case PetEmotion.proud: return "¡ORGULLOSO!";
    }
  }
}
