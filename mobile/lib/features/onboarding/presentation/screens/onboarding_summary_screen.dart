import 'package:flutter/material.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/ui/layout/app_scaffold.dart';
import '../../../../../core/ui/buttons/primary_button.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/theme/app_spacing.dart';

class OnboardingSummaryScreen extends StatefulWidget {
  const OnboardingSummaryScreen({super.key});

  @override
  State<OnboardingSummaryScreen> createState() =>
      _OnboardingSummaryScreenState();
}

class _OnboardingSummaryScreenState extends State<OnboardingSummaryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppSpacing.sm),

                      /// Header de éxito
                      Center(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(AppSpacing.md),
                              decoration: BoxDecoration(
                                color: AppTheme.greenLight,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.greenDark.withOpacity(0.2),
                                    blurRadius: 24,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                              child: const Text(
                                "🎯",
                                style: TextStyle(fontSize: 48),
                              ),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            const Text(
                              "¡Todo listo!",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.dark,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              "Aquí está tu perfil personalizado",
                              style: TextStyle(
                                fontSize: 15,
                                color: AppTheme.grayCustom,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      /// Tarjetas de resumen
                      _SummaryCard(
                        icon: "🎯",
                        label: "Objetivo",
                        value: "Desarrollo personal",
                        color: AppTheme.greenDark,
                        bgColor: AppTheme.greenLight,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _SummaryCard(
                        icon: "🗂️",
                        label: "Categorías",
                        value: "Ejercicio, Meditación, Lectura",
                        color: AppTheme.blueDark,
                        bgColor: AppTheme.blueLight,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _SummaryCard(
                        icon: "📊",
                        label: "Nivel",
                        value: "Principiante 🌱",
                        color: Color(0xFF5B9E6F),
                        bgColor: Color(0xFFE0F4E8),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _SummaryCard(
                        icon: "🕐",
                        label: "Horario preferido",
                        value: "Mañana y Noche",
                        color: Color(0xFFE07B39),
                        bgColor: Color(0xFFFFF0E6),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _SummaryCard(
                        icon: "💪",
                        label: "Motivación",
                        value: "Quiero sentirme mejor conmigo mismo",
                        color: AppTheme.redDark,
                        bgColor: Color(0xFFFFE8E9),
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      /// Info box
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: AppTheme.yellowLight,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppTheme.yellow.withOpacity(0.4),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Text(
                              "💡",
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                "Puedes cambiar estas preferencias en cualquier momento desde tu perfil.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.dark,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppSpacing.lg),
                    ],
                  ),
                ),
              ),

              /// Botón continuar
              PrimaryButton(
                text: "Firmar mi compromiso 🤝",
                onPressed: () => Navigator.pushReplacementNamed(
                  context,
                  AppRouter.contract,
                ),
                icon: Icons.draw_outlined,
              ),

              const SizedBox(height: AppSpacing.sm),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  final Color color;
  final Color bgColor;

  const _SummaryCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppTheme.grayCustom.withOpacity(0.12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(icon, style: const TextStyle(fontSize: 20)),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.grayCustom,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.dark,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check, size: 14, color: color),
          ),
        ],
      ),
    );
  }
}