import 'package:flutter/material.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../core/ui/layout/app_scaffold.dart';
import '../../../../core/ui/buttons/primary_button.dart';

class ContractScreen extends StatelessWidget {
  const ContractScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Compromiso Personal",
      child: Column(
        children: [
          const Text(
            "Me comprometo a trabajar en mis hábitos con constancia y paciencia.",
          ),
          const SizedBox(height: 30),
          PrimaryButton(
            text: "Firmar compromiso",
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                AppRouter.home,
              );
            },
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                AppRouter.home,
              );
            },
            child: const Text("Omitir"),
          )
        ],
      ),
    );
  }
}
