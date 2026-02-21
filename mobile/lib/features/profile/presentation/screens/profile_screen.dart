import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/ui/layout/app_scaffold.dart';
import '../../../../core/router/app_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Mi Perfil",
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.lg),
            // Avatar
            const Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppTheme.neutralBg,
                    child: Icon(Icons.person, size: 60, color: AppTheme.grayCustom),
                  ),
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: AppTheme.greenDark,
                    child: Icon(Icons.edit, size: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            const Text(
              "Anita",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.dark),
            ),
            const Text(
              "Nivel 3: Constante 🌱",
              style: TextStyle(color: AppTheme.greenDark, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: AppSpacing.xl),

            // Settings List
             _ProfileOption(
              icon: Icons.edit_calendar,
              title: "Mis Rutinas",
              onTap: () {
                 // TODO: Manage routines
              },
            ),
            _ProfileOption(
              icon: Icons.description_outlined,
              title: "Contrato",
              subtitle: "Ver o firmar compromiso",
              onTap: () {
                Navigator.pushNamed(context, AppRouter.contract);
              },
            ),
            _ProfileOption(
              icon: Icons.star_outline,
              title: "Plan Premium",
              subtitle: "Desbloquea todo el potencial",
              onTap: () {
                 Navigator.pushNamed(context, AppRouter.premiumPlan);
              },
            ),
            _ProfileOption(
              icon: Icons.restart_alt,
              title: "Reiniciar Onboarding",
               onTap: () {
                 Navigator.pushNamed(context, AppRouter.welcome);
              },
            ),
            _ProfileOption(
              icon: Icons.notifications_none,
              title: "Notificaciones",
              subtitle: "Configura tus alertas",
              onTap: () {
                Navigator.pushNamed(context, AppRouter.notifications);
              },
            ),
             const SizedBox(height: AppSpacing.lg),
            
            TextButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRouter.login);
              },
              icon: const Icon(Icons.logout, color: Colors.redAccent),
              label: const Text("Cerrar Sesión", style: TextStyle(color: Colors.redAccent)),
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _ProfileOption({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.neutralBg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppTheme.dark),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.dark),
      ),
      subtitle: subtitle != null
          ? Text(subtitle!, style: const TextStyle(fontSize: 12, color: AppTheme.grayCustom))
          : null,
      trailing: const Icon(Icons.chevron_right, color: AppTheme.grayCustom),
    );
  }
}
