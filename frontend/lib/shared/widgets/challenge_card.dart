import "package:flutter/material.dart";
import "../../core/constants/app_colors.dart";

class ChallengeCard extends StatelessWidget {
  final String title;
  final String category;
  final String difficulty;
  final bool isFeatured;
  final VoidCallback onTap;

  const ChallengeCard({
    super.key,
    required this.title,
    required this.category,
    required this.difficulty,
    this.isFeatured = false,
    required this.onTap,
  });

  Color _getDifficultyColor() {
    switch (difficulty.toLowerCase()) {
      case "easy": return AppColors.successEmerald;
      case "medium": return Colors.orangeAccent;
      case "hard": return AppColors.errorCrimson;
      default: return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.slateLighter,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isFeatured ? AppColors.electricCyan.withOpacity(0.5) : AppColors.glassSurface,
            width: isFeatured ? 2 : 1,
          ),
          boxShadow: isFeatured ? [
            BoxShadow(
              color: AppColors.electricCyan.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 5,
            )
          ] : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getDifficultyColor().withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    difficulty.toUpperCase(),
                    style: TextStyle(
                      color: _getDifficultyColor(),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (isFeatured)
                  const Icon(Icons.star, color: Colors.amber, size: 16),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              category,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

