class RoutineDraft {
  final String? name;
  final String? moment; // Mañana, Tarde, Noche
  final List<String> habits;
  final List<String> frequency; // Días de la semana
  final List<String> reminders; // Horas recordatorio

  RoutineDraft({
    this.name,
    this.moment,
    this.habits = const [],
    this.frequency = const [],
    this.reminders = const [],
  });

  RoutineDraft copyWith({
    String? name,
    String? moment,
    List<String>? habits,
    List<String>? frequency,
    List<String>? reminders,
  }) {
    return RoutineDraft(
      name: name ?? this.name,
      moment: moment ?? this.moment,
      habits: habits ?? this.habits,
      frequency: frequency ?? this.frequency,
      reminders: reminders ?? this.reminders,
    );
  }
}
