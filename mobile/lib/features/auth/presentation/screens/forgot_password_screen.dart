import 'package:flutter/material.dart';
import '../../../../core/ui/inputs/app_input.dart';
import '../../../../core/ui/buttons/primary_button.dart';
import '../../../../core/ui/layout/app_scaffold.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_spacing.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

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
        curve: Curves.easeOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetEmail() async {
    if (_emailController.text.isEmpty ||
        !_emailController.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Por favor ingresa un correo válido'),
          backgroundColor: AppTheme.redDark,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _emailSent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Recuperar Contraseña",
      child: SingleChildScrollView(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: _emailSent ? _buildSuccessView() : _buildFormView(),
          ),
        ),
      ),
    );
  }

  Widget _buildFormView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.md),

        /// Icono
        Center(
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppTheme.blueDark.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.lock_reset,
              size: 60,
              color: AppTheme.blueDark,
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        /// Título
        const Text(
          "¿Olvidaste tu contraseña?",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppTheme.dark,
          ),
        ),

        const SizedBox(height: AppSpacing.sm),

        /// Descripción
        Text(
          "No te preocupes, ingresa tu correo electrónico y te enviaremos instrucciones para recuperar tu contraseña.",
          style: TextStyle(
            fontSize: 15,
            color: AppTheme.grayCustom,
            height: 1.5,
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        /// Input Email
        AppInput(
          label: "Correo Electrónico",
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icons.email_outlined,
          hint: "ejemplo@correo.com",
        ),

        const SizedBox(height: AppSpacing.md),

        /// Botón Enviar
        PrimaryButton(
          text: "Enviar Instrucciones",
          onPressed: _sendResetEmail,
          isLoading: _isLoading,
          icon: Icons.send_outlined,
        ),

        const SizedBox(height: AppSpacing.sm),

        /// Regresar al login
        Center(
          child: TextButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, size: 18),
            label: const Text("Volver al inicio de sesión"),
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.greenDark,
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.sm,
                horizontal: AppSpacing.sm,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessView() {
    return Column(
      children: [
        const SizedBox(height: AppSpacing.xl),

        /// Icono de éxito
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppTheme.greenLight,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.mark_email_read_outlined,
            size: 80,
            color: AppTheme.greenDark,
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        /// Título éxito
        const Text(
          "¡Correo Enviado!",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppTheme.dark,
          ),
        ),

        const SizedBox(height: AppSpacing.sm),

        /// Descripción
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            "Hemos enviado las instrucciones de recuperación a:\n\n${_emailController.text}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: AppTheme.grayCustom,
              height: 1.6,
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        /// Info adicional
        Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppTheme.blueLight.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.info_outline,
                color: AppTheme.blueDark,
                size: 24,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  "Revisa tu bandeja de entrada y spam. El correo puede tardar unos minutos.",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.blueDark,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        /// Botón volver
        PrimaryButton(
          text: "Volver al Inicio de Sesión",
          onPressed: () => Navigator.pop(context),
          icon: Icons.arrow_back,
        ),

        const SizedBox(height: AppSpacing.sm),

        /// Reenviar correo
        TextButton(
          onPressed: () {
            setState(() {
              _emailSent = false;
            });
          },
          child: const Text("¿No recibiste el correo? Reintentar"),
          style: TextButton.styleFrom(
            foregroundColor: AppTheme.greenDark,
          ),
        ),
      ],
    );
  }
}