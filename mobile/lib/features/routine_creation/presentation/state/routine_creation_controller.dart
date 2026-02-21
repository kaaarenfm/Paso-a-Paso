import 'package:flutter/material.dart';
import '../../presentation/models/routine_draft.dart';
import '../../../../core/state/user_state.dart';

class RoutineCreationController extends ChangeNotifier {
  RoutineDraft _draft = RoutineDraft();
  final PageController pageController = PageController();

  RoutineDraft get draft => _draft;

  // 1️⃣ Momento del día
  void setMoment(String moment) {
    _draft = _draft.copyWith(moment: moment);
    notifyListeners();
  }

  // 2️⃣ Tipo de rutina (Focus, Relax, Energy)
  void setType(String type) {
    // Podría guardarse como nombre o metadata adicional
    _draft = _draft.copyWith(name: "Rutina de $type");
    notifyListeners();
  }

  // 3️⃣ Selección de hábitos
  void toggleHabit(String habit) {
    final currentHabits = List<String>.from(_draft.habits);
    if (currentHabits.contains(habit)) {
      currentHabits.remove(habit);
    } else {
      currentHabits.add(habit);
    }
    _draft = _draft.copyWith(habits: currentHabits);
    notifyListeners();
  }

  // 4️⃣ Frecuencia
  void toggleDay(String day) {
    final currentDays = List<String>.from(_draft.frequency);
    if (currentDays.contains(day)) {
      currentDays.remove(day);
    } else {
      currentDays.add(day);
    }
    _draft = _draft.copyWith(frequency: currentDays);
    notifyListeners();
  }

  void toggleEveryDay() {
    final days = ["Lun", "Mar", "Mié", "Jue", "Vie", "Sáb", "Dom"];
    if (_draft.frequency.length == days.length) {
      // Si ya están todos seleccionados, deseleccionamos todos
      _draft = _draft.copyWith(frequency: []);
    } else {
      // Si no, seleccionamos todos
      _draft = _draft.copyWith(frequency: days);
    }
    notifyListeners();
  }

  // 5️⃣ Recordatorios
  void addReminder(String time) {
    final currentReminders = List<String>.from(_draft.reminders);
    if (!currentReminders.contains(time)) {
      currentReminders.add(time);
      _draft = _draft.copyWith(reminders: currentReminders);
      notifyListeners();
    }
  }

  void removeReminder(String time) {
    final currentReminders = List<String>.from(_draft.reminders);
    currentReminders.remove(time);
    _draft = _draft.copyWith(reminders: currentReminders);
    notifyListeners();
  }

  // Recomendaciones (mock)
  List<String> getSuggestedHabits(String moment) {
    switch (moment) {
      case 'Mañana':
        return ['Beber agua', 'Estirar', 'Meditar 5 min', 'Leer 10 min'];
      case 'Tarde':
        return ['Caminar 15 min', 'Organizar escritorio', 'Tomar un té'];
      case 'Noche':
        return ['Desconectar pantallas', 'Escribir diario', 'Preparar ropa'];
      default:
        return ['Resirar profundo'];
    }
  }

  String getMotivationalQuote() {
    return "Pequeños pasos te llevan a grandes lugares. 🌱";
  }

  void reset() {
    _draft = RoutineDraft();
    notifyListeners();
  }
}
