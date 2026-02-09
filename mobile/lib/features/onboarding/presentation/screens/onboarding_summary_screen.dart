import 'package:flutter/material.dart';
import '../../../../../core/router/app_router.dart';

class OnboardingSummaryScreen extends StatelessWidget {
  const OnboardingSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              AppRouter.contract,
            );
          },
          child: const Text("Resumen y Confirmación"),
        ),
      ),
    );
  }
}