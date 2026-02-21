import 'package:flutter/material.dart';

/// Servicio para gestionar las notificaciones locales del sistema.
/// Permite programar recordatorios para las rutinas y hábitos.
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  /// Inicializa la configuración de notificaciones locales.
  Future<void> init() async {
    // Aquí se integraría flutter_local_notifications en un entorno real
    debugPrint("🔔 [NotificationService] Inicializado");
  }

  /// Programa una notificación para una hora específica.
  /// En una implementación real, esto usaría TZDateTime para programación precisa.
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required TimeOfDay time,
    List<String>? days,
  }) async {
    // Configuración simulada de programación
    debugPrint("📅 [NotificationService] Programada: '$title' para las ${time.hour}:${time.minute} (${days?.join(', ') ?? 'diario'})");
  }

  /// Cancela una notificación programada por su ID.
  Future<void> cancelNotification(int id) async {
    debugPrint("🚫 [NotificationService] Cancelada: Notificación ID $id");
  }

  /// Cancela todas las notificaciones programadas.
  Future<void> cancelAll() async {
    debugPrint("🗑️ [NotificationService] Todas las notificaciones canceladas");
  }
  
  /// Muestra una notificación inmediata (ej: para pruebas o eventos en vivo)
  Future<void> showImmediate({
    required String title,
    required String body,
  }) async {
    debugPrint("🚀 [NotificationService] Notificación inmediata: $title - $body");
  }
}
