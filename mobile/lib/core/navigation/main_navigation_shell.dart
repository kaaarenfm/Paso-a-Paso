import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/calendar/presentation/screens/calendar_screen.dart';
import '../../features/pet/presentation/screens/pet_screen.dart';
import '../../features/community/presentation/screens/community_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../ui/layout/app_shell_scaffold.dart';
import 'navigation_controller.dart';

class MainNavigationShell extends StatelessWidget {
  const MainNavigationShell({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = context.watch<NavigationController>();

    final pages = [

      const AppShellScaffold(
        title: "Inicio",
        child: HomeScreen(),
      ),

      const AppShellScaffold(
        title: "Calendario",
        child: CalendarScreen(),
      ),

      const AppShellScaffold(
        title: "Comunidad",
        child: CommunityScreen(),
      ),

      const AppShellScaffold(
        title: "Progreso",
        child: Placeholder(),
      ),
    ];

    return Scaffold(

      body: IndexedStack(
        index: controller.currentIndex,
        children: pages,
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: controller.currentIndex,
        onDestinationSelected: controller.changeIndex,
        destinations: const [

          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Home",
          ),

          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today),
            label: "Calendario",
          ),

          NavigationDestination(
            icon: Icon(Icons.public_outlined),
            selectedIcon: Icon(Icons.public),
            label: "Comunidad",
          ),

          NavigationDestination(
            icon: Icon(Icons.show_chart_outlined),
            selectedIcon: Icon(Icons.show_chart),
            label: "Progreso",
          ),
        ],
      ),
    );
  }
}
