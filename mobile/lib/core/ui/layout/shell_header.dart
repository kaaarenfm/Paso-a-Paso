import 'package:flutter/material.dart';

class ShellHeader extends StatelessWidget implements PreferredSizeWidget {

  final String title;

  const ShellHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    return AppBar(
      title: Text(title),
      centerTitle: false,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
