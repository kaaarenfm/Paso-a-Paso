import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_state.dart';
import 'routine_state.dart';
import 'pet_state.dart';
import '../../features/auth/data/services/auth_service.dart';

class AppState extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  UserState _user = const UserState(
    name: "Invitado",
    onboardingCompleted: false,
    contractSigned: false,
  );

  RoutineState _routine = const RoutineState(
    hasRoutines: false,
    completedToday: 0,
  );

  PetState _pet = const PetState(
    petId: "rocky_dog",
    name: "Rocky",
    emotion: PetEmotion.sad,
  );

  String _dailyQuote = "Hoy es un buen día para avanzar 🌱";
  bool _isLoading = false;

  UserState get user => _user;
  RoutineState get routine => _routine;
  PetState get pet => _pet;
  String get dailyQuote => _dailyQuote;
  bool get isLoading => _isLoading;

  AppState() {
    _loadSession();
  }

  Future<void> _loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final name = prefs.getString('user_name') ?? "Invitado";
    final email = prefs.getString('user_email');
    final onboarding = prefs.getBool('onboarding_completed') ?? false;

    if (token != null) {
      _user = _user.copyWith(
        token: token,
        name: name,
        email: email,
        onboardingCompleted: onboarding,
      );
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await _authService.login(email, password);
      final token = data['access_token'];
      
      // En un caso real, obtendríamos el perfil completo del usuario aquí
      // Por ahora simulamos los datos basados en el login exitoso
      _user = _user.copyWith(
        token: token,
        email: email,
        name: email.split('@')[0], // Fallback name
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
      await prefs.setString('user_email', email);
      await prefs.setString('user_name', _user.name);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> register({
    required String nombre,
    required String apellidoPaterno,
    required String apellidoMaterno,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await _authService.register(
        nombre: nombre,
        apellidoPaterno: apellidoPaterno,
        apellidoMaterno: apellidoMaterno,
        email: email,
        password: password,
      );
      
      final token = data['access_token'];
      
      _user = _user.copyWith(
        token: token,
        email: email,
        name: nombre,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
      await prefs.setString('user_email', email);
      await prefs.setString('user_name', nombre);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  void logout() async {
    _user = const UserState(
      name: "Invitado",
      onboardingCompleted: false,
      contractSigned: false,
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }

  void completeOnboarding() async {
    _user = _user.copyWith(onboardingCompleted: true);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
    notifyListeners();
  }

  void signContract() {
    _user = _user.copyWith(contractSigned: true);
    notifyListeners();
  }

  void addRoutine() {
    _routine = const RoutineState(
      hasRoutines: true,
      completedToday: 0,
    );
    _updatePetEmotion();
    notifyListeners();
  }

  void completeRoutine() {
    _routine = RoutineState(
      hasRoutines: true,
      completedToday: _routine.completedToday + 1,
    );
    _updatePetEmotion();
    notifyListeners();
  }

  void _updatePetEmotion() {
    if (_routine.completedToday == 0) {
      _pet = _pet.copyWith(emotion: PetEmotion.sad);
    } else if (_routine.completedToday == 1) {
      _pet = _pet.copyWith(emotion: PetEmotion.happy);
    } else if (_routine.completedToday >= 3) {
      _pet = _pet.copyWith(emotion: PetEmotion.proud);
    } else {
      _pet = _pet.copyWith(emotion: PetEmotion.happy);
    }
  }
}
