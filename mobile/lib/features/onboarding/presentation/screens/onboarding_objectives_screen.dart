import 'package:flutter/material.dart';
import '../../../../../core/router/app_router.dart';

class OnboardingObjectivesScreen extends StatelessWidget {
  const OnboardingObjectivesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRouter.onboardingCategories,
            );
          },
          child: const Text("Continuar a Categorías"),
        ),
      ),
    );
  }
}
