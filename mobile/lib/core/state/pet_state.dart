enum PetEmotion { happy, sad, angry, proud }

class PetState {
  final String petId;
  final String name;
  final PetEmotion emotion;

  const PetState({
    required this.petId,
    required this.name,
    required this.emotion,
  });

  PetState copyWith({
    String? petId,
    String? name,
    PetEmotion? emotion,
  }) {
    return PetState(
      petId: petId ?? this.petId,
      name: name ?? this.name,
      emotion: emotion ?? this.emotion,
    );
  }
}
