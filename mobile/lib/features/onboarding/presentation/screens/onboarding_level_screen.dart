import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/ui/layout/app_scaffold.dart';
import '../../../../../core/ui/layout/onboarding_header.dart';
import '../../../../../core/ui/buttons/primary_button.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/theme/app_spacing.dart';

class _Level {
  final String emoji;
  final String title;
  final String description;
  final String detail;

  const _Level({
    required this.emoji,
    required this.title,
    required this.description,
    required this.detail,
  });
}

const _levels = [
  _Level(
    emoji: "🌱",
    title: "Principiante",
    description: "Apenas empiezo",
    detail: "1–2 hábitos al día",
  ),
  _Level(
    emoji: "🔥",
    title: "En progreso",
    description: "Tengo algo de constancia",
    detail: "3–5 hábitos al día",
  ),
  _Level(
    emoji: "⚡",
    title: "Avanzado",
    description: "Soy bastante constante",
    detail: "6+ hábitos al día",
  ),
];

class OnboardingLevelScreen extends StatefulWidget {
  const OnboardingLevelScreen({super.key});

  @override
  State<OnboardingLevelScreen> createState() => _OnboardingLevelScreenState();
}

class _OnboardingLevelScreenState extends State<OnboardingLevelScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  int? _selected;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
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
              OnboardingHeader(
                currentStep: 3,
                totalSteps: 5,
                title: "¿Cuál es tu nivel\nactual?",
                subtitle: "Sé honesto, no hay respuesta incorrecta",
                onBack: () => Navigator.pop(context),
              ),

              const SizedBox(height: AppSpacing.lg),

              /// Cards de nivel
              Expanded(
                child: ListView.separated(
                  itemCount: _levels.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final level = _levels[index];
                    final isSelected = _selected == index;

                    return GestureDetector(
                      onTap: () {
                        HapticFeedback.selectionClick();
                        setState(() => _selected = index);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOut,
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppTheme.greenLight
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? AppTheme.greenDark
                                : AppTheme.grayCustom.withOpacity(0.15),
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isSelected
                                  ? AppTheme.greenDark.withOpacity(0.12)
                                  : Colors.black.withOpacity(0.04),
                              blurRadius: 12,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            /// Emoji con fondo
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.white.withOpacity(0.7)
                                    : AppTheme.neutralBg,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  level.emoji,
                                  style: const TextStyle(fontSize: 28),
                                ),
                              ),
                            ),

                            const SizedBox(width: AppSpacing.sm),

                            /// Texto
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    level.title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected
                                          ? AppTheme.dark
                                          : AppTheme.dark,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    level.description,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppTheme.grayCustom,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppTheme.greenDark.withOpacity(0.1)
                                          : AppTheme.neutralBg,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      level.detail,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: isSelected
                                            ? AppTheme.greenDark
                                            : AppTheme.grayCustom,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// Radio indicator
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppTheme.greenDark
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? AppTheme.greenDark
                                      : AppTheme.grayCustom.withOpacity(0.3),
                                  width: 2,
                                ),
                              ),
                              child: isSelected
                                  ? const Icon(Icons.check,
                                      size: 14, color: Colors.white)
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              PrimaryButton(
                text: "Continuar",
                onPressed: () =>
                    Navigator.pushNamed(context, AppRouter.onboardingSchedule),
                icon: Icons.arrow_forward,
              ),

              const SizedBox(height: AppSpacing.sm),
            ],
          ),
        ),
      ),
    );
  }
}