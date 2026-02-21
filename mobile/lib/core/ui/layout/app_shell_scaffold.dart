import 'package:flutter/material.dart';
import 'floating_pet.dart';
import 'shell_header.dart';
import 'global_overlay.dart';

class AppShellScaffold extends StatelessWidget {

  final Widget child;
  final String title;

  const AppShellScaffold({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [

        Scaffold(
          appBar: ShellHeader(title: title),
          body: SafeArea(child: child),
        ),

        const FloatingPet(),

        const GlobalOverlay(),

      ],
    );
  }
}
