import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/ui/layout/app_scaffold.dart';
import '../widgets/notification_item.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        "title": "¡Hora de beber agua!",
        "message": "Recuerda mantenerte hidratado. Tu cuerpo te lo agradecerá 💧",
        "time": "Hace 10 min",
        "isRead": false,
        "icon": Icons.local_drink,
        "color": Colors.blue,
      },
      {
        "title": "Mascota necesita atención",
        "message": "Rocky se siente un poco solo. ¡Ve a jugar un rato con él! 🐶",
        "time": "Hace 2h",
        "isRead": false,
        "icon": Icons.pets,
        "color": Colors.orange,
      },

       {
        "title": "Nueva rutina popular",
        "message": "Descubre la 'Rutina de Sueño Reparador' en la comunidad.",
        "time": "Ayer",
        "isRead": true,
        "icon": Icons.star,
        "color": Colors.purple,
      },
    ];

    return AppScaffold(
      title: "Notificaciones",
      child: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_off_outlined,
                      size: 64, color: AppTheme.grayCustom.withOpacity(0.5)),
                  const SizedBox(height: AppSpacing.md),
                  const Text(
                    "No tienes notificaciones nuevas",
                    style: TextStyle(color: AppTheme.grayCustom),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: AppSpacing.md),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notif = notifications[index];
                return NotificationItem(
                  title: notif['title'] as String,
                  message: notif['message'] as String,
                  time: notif['time'] as String,
                  isRead: notif['isRead'] as bool,
                  icon: notif['icon'] as IconData,
                  iconColor: notif['color'] as Color,
                  onTap: () {
                    // Acción al tocar notificación (ej: ir a pantalla)
                    if ((notif['icon'] as IconData) == Icons.pets) {
                       Navigator.pushNamed(context, AppRouter.petScreen);
                    } else if ((notif['icon'] as IconData) == Icons.star) {
                        Navigator.pushNamed(context, AppRouter.community);
                    }
                  },
                );
              },
            ),
    );
  }
}
