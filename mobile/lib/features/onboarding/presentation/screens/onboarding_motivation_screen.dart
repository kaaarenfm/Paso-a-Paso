import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/ui/layout/app_scaffold.dart';
import '../../../../../core/ui/layout/onboarding_header.dart';
import '../../../../../core/ui/buttons/primary_button.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/theme/app_spacing.dart';

const _motivations = [
  ("🏆", "Quiero lograr una meta específica"),
  ("❤️", "Quiero sentirme mejor conmigo mismo"),
  ("👨‍👩‍👧", "Quiero ser un ejemplo para otros"),
  ("🧠", "Quiero mejorar mi salud mental"),
  ("⚡", "Quiero tener más energía"),
  ("🌟", "Quiero crecer como persona"),
];

class OnboardingMotivationScreen extends StatefulWidget {
  const OnboardingMotivationScreen({super.key});

  @override
  State<OnboardingMotivationScreen> createState() =>
      _OnboardingMotivationScreenState();
}

class _OnboardingMotivationScreenState
    extends State<OnboardingMotivationScreen>
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
                currentStep: 5,
                totalSteps: 5,
                title: "¿Qué te motiva\na mejorar?",
                subtitle: "Elige la razón que más te representa",
                onBack: () => Navigator.pop(context),
              ),

              const SizedBox(height: AppSpacing.lg),

              Expanded(
                child: ListView.separated(
                  itemCount: _motivations.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final (emoji, text) = _motivations[index];
                    final isSelected = _selected == index;

                    return GestureDetector(
                      onTap: () {
                        HapticFeedback.selectionClick();
                        setState(() => _selected = index);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOut,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? AppTheme.greenLight : Colors.white,
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
                                  ? AppTheme.greenDark.withOpacity(0.1)
                                  : Colors.black.withOpacity(0.03),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Text(emoji, style: const TextStyle(fontSize: 28)),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                text,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: AppTheme.dark,
                                  height: 1.3,
                                ),
                              ),
                            ),
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
                                      size: 13, color: Colors.white)
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
                text: "Ver mi resumen",
                onPressed: () => Navigator.pushNamed(
                    context, AppRouter.onboardingSummary),
                icon: Icons.checklist_rounded,
              ),

              const SizedBox(height: AppSpacing.sm),
            ],
          ),
        ),
      ),
    );
  }
}