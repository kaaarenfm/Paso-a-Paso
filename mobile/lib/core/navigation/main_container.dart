import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'navigation_controller.dart';
import 'main_navigation_shell.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NavigationController(),
        ),
      ],
      child: const MainNavigationShell(),
    );
  }
}
