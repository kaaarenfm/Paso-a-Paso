import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/ui/inputs/app_input.dart';
import '../../../../core/ui/buttons/primary_button.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/state/app_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  // Controllers
  final _nombreController = TextEditingController();
  final _apellidoPaternoController = TextEditingController();
  final _apellidoMaternoController = TextEditingController();
  final _correoController = TextEditingController();
  final _contrasenaController = TextEditingController();
  final _confirmarContrasenaController = TextEditingController();

  File? _fotoPerfil;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoPaternoController.dispose();
    _apellidoMaternoController.dispose();
    _correoController.dispose();
    _contrasenaController.dispose();
    _confirmarContrasenaController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 75,
    );

    if (image != null) {
      setState(() {
        _fotoPerfil = File(image.path);
      });
    }
  }

  bool _validateCurrentStep() {
    if (_currentStep == 0) {
      return _nombreController.text.isNotEmpty &&
          _apellidoPaternoController.text.isNotEmpty &&
          _apellidoMaternoController.text.isNotEmpty;
    } else if (_currentStep == 1) {
      return _correoController.text.isNotEmpty &&
          _correoController.text.contains('@');
    } else if (_currentStep == 2) {
      return _contrasenaController.text.isNotEmpty &&
          _contrasenaController.text.length >= 6 &&
          _contrasenaController.text == _confirmarContrasenaController.text;
    }
    return true;
  }

  void _nextStep() {
    if (_validateCurrentStep()) {
      if (_currentStep < 3) {
        setState(() {
          _currentStep++;
        });
      } else {
        _submitRegistration();
      }
    } else {
      _showValidationError();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _showValidationError() {
    String message = '';
    if (_currentStep == 0) {
      message = 'Por favor completa todos los campos del nombre';
    } else if (_currentStep == 1) {
      message = 'Ingresa un correo electrónico válido';
    } else if (_currentStep == 2) {
      if (_contrasenaController.text.length < 6) {
        message = 'La contraseña debe tener al menos 6 caracteres';
      } else {
        message = 'Las contraseñas no coinciden';
      }
    }

    _showError(message);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.redDark,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Future<void> _submitRegistration() async {
    final appState = context.read<AppState>();
    
    try {
      await appState.register(
        nombre: _nombreController.text,
        apellidoPaterno: _apellidoPaternoController.text,
        apellidoMaterno: _apellidoMaternoController.text,
        email: _correoController.text,
        password: _contrasenaController.text,
      );
      
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          AppRouter.onboardingIntro,
        );
      }
    } catch (e) {
      if (mounted) {
        _showError(e.toString().replaceAll('Exception: ', ''));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.neutralBg,
      appBar: AppBar(
        title: const Text(
          "Crear Cuenta",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            /// Progress Indicator
            _buildProgressIndicator(),

            /// Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: Form(
                  key: _formKey,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.1, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: _buildStepContent(),
                  ),
                ),
              ),
            ),

            /// Navigation Buttons
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: List.generate(4, (index) {
          final isActive = index <= _currentStep;

          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppTheme.greenDark
                          : AppTheme.grayCustom.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                if (index < 3) const SizedBox(width: 4),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildStepPersonalInfo();
      case 1:
        return _buildStepEmail();
      case 2:
        return _buildStepPassword();
      case 3:
        return _buildStepPhoto();
      default:
        return Container();
    }
  }

  Widget _buildStepPersonalInfo() {
    final appState = context.watch<AppState>();
    return Column(
      key: const ValueKey(0),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.xs),
        const Text(
          "Información Personal",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.dark,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          "Cuéntanos cómo te llamas",
          style: TextStyle(
            fontSize: 15,
            color: AppTheme.grayCustom,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        AppInput(
          label: "Nombre(s)",
          controller: _nombreController,
          prefixIcon: Icons.person_outline,
          hint: "Ej: Juan Carlos",
          enabled: !appState.isLoading,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppInput(
          label: "Apellido Paterno",
          controller: _apellidoPaternoController,
          prefixIcon: Icons.badge_outlined,
          hint: "Ej: García",
          enabled: !appState.isLoading,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppInput(
          label: "Apellido Materno",
          controller: _apellidoMaternoController,
          prefixIcon: Icons.badge_outlined,
          hint: "Ej: López",
          enabled: !appState.isLoading,
        ),
      ],
    );
  }

  Widget _buildStepEmail() {
    final appState = context.watch<AppState>();
    return Column(
      key: const ValueKey(1),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.xs),
        const Text(
          "Correo Electrónico",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.dark,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          "Usaremos tu correo para iniciar sesión",
          style: TextStyle(
            fontSize: 15,
            color: AppTheme.grayCustom,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        AppInput(
          label: "Correo Electrónico",
          controller: _correoController,
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icons.email_outlined,
          hint: "ejemplo@correo.com",
          enabled: !appState.isLoading,
        ),
      ],
    );
  }

  Widget _buildStepPassword() {
    final appState = context.watch<AppState>();
    return Column(
      key: const ValueKey(2),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.xs),
        const Text(
          "Contraseña",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.dark,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          "Crea una contraseña segura (mínimo 6 caracteres)",
          style: TextStyle(
            fontSize: 15,
            color: AppTheme.grayCustom,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        AppInput(
          label: "Contraseña",
          controller: _contrasenaController,
          obscure: true,
          prefixIcon: Icons.lock_outlined,
          hint: "Mínimo 6 caracteres",
          enabled: !appState.isLoading,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppInput(
          label: "Confirmar Contraseña",
          controller: _confirmarContrasenaController,
          obscure: true,
          prefixIcon: Icons.lock_outlined,
          hint: "Ingresa la misma contraseña",
          enabled: !appState.isLoading,
        ),
      ],
    );
  }

  Widget _buildStepPhoto() {
    return Column(
      key: const ValueKey(3),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.xs),
        const Text(
          "Foto de Perfil",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.dark,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          "Opcional - Puedes agregar una foto o hacerlo después",
          style: TextStyle(
            fontSize: 15,
            color: AppTheme.grayCustom,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: AppTheme.greenLight,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppTheme.greenDark,
                      width: 3,
                    ),
                  ),
                  child: _fotoPerfil != null
                      ? ClipOval(
                          child: Image.file(
                            _fotoPerfil!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(
                          Icons.camera_alt_outlined,
                          size: 50,
                          color: AppTheme.greenDark,
                        ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              TextButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.add_photo_alternate_outlined),
                label: Text(
                  _fotoPerfil != null ? "Cambiar foto" : "Seleccionar foto",
                ),
                style: TextButton.styleFrom(
                  foregroundColor: AppTheme.greenDark,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  
    Widget _buildNavigationButtons() {
      final appState = context.watch<AppState>();
      return Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              if (_currentStep > 0)
                Expanded(
                  child: PrimaryButton(
                    text: "Atrás",
                    onPressed: appState.isLoading ? null : () => _previousStep(),
                    outlined: true,
                  ),
                ),
              if (_currentStep > 0) const SizedBox(width: AppSpacing.sm),
              Expanded(
                flex: _currentStep == 0 ? 1 : 1,
                child: PrimaryButton(
                  text: appState.isLoading 
                      ? "Cargando..." 
                      : (_currentStep == 3 ? "Finalizar" : "Continuar"),
                  onPressed: appState.isLoading ? null : () => _nextStep(),
                  icon: appState.isLoading 
                      ? null 
                      : (_currentStep == 3 ? Icons.check : Icons.arrow_forward),
                ),
              ),
            ],
          ),
        ),
      );
    }
}