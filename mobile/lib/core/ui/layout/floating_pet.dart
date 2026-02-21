import 'package:flutter/material.dart';

class FloatingPet extends StatelessWidget {
  const FloatingPet({super.key});

  @override
  Widget build(BuildContext context) {

    return Positioned(
      bottom: 90,
      right: 16,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/pet");
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green,
          ),
          child: const Icon(Icons.pets, color: Colors.white),
        ),
      ),
    );
  }
}
