import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/ui/layout/app_scaffold.dart';
import '../../../../../core/ui/layout/onboarding_header.dart';
import '../../../../../core/ui/buttons/primary_button.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/theme/app_spacing.dart';

class _Category {
  final String emoji;
  final String title;
  final Color color;
  final Color bgColor;

  const _Category({
    required this.emoji,
    required this.title,
    required this.color,
    required this.bgColor,
  });
}

const _categories = [
  _Category(
    emoji: "🏃",
    title: "Ejercicio",
    color: AppTheme.greenDark,
    bgColor: AppTheme.greenLight,
  ),
  _Category(
    emoji: "🥗",
    title: "Nutrición",
    color: Color(0xFF5B9E6F),
    bgColor: Color(0xFFE0F4E8),
  ),
  _Category(
    emoji: "🧘",
    title: "Meditación",
    color: AppTheme.blueDark,
    bgColor: AppTheme.blueLight,
  ),
  _Category(
    emoji: "📚",
    title: "Lectura",
    color: Color(0xFFB07C3E),
    bgColor: Color(0xFFFFF3E0),
  ),
  _Category(
    emoji: "💧",
    title: "Hidratación",
    color: Color(0xFF3E8FB0),
    bgColor: Color(0xFFE0F4FF),
  ),
  _Category(
    emoji: "😴",
    title: "Sueño",
    color: Color(0xFF7B6FB0),
    bgColor: Color(0xFFEDE8FF),
  ),
  _Category(
    emoji: "💸",
    title: "Finanzas",
    color: Color(0xFF8B9E3A),
    bgColor: Color(0xFFF3F8D0),
  ),
  _Category(
    emoji: "🎨",
    title: "Creatividad",
    color: AppTheme.redDark,
    bgColor: Color(0xFFFFE8E9),
  ),
];

class OnboardingCategoriesScreen extends StatefulWidget {
  const OnboardingCategoriesScreen({super.key});

  @override
  State<OnboardingCategoriesScreen> createState() =>
      _OnboardingCategoriesScreenState();
}

class _OnboardingCategoriesScreenState
    extends State<OnboardingCategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  final Set<int> _selected = {};

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

  void _toggle(int index) {
    HapticFeedback.selectionClick();
    setState(() {
      _selected.contains(index) ? _selected.remove(index) : _selected.add(index);
    });
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
                currentStep: 2,
                totalSteps: 5,
                title: "¿Qué hábitos quieres\nconstruir?",
                subtitle: "Elige las categorías que más te interesan",
                onBack: () => Navigator.pop(context),
              ),

              const SizedBox(height: AppSpacing.lg),

              /// Grid de categorías
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppSpacing.sm,
                    mainAxisSpacing: AppSpacing.sm,
                    childAspectRatio: 1.25,
                  ),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final cat = _categories[index];
                    final isSelected = _selected.contains(index);

                    return GestureDetector(
                      onTap: () => _toggle(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut,
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: isSelected ? cat.bgColor : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? cat.color
                                : AppTheme.grayCustom.withOpacity(0.15),
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isSelected
                                  ? cat.color.withOpacity(0.15)
                                  : Colors.black.withOpacity(0.04),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? cat.color
                                        : Colors.transparent,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? cat.color
                                          : AppTheme.grayCustom.withOpacity(0.3),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: isSelected
                                      ? const Icon(Icons.check,
                                          size: 12, color: Colors.white)
                                      : null,
                                ),
                              ],
                            ),
                            Text(cat.emoji,
                                style: const TextStyle(fontSize: 30)),
                            const SizedBox(height: 6),
                            Text(
                              cat.title,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? cat.color : AppTheme.dark,
                              ),
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
                text: _selected.isEmpty
                    ? "Continuar sin selección"
                    : "Continuar (${_selected.length} ${_selected.length == 1 ? 'categoría' : 'categorías'})",
                onPressed: () =>
                    Navigator.pushNamed(context, AppRouter.onboardingLevel),
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