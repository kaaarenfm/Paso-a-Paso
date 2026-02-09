import 'package:flutter/material.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/ui/layout/app_scaffold.dart';
import '../../../../core/ui/buttons/primary_button.dart';

class OnboardingIntroScreen extends StatelessWidget {
  const OnboardingIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Personalicemos tu experiencia 🌱",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          PrimaryButton(
            text: "Continuar",
            onPressed: () {
              Future.microtask(() {
                Navigator.pushNamed(
                  context,
                  AppRouter.onboardingObjectives,
                );
              });
            }
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                AppRouter.contract,
              );
            },
            child: const Text("Saltar"),
          )
        ],
      ),
    );
  }
}
