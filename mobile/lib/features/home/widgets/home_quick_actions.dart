import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_spacing.dart';

class _QuickAction {
  final String emoji;
  final String label;
  final String route;
  final Color color;
  final Color bgColor;

  const _QuickAction({
    required this.emoji,
    required this.label,
    required this.route,
    required this.color,
    required this.bgColor,
  });
}

const _actions = [
  _QuickAction(
    emoji: "📅",
    label: "Calendario",
    route: "/calendar",
    color: AppTheme.blueDark,
    bgColor: AppTheme.blueLight,
  ),
  _QuickAction(
    emoji: "👥",
    label: "Comunidad",
    route: "/community",
    color: Color(0xFF7B6FB0),
    bgColor: Color(0xFFEDE8FF),
  ),
  _QuickAction(
    emoji: "🐾",
    label: "Mascota",
    route: "/pet",
    color: AppTheme.greenDark,
    bgColor: AppTheme.greenLight,
  ),
  _QuickAction(
    emoji: "📊",
    label: "Progreso",
    route: "/progress",
    color: Color(0xFFE07B39),
    bgColor: Color(0xFFFFF0E6),
  ),
  _QuickAction(
    emoji: "👤",
    label: "Perfil",
    route: "/profile",
    color: AppTheme.grayCustom,
    bgColor: AppTheme.neutralBg,
  ),
];

class HomeQuickActions extends StatelessWidget {
  const HomeQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Accesos rápidos",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.dark,
          ),
        ),

        const SizedBox(height: AppSpacing.sm),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _actions.map((action) {
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, action.route),
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: action.bgColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: action.color.withOpacity(0.2),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        action.emoji,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    action.label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.grayCustom,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}