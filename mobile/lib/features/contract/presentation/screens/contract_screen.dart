import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../core/ui/layout/app_scaffold.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_spacing.dart';

class ContractScreen extends StatefulWidget {
  const ContractScreen({super.key});

  @override
  State<ContractScreen> createState() => _ContractScreenState();
}

class _ContractScreenState extends State<ContractScreen>
    with TickerProviderStateMixin {
  // Animación entrada
  late AnimationController _entryController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  // Animación del botón hold
  late AnimationController _holdController;
  late Animation<double> _progressAnim;

  bool _signed = false;

  @override
  void initState() {
    super.initState();

    // Entry animation
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _entryController, curve: Curves.easeOut),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _entryController, curve: Curves.easeOut),
    );
    _entryController.forward();

    // Hold progress animation (2.5 segundos para completar)
    _holdController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    _progressAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _holdController, curve: Curves.easeInOut),
    );

    _holdController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        HapticFeedback.heavyImpact();
        setState(() {
          _signed = true;
        });
        Future.delayed(const Duration(milliseconds: 1200), () {
          if (mounted) {
            Navigator.pushReplacementNamed(context, AppRouter.mainContainer);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _entryController.dispose();
    _holdController.dispose();
    super.dispose();
  }

  void _onHoldStart() {
    if (_signed) return;
    HapticFeedback.lightImpact();
    _holdController.forward();
  }

  void _onHoldEnd() {
    if (_signed) return;
    if (!_holdController.isCompleted) {
      _holdController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Compromiso Personal",
      child: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: Column(
            children: [
              /// Contenido scrollable
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppSpacing.sm),

                      /// Ícono decorativo
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color: AppTheme.yellowLight,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.yellow.withOpacity(0.35),
                                blurRadius: 24,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: const Text(
                            "🤝",
                            style: TextStyle(fontSize: 48),
                          ),
                        ),
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      /// Título
                      const Text(
                        "Tu compromiso contigo mismo",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.dark,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        "Las personas que se comprometen formalmente tienen más probabilidades de mantener sus hábitos.",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.grayCustom,
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      /// Card del contrato
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppTheme.grayCustom.withOpacity(0.15),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.greenLight,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                "📋 Mi Contrato",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.greenDark,
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            const Text(
                              "Yo me comprometo a:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.dark,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            ..._contractPoints.map(
                              (point) => Padding(
                                padding:
                                    const EdgeInsets.only(bottom: AppSpacing.xs),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 6),
                                      width: 7,
                                      height: 7,
                                      decoration: const BoxDecoration(
                                        color: AppTheme.greenDark,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: AppSpacing.sm),
                                    Expanded(
                                      child: Text(
                                        point,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: AppTheme.dark,
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                  ],
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

              /// Botón de firma + Skip
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (child, anim) => FadeTransition(
                  opacity: anim,
                  child: ScaleTransition(scale: anim, child: child),
                ),
                child: _signed
                    ? _buildSignedState()
                    : _buildHoldButton(),
              ),

              const SizedBox(height: AppSpacing.xs),

              if (!_signed)
                TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, AppRouter.mainContainer),
                  style: TextButton.styleFrom(
                    foregroundColor: AppTheme.grayCustom,
                  ),
                  child: const Text("Omitir por ahora"),
                ),

              const SizedBox(height: AppSpacing.sm),
            ],
          ),
        ),
      ),
    );
  }

  /// Botón "mantener presionado"
  Widget _buildHoldButton() {
    return GestureDetector(
      key: const ValueKey('hold'),
      onTapDown: (_) => _onHoldStart(),
      onTapUp: (_) => _onHoldEnd(),
      onTapCancel: _onHoldEnd,
      child: AnimatedBuilder(
        animation: _holdController,
        builder: (context, _) {
          final progress = _progressAnim.value;

          return Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppTheme.neutralBg,
              border: Border.all(
                color: AppTheme.greenDark.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                /// Barra de progreso de fondo
                AnimatedContainer(
                  duration: Duration.zero,
                  width: MediaQuery.of(context).size.width * progress,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.greenDark.withOpacity(0.85),
                        AppTheme.greenDark,
                      ],
                    ),
                  ),
                ),

                /// Contenido del botón
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// Ícono animado
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: progress > 0
                            ? const Icon(
                                Icons.draw_rounded,
                                key: ValueKey('draw'),
                                color: Colors.white,
                                size: 20,
                              )
                            : Icon(
                                Icons.touch_app_outlined,
                                key: const ValueKey('touch'),
                                color: AppTheme.greenDark,
                                size: 20,
                              ),
                      ),
                      const SizedBox(width: AppSpacing.xs),

                      /// Texto dinámico
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          _getButtonLabel(progress),
                          key: ValueKey(_getButtonLabel(progress)),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: progress > 0.15
                                ? Colors.white
                                : AppTheme.greenDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getButtonLabel(double progress) {
    if (progress == 0) return "Mantén presionado para firmar ✍️";
    if (progress < 0.4) return "Firmando...";
    if (progress < 0.8) return "Casi listo...";
    return "¡Suelta para confirmar!";
  }

  /// Estado firmado
  Widget _buildSignedState() {
    return Container(
      key: const ValueKey('signed'),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppTheme.greenLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.greenDark.withOpacity(0.3),
        ),
      ),
      child: const Column(
        children: [
          Text("🎉", style: TextStyle(fontSize: 28)),
          SizedBox(height: 4),
          Text(
            "¡Compromiso firmado!",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.greenDark,
            ),
          ),
          SizedBox(height: 2),
          Text(
            "Redirigiendo...",
            style: TextStyle(
              fontSize: 13,
              color: AppTheme.greenDark,
            ),
          ),
        ],
      ),
    );
  }
}

const List<String> _contractPoints = [
  "Trabajar en mis hábitos con constancia y paciencia.",
  "No rendirme ante los días difíciles.",
  "Celebrar mis pequeños avances cada día.",
  "Ser amable conmigo mismo cuando falle.",
];