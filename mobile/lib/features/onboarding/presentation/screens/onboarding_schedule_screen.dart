import 'package:flutter/material.dart';
import '../../../../../core/router/app_router.dart';

class OnboardingScheduleScreen extends StatelessWidget {
  const OnboardingScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRouter.onboardingMotivation,
            );
          },
          child: const Text("Horario preferido"),
        ),
      ),
    );
  }
}
