import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/ui/layout/app_bottom_nav.dart';
import '../models/home_state.dart';
import '../widgets/home_empty_state.dart';
import '../widgets/home_routines_list.dart';
import '../widgets/home_header.dart';
import '../widgets/home_quote_card.dart';
import '../widgets/home_pet_companion.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnim;

  int _navIndex = 0;

  static const _routes = [
    null,          // Home (index 0, no navega)
    "/calendar",
    "/progress",
    "/community",
    "/profile",
  ];

  /// 🔥 temporal — luego vendrá del backend/local storage
  static const state = HomeState(
    hasRoutines: false,
    onboardingCompleted: false,
    contractSigned: false,
  );

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    if (index == 0) {
      setState(() => _navIndex = 0);
      return;
    }
    final route = _routes[index];
    if (route != null) Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.neutralBg,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.sm),

                /// Saludo + avatar
                const HomeHeader(),

                const SizedBox(height: AppSpacing.md),

                /// Mascota acompañante
                const HomePetCompanion(),

                const SizedBox(height: AppSpacing.md),

                /// Rutinas o empty state
                if (!state.hasRoutines)
                  const HomeEmptyState()
                else
                  const HomeRoutinesList(),

                const SizedBox(height: AppSpacing.md),

                /// Frase del día
                const HomeQuoteCard(),

                const SizedBox(height: AppSpacing.lg),
              ],
            ),
          ),
        ),
      ),

      /// Barra de navegación inferior
      bottomNavigationBar: AppBottomNav(
        currentIndex: _navIndex,
        onTap: _onNavTap,
      ),
    );
  }
}