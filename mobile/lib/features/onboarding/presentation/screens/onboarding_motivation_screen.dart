import 'package:flutter/material.dart';
import '../../../../../core/router/app_router.dart';

class OnboardingMotivationScreen extends StatelessWidget {
  const OnboardingMotivationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRouter.onboardingSummary,
            );
          },
          child: const Text("Motivación para entrenar"),
        ),
      ),
    );
  }
}
