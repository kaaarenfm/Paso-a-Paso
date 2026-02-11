import 'package:flutter/material.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/ui/layout/app_scaffold.dart';
import '../../../../../core/ui/buttons/primary_button.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/theme/app_spacing.dart';

class _Objective {
  final String emoji;
  final String title;
  final String subtitle;

  const _Objective({
    required this.emoji,
    required this.title,
    required this.subtitle,
  });
}

const _objectives = [
  _Objective(
    emoji: "💪",
    title: "Mejorar mi salud",
    subtitle: "Ejercicio, sueño, hidratación",
  ),
  _Objective(
    emoji: "🧠",
    title: "Desarrollo personal",
    subtitle: "Lectura, meditación, aprendizaje",
  ),
  _Objective(
    emoji: "⏰",
    title: "Ser más productivo",
    subtitle: "Rutinas, organización, metas",
  ),
  _Objective(
    emoji: "😌",
    title: "Reducir el estrés",
    subtitle: "Mindfulness, respiración, descanso",
  ),
  _Objective(
    emoji: "🤝",
    title: "Mejorar relaciones",
    subtitle: "Familia, pareja, amigos",
  ),
  _Objective(
    emoji: "✨",
    title: "Otro objetivo",
    subtitle: "Defínelo tú mismo",
  ),
];

class OnboardingObjectivesScreen extends StatefulWidget {
  const OnboardingObjectivesScreen({super.key});

  @override
  State<OnboardingObjectivesScreen> createState() =>
      _OnboardingObjectivesScreenState();
}

class _OnboardingObjectivesScreenState
    extends State<OnboardingObjectivesScreen>
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
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleSelection(int index) {
    setState(() {
      if (_selected.contains(index)) {
        _selected.remove(index);
      } else {
        _selected.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        children: [
          /// Header
          FadeTransition(
            opacity: _fadeAnim,
            child: SlideTransition(
              position: _slideAnim,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Paso
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.greenLight,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Paso 1 de 2",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.greenDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  const Text(
                    "¿Cuál es tu objetivo\nprincipal?",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.dark,
                      height: 1.2,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    "Puedes elegir uno o varios",
                    style: TextStyle(
                      fontSize: 15,
                      color: AppTheme.grayCustom,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          /// Grid de opciones
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppSpacing.sm,
                  mainAxisSpacing: AppSpacing.sm,
                  childAspectRatio: 1.1,
                ),
                itemCount: _objectives.length,
                itemBuilder: (context, index) {
                  final obj = _objectives[index];
                  final isSelected = _selected.contains(index);

                  return GestureDetector(
                    onTap: () => _toggleSelection(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.greenLight : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? AppTheme.greenDark
                              : AppTheme.grayCustom.withOpacity(0.15),
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: AppTheme.greenDark.withOpacity(0.15),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                ),
                              ]
                            : [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 8,
                                ),
                              ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// Check indicator
                          Align(
                            alignment: Alignment.topRight,
                            child: AnimatedContainer(
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
                                  width: 1.5,
                                ),
                              ),
                              child: isSelected
                                  ? const Icon(
                                      Icons.check,
                                      size: 14,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          ),

                          const SizedBox(height: AppSpacing.xs),

                          Text(
                            obj.emoji,
                            style: const TextStyle(fontSize: 32),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            obj.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? AppTheme.dark
                                  : AppTheme.dark,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            obj.subtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11,
                              color: AppTheme.grayCustom,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          /// Botón continuar
          FadeTransition(
            opacity: _fadeAnim,
            child: PrimaryButton(
              text: _selected.isEmpty
                  ? "Continuar sin selección"
                  : "Continuar (${_selected.length} ${_selected.length == 1 ? 'objetivo' : 'objetivos'})",
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.onboardingCategories);
              },
              icon: Icons.arrow_forward,
            ),
          ),

          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}