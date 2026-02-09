import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  final String? title;

  const AppScaffold({
    super.key,
    required this.child,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.neutralBg,
      appBar: title != null
          ? AppBar(title: Text(title!))
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: child,
        ),
      ),
    );
  }
}
