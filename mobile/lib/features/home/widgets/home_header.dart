import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/router/app_router.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Buenos días";
    if (hour < 18) return "Buenas tardes";
    return "Buenas noches";
  }

  String _getGreetingEmoji() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "🌅";
    if (hour < 18) return "☀️";
    return "🌙";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Texto de saludo
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    _getGreetingEmoji(),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _getGreeting(),
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.grayCustom,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              const Text(
                "Juan Carlos",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.dark,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),

        /// Notificaciones
        _HeaderIconButton(
          icon: Icons.notifications_outlined,
          badge: true,
          onTap: () => Navigator.pushNamed(context, AppRouter.notifications),
        ),

        const SizedBox(width: AppSpacing.xs),

        /// Avatar
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, "/profile"),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppTheme.greenLight,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppTheme.greenDark,
                width: 2,
              ),
            ),
            child: const Center(
              child: Text("JC", style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppTheme.greenDark,
              )),
            ),
          ),
        ),
      ],
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final bool badge;
  final VoidCallback onTap;

  const _HeaderIconButton({
    required this.icon,
    required this.onTap,
    this.badge = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.grayCustom.withOpacity(0.15),
              ),
            ),
            child: Icon(icon, size: 22, color: AppTheme.dark),
          ),
          if (badge)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppTheme.redDark,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}