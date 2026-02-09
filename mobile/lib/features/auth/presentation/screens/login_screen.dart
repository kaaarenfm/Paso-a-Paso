import 'package:flutter/material.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/ui/inputs/app_input.dart';
import '../../../../core/ui/buttons/primary_button.dart';
import '../../../../core/ui/layout/app_scaffold.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_spacing.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Iniciar Sesión",
      child: SingleChildScrollView(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.md),

                /// Bienvenida
                const Text(
                  "¡Bienvenido de nuevo!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.dark,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  "Inicia sesión para continuar con tus hábitos",
                  style: TextStyle(
                    fontSize: 15,
                    color: AppTheme.grayCustom,
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                /// Email
                AppInput(
                  label: "Correo electrónico",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                ),

                const SizedBox(height: AppSpacing.sm),

                /// Password
                AppInput(
                  label: "Contraseña",
                  controller: _passwordController,
                  obscure: true,
                  prefixIcon: Icons.lock_outlined,
                ),

                const SizedBox(height: AppSpacing.md),

                /// Botón Login
                PrimaryButton(
                  text: "Iniciar Sesión",
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRouter.onboardingIntro,
                    );
                  },
                ),

                const SizedBox(height: AppSpacing.sm),

                /// Olvidé contraseña
                Center(
                  child: TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRouter.forgotPassword),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.sm,
                        horizontal: AppSpacing.sm,
                      ),
                    ),
                    child: Text(
                      "¿Olvidaste tu contraseña?",
                      style: TextStyle(
                        color: AppTheme.greenDark,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.md),

                /// Divider con texto
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppTheme.grayCustom.withOpacity(0.3),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                      ),
                      child: Text(
                        "o",
                        style: TextStyle(
                          color: AppTheme.grayCustom,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: AppTheme.grayCustom.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.md),

                /// Crear cuenta
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "¿No tienes cuenta? ",
                        style: TextStyle(
                          color: AppTheme.grayCustom,
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRouter.register);
                        },
                        child: Text(
                          "Regístrate",
                          style: TextStyle(
                            color: AppTheme.greenDark,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.md),
              ],
            ),
          ),
        ),
      ),
    );
  }
}