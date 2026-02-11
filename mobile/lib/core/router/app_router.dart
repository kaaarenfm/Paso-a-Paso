// AppRouter - Configuración de rutas de la aplicación
import 'package:flutter/material.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/welcome_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';

import '../../features/onboarding/presentation/screens/onboarding_intro_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_objectives_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_categories_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_level_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_schedule_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_motivation_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_summary_screen.dart';

import '../../features/contract/presentation/screens/contract_screen.dart';
import '../../features/home/screens/home_screen.dart';


class AppRouter {
  static const splash = '/';
  static const welcome = '/welcome';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const home = '/home';


  static const onboardingIntro = '/onboarding-intro';
  static const onboardingObjectives = '/onboarding-objectives';
  static const onboardingCategories = '/onboarding-categories';
  static const onboardingLevel = '/onboarding-level';
  static const onboardingSchedule = '/onboarding-schedule';
  static const onboardingMotivation = '/onboarding-motivation';
  static const onboardingSummary = '/onboarding-summary';

  static const contract = '/contract';

  static const createRoutine = '/create-routine';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());

      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

      case onboardingIntro:
        return MaterialPageRoute(
          builder: (_) => const OnboardingIntroScreen());

      case onboardingObjectives:
        return MaterialPageRoute(
            builder: (_) => const OnboardingObjectivesScreen());

      case onboardingCategories:
        return MaterialPageRoute(
            builder: (_) => const OnboardingCategoriesScreen());

      case onboardingLevel:
        return MaterialPageRoute(
            builder: (_) => const OnboardingLevelScreen());

      case onboardingSchedule:
        return MaterialPageRoute(
            builder: (_) => const OnboardingScheduleScreen());

      case onboardingMotivation:
        return MaterialPageRoute(
            builder: (_) => const OnboardingMotivationScreen());

      case onboardingSummary:
        return MaterialPageRoute(
            builder: (_) => const OnboardingSummaryScreen());

      case contract:
        return MaterialPageRoute(
            builder: (_) => const ContractScreen());

      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Pantalla no encontrada')),
          ),
        );
    }
  }
}
