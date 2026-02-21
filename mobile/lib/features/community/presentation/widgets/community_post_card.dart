import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/router/app_router.dart';


class CommunityPostCard extends StatelessWidget {
  final String userName;
  final String routineTitle;
  final String description;
  final int likes;
  final int comments;
  final bool isLiked;

  final VoidCallback onLike;
  final VoidCallback onComment;

  const CommunityPostCard({
    super.key,
    required this.userName,
    required this.routineTitle,
    required this.description,
    required this.likes,
    required this.comments,
    this.isLiked = false,
    required this.onLike,
    required this.onComment,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRouter.communityRoutineDetail);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: AppTheme.neutralBg,
                  child: Icon(Icons.person, color: AppTheme.grayCustom),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.dark,
                      ),
                    ),
                    const Text(
                      "hace 2h",
                      style: TextStyle(fontSize: 12, color: AppTheme.grayCustom),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.more_horiz, color: AppTheme.grayCustom),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              routineTitle,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.dark,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(color: AppTheme.grayCustom),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _ActionChip(
                  icon: isLiked ? Icons.favorite : Icons.favorite_border,
                  label: "$likes",
                  color: isLiked ? Colors.red : AppTheme.grayCustom,
                  onTap: onLike,
                ),
                const SizedBox(width: 16),
                _ActionChip(
                  icon: Icons.chat_bubble_outline,
                  label: "$comments",
                  color: AppTheme.grayCustom,
                  onTap: onComment,
                ),
                const Spacer(),
                const Icon(Icons.bookmark_border, color: AppTheme.grayCustom),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
