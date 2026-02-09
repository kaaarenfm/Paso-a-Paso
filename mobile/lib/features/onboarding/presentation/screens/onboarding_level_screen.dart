import 'package:flutter/material.dart';
import '../../../../../core/router/app_router.dart';

class OnboardingLevelScreen extends StatelessWidget {
  const OnboardingLevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRouter.onboardingSchedule,
            );
          },
          child: const Text("Nivel actual"),
        ),
      ),
    );
  }
}
