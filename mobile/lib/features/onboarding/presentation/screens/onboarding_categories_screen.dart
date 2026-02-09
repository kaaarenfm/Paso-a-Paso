import 'package:flutter/material.dart';
import '../../../../../core/router/app_router.dart';

class OnboardingCategoriesScreen extends StatelessWidget {
  const OnboardingCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRouter.onboardingLevel,
            );
          },
          child: const Text("Continuar a Nivel"),
        ),
      ),
    );
  }
}
