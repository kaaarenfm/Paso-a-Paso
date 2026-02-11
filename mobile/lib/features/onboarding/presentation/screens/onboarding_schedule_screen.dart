import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/ui/layout/app_scaffold.dart';
import '../../../../../core/ui/layout/onboarding_header.dart';
import '../../../../../core/ui/buttons/primary_button.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/theme/app_spacing.dart';

class _TimeSlot {
  final String emoji;
  final String title;
  final String range;
  final Color color;
  final Color bgColor;

  const _TimeSlot({
    required this.emoji,
    required this.title,
    required this.range,
    required this.color,
    required this.bgColor,
  });
}

const _timeSlots = [
  _TimeSlot(
    emoji: "🌅",
    title: "Mañana",
    range: "5:00 – 9:00 am",
    color: Color(0xFFE07B39),
    bgColor: Color(0xFFFFF0E6),
  ),
  _TimeSlot(
    emoji: "☀️",
    title: "Mediodía",
    range: "10:00 am – 2:00 pm",
    color: Color(0xFFB09A20),
    bgColor: Color(0xFFFFFBE0),
  ),
  _TimeSlot(
    emoji: "🌇",
    title: "Tarde",
    range: "3:00 – 7:00 pm",
    color: AppTheme.blueDark,
    bgColor: AppTheme.blueLight,
  ),
  _TimeSlot(
    emoji: "🌙",
    title: "Noche",
    range: "8:00 pm – 12:00 am",
    color: Color(0xFF6B5CB8),
    bgColor: Color(0xFFEDE8FF),
  ),
];

class OnboardingScheduleScreen extends StatefulWidget {
  const OnboardingScheduleScreen({super.key});

  @override
  State<OnboardingScheduleScreen> createState() =>
      _OnboardingScheduleScreenState();
}

class _OnboardingScheduleScreenState extends State<OnboardingScheduleScreen>
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
                currentStep: 4,
                totalSteps: 5,
                title: "¿Cuándo prefieres\nhacer tus hábitos?",
                subtitle: "Puedes elegir varios momentos del día",
                onBack: () => Navigator.pop(context),
              ),

              const SizedBox(height: AppSpacing.lg),

              /// Lista de horarios
              Expanded(
                child: ListView.separated(
                  itemCount: _timeSlots.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final slot = _timeSlots[index];
                    final isSelected = _selected.contains(index);

                    return GestureDetector(
                      onTap: () {
                        HapticFeedback.selectionClick();
                        setState(() {
                          isSelected
                              ? _selected.remove(index)
                              : _selected.add(index);
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOut,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? slot.bgColor : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? slot.color
                                : AppTheme.grayCustom.withOpacity(0.15),
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isSelected
                                  ? slot.color.withOpacity(0.12)
                                  : Colors.black.withOpacity(0.03),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Text(slot.emoji,
                                style: const TextStyle(fontSize: 32)),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    slot.title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected
                                          ? slot.color
                                          : AppTheme.dark,
                                    ),
                                  ),
                                  Text(
                                    slot.range,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppTheme.grayCustom,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? slot.color
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? slot.color
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
                text: "Continuar",
                onPressed: () => Navigator.pushNamed(
                    context, AppRouter.onboardingMotivation),
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