import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_spacing.dart';

class HomePetCompanion extends StatefulWidget {
  const HomePetCompanion({super.key});

  @override
  State<HomePetCompanion> createState() => _HomePetCompanionState();
}

class _HomePetCompanionState extends State<HomePetCompanion>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _bubbleController;
  late Animation<double> _floatAnim;
  late Animation<double> _bubbleAnim;

  bool _showBubble = true;

  // 🔥 Mock: mensaje basado en progreso del día
  final String _petMessage = "¡Ánimo! Llevas 2 de 4 hábitos hoy 💪";
  final String _petMood = "😊"; // cambia según estado real

  @override
  void initState() {
    super.initState();

    // Flotación suave
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _floatAnim = Tween<double>(begin: -4, end: 4).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // Burbuja con fade-in
    _bubbleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _bubbleAnim = CurvedAnimation(
      parent: _bubbleController,
      curve: Curves.easeOut,
    );
    _bubbleController.forward();

    // Auto-ocultar burbuja a los 5 segundos
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) _dismissBubble();
    });
  }

  void _dismissBubble() {
    _bubbleController.reverse().then((_) {
      if (mounted) setState(() => _showBubble = false);
    });
  }

  void _tapPet() {
    setState(() => _showBubble = true);
    _bubbleController.forward(from: 0);
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) _dismissBubble();
    });
  }

  @override
  void dispose() {
    _floatController.dispose();
    _bubbleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        /// Mascota flotante
        GestureDetector(
          onTap: _tapPet,
          child: AnimatedBuilder(
            animation: _floatAnim,
            builder: (context, child) => Transform.translate(
              offset: Offset(0, _floatAnim.value),
              child: child,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                /// Sombra de suelo
                Positioned(
                  bottom: -6,
                  left: 0,
                  right: 0,
                  child: AnimatedBuilder(
                    animation: _floatAnim,
                    builder: (context, _) {
                      final shadowScale =
                          1.0 - (_floatAnim.value + 4) / 16;
                      return Center(
                        child: Container(
                          width: 50 * shadowScale,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                /// Cuerpo de la mascota
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppTheme.greenLight,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppTheme.greenDark.withOpacity(0.3),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.greenDark.withOpacity(0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "🐣",
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                ),

                /// Nivel badge
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppTheme.greenDark,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Nv1",
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: AppSpacing.sm),

        /// Burbuja de diálogo
        if (_showBubble)
          Expanded(
            child: FadeTransition(
              opacity: _bubbleAnim,
              child: ScaleTransition(
                scale: _bubbleAnim,
                alignment: Alignment.bottomLeft,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    /// Burbuja
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(14),
                          topRight: Radius.circular(14),
                          bottomRight: Radius.circular(14),
                          bottomLeft: Radius.circular(4),
                        ),
                        border: Border.all(
                          color: AppTheme.greenDark.withOpacity(0.15),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Text(
                            _petMood,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              _petMessage,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppTheme.dark,
                                height: 1.4,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: _dismissBubble,
                            child: Icon(
                              Icons.close_rounded,
                              size: 14,
                              color: AppTheme.grayCustom.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}