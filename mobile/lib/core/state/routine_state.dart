import 'package:flutter/material.dart';

class RoutineState {
  final bool hasRoutines;
  final int completedToday;

  const RoutineState({
    required this.hasRoutines,
    required this.completedToday,
  });
}
