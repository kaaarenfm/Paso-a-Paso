// AppRouter - Configuración de rutas de la aplicación
import 'package:flutter/material.dart';
import '../../features/routine_creation/presentation/screens/routine_moment_screen.dart';
import '../../features/routine_creation/presentation/screens/routine_type_screen.dart';
import '../../features/routine_creation/presentation/screens/routine_habits_screen.dart';
import '../../features/routine_creation/presentation/screens/routine_frequency_screen.dart';
import '../../features/routine_creation/presentation/screens/routine_reminders_screen.dart';
import '../../features/routine_creation/presentation/screens/routine_confirm_screen.dart';
import '../../features/calendar/presentation/screens/calendar_screen.dart';
import '../../features/habit_tracking/presentation/screens/habit_detail_screen.dart';
import '../../features/pet/presentation/screens/pet_screen.dart';
import '../../features/pet/presentation/screens/pet_selection_screen.dart';
import '../../features/community/presentation/screens/community_screen.dart';
import '../../features/community/presentation/screens/community_routine_detail_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/premium_plan_screen.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';
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

import '../../core/navigation/main_container.dart';


class AppRouter {
  static const splash = '/';
  static const welcome = '/welcome';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const mainContainer = '/app';


  static const onboardingIntro = '/onboarding-intro';
  static const onboardingObjectives = '/onboarding-objectives';
  static const onboardingCategories = '/onboarding-categories';
  static const onboardingLevel = '/onboarding-level';
  static const onboardingSchedule = '/onboarding-schedule';
  static const onboardingMotivation = '/onboarding-motivation';
  static const onboardingSummary = '/onboarding-summary';

  static const contract = '/contract';
  
  // Routine Creation Wizard
  static const routineMoment = '/routine-moment';
  static const routineType = '/routine-type';
  static const routineHabits = '/routine-habits';
  static const routineFrequency = '/routine-frequency';
  static const routineReminders = '/routine-reminders';
  static const routineConfirm = '/routine-confirm';
  
  static const calendar = '/calendar';
  static const habitDetail = '/habit-detail';
  static const petScreen = '/pet';
  static const petSelection = '/pet-selection';
  
  static const community = '/community';
  static const communityRoutineDetail = '/community-routine-detail';
  
  static const profile = '/profile';
  static const premiumPlan = '/premium-plan';
  
  static const notifications = '/notifications';

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

      // Routine Creation Routes
      case routineMoment:
        return MaterialPageRoute(
            builder: (_) => const RoutineMomentScreen());
      case routineType:
        return MaterialPageRoute(
            builder: (_) => const RoutineTypeScreen());
      case routineHabits:
        return MaterialPageRoute(
            builder: (_) => const RoutineHabitsScreen());
      case routineFrequency:
        return MaterialPageRoute(
            builder: (_) => const RoutineFrequencyScreen());
      case routineReminders:
        return MaterialPageRoute(
            builder: (_) => const RoutineRemindersScreen());
      case routineConfirm:
        return MaterialPageRoute(
            builder: (_) => const RoutineConfirmScreen());

      case calendar:
        return MaterialPageRoute(
            builder: (_) => const CalendarScreen());

      case habitDetail:
        return MaterialPageRoute(
            builder: (_) => const HabitDetailScreen());

      case petScreen:
        return MaterialPageRoute(
            builder: (_) => const PetScreen());

      case petSelection:
        return MaterialPageRoute(
            builder: (_) => const PetSelectionScreen());

      case community:
        return MaterialPageRoute(
            builder: (_) => const CommunityScreen());

      case communityRoutineDetail:
        return MaterialPageRoute(
            builder: (_) => const CommunityRoutineDetailScreen());

      case profile:
        return MaterialPageRoute(
            builder: (_) => const ProfileScreen());

      case premiumPlan:
        return MaterialPageRoute(
            builder: (_) => const PremiumPlanScreen());

      case notifications:
        return MaterialPageRoute(
            builder: (_) => const NotificationsScreen());

      case mainContainer:
        return MaterialPageRoute(
          builder: (_) => const MainContainer(),
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
