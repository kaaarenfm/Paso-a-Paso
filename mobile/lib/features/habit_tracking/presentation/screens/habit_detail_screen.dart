import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/ui/layout/app_scaffold.dart';
import '../widgets/habit_action_modal.dart';

class HabitDetailScreen extends StatefulWidget {
  final String habitName;
  final String emoji;

  const HabitDetailScreen({
    super.key,
    this.habitName = "Beber Agua", 
    this.emoji = "💧",
  });

  @override
  State<HabitDetailScreen> createState() => _HabitDetailScreenState();
}

class _HabitDetailScreenState extends State<HabitDetailScreen> {
  bool _isCompleted = false;
  final List<String> _notes = [];

  void _markCompleted() {
    setState(() {
      _isCompleted = !_isCompleted;
    });

    if (_isCompleted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("¡Hábito completado! 🎉"),
          backgroundColor: AppTheme.greenDark,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _showOptions() async {
    final result = await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const HabitActionModal(),
    );

    if (result == 'note') {
      _addNoteDialog();
    } else if (result == 'postpone') {
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Hábito pospuesto para más tarde ⏰"),
        ),
      );
    } else if (result == 'completed') {
        if (!_isCompleted) _markCompleted();
    }
  }

  void _addNoteDialog() {
    final noteController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Agregar nota"),
        content: TextField(
          controller: noteController,
          decoration: const InputDecoration(hintText: "¿Cómo te sentiste hoy?"),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              if (noteController.text.isNotEmpty) {
                setState(() {
                  _notes.insert(0, "${DateTime.now().day}/${DateTime.now().month}: ${noteController.text}");
                });
              }
              Navigator.pop(context);
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Detalle",
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.md),
            
            // Header card
            _buildHabitHeader(),
            
            const SizedBox(height: AppSpacing.lg),

            // Statistics Grid
            _buildStats(),

            const SizedBox(height: AppSpacing.lg),

            // Monthly/Weekly View Mock
            _buildHistoryView(),

            const SizedBox(height: AppSpacing.lg),

            // Notes Section
            _buildNotesSection(),
            
            // Extra space for FAB
            const SizedBox(height: 80), 
          ],
        ),
      ),
    );
  }

  Widget _buildHabitHeader() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.neutralBg,
              shape: BoxShape.circle,
            ),
            child: Text(
              widget.emoji,
              style: const TextStyle(fontSize: 48),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            widget.habitName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.dark,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.greenLight.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.calendar_today, size: 16, color: AppTheme.greenDark),
                SizedBox(width: 4),
                Text(
                  "Seguimiento Diario",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.greenDark,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          
          // Main Action Button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _markCompleted,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isCompleted ? AppTheme.neutralBg : AppTheme.greenDark,
                    foregroundColor: _isCompleted ? AppTheme.grayCustom : Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: _isCompleted ? 0 : 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  icon: Icon(_isCompleted ? Icons.check_circle : Icons.circle_outlined),
                  label: Text(_isCompleted ? "Completado" : "Marcar hoy"),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              IconButton.filledTonal(
                onPressed: _showOptions,
                icon: const Icon(Icons.more_horiz),
                style: IconButton.styleFrom(
                  backgroundColor: AppTheme.neutralBg,
                  foregroundColor: AppTheme.dark,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: "Total Días",
            value: "42",
            icon: Icons.calendar_today,
            color: Colors.blue.shade50,
            iconColor: Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryView() {
    // Mock de los últimos 7 días
    final days = ["L", "M", "M", "J", "V", "S", "D"];
    final status = [true, true, false, true, true, false, false]; // true = done

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Historial (Esta semana)",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.dark,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              final isDone = status[index];
              return Column(
                children: [
                  Text(
                    days[index],
                    style: TextStyle(
                      color: AppTheme.grayCustom,
                      fontWeight: index == 6 ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isDone ? AppTheme.greenDark : AppTheme.neutralBg,
                      shape: BoxShape.circle,
                    ),
                    child: isDone
                        ? const Icon(Icons.check, color: Colors.white, size: 20)
                        : null,
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildNotesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Notas",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.dark,
              ),
            ),
            TextButton.icon(
              onPressed: _addNoteDialog,
              icon: const Icon(Icons.add, size: 16),
              label: const Text("Agregar"),
              style: TextButton.styleFrom(foregroundColor: AppTheme.greenDark),
            ),
          ],
        ),
        if (_notes.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppTheme.neutralBg.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.grayCustom.withOpacity(0.2), style: BorderStyle.solid),
            ),
            child: const Text(
              "No hay notas aún. ¡Agrega una para llevar un registro de tu progreso!",
              textAlign: TextAlign.center,
              style: TextStyle(color: AppTheme.grayCustom),
            ),
          )
        else
          ..._notes.map((note) => Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.grayCustom.withOpacity(0.1)),
            ),
            child: Text(note, style: const TextStyle(color: AppTheme.dark)),
          )),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final Color iconColor;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.dark,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.grayCustom.withOpacity(0.8),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
