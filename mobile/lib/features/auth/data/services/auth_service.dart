import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static String get baseUrl {
    // kIsWeb detecta si la app corre en un navegador
    if (kIsWeb) return 'http://localhost:8000';
    
    // Si es Android (Emulador), usamos 10.0.2.2
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:8000';
    }
    
    // Para iOS o cualquier otro, usamos localhost
    return 'http://localhost:8000';
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(baseUrl + '/auth/login'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'username': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      final errorData = json.decode(response.body);
      throw Exception(errorData['detail'] ?? 'Error al iniciar sesión');
    }
  }

  Future<Map<String, dynamic>> register({
    required String nombre,
    required String apellidoPaterno,
    required String apellidoMaterno,
    required String email,
    required String password,
    String? telefono,
  }) async {
    final response = await http.post(
      Uri.parse(baseUrl + '/auth/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'nombre': nombre,
        'apellido_paterno': apellidoPaterno,
        'apellido_materno': apellidoMaterno,
        'correo_electronico': email,
        'contrasena': password,
        'telefono': telefono ?? '',
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      final errorData = json.decode(response.body);
      throw Exception(errorData['detail'] ?? 'Error al registrar usuario');
    }
  }
}
