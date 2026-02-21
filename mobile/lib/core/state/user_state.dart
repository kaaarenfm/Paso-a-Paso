import 'package:flutter/material.dart';

class UserState {
  final String? id;
  final String name;
  final String? email;
  final String? token;
  final bool onboardingCompleted;
  final bool contractSigned;

  const UserState({
    this.id,
    required this.name,
    this.email,
    this.token,
    required this.onboardingCompleted,
    required this.contractSigned,
  });

  UserState copyWith({
    String? id,
    String? name,
    String? email,
    String? token,
    bool? onboardingCompleted,
    bool? contractSigned,
  }) {
    return UserState(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
      onboardingCompleted:
          onboardingCompleted ?? this.onboardingCompleted,
      contractSigned: contractSigned ?? this.contractSigned,
    );
  }
}
