import "package:flutter/material.dart";
import "../../../core/constants/app_colors.dart";
import "../../../shared/widgets/challenge_card.dart";

class ChallengeHubPage extends StatelessWidget {
  const ChallengeHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Glow (Subtle)
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.deepIndigo.withOpacity(0.1),
                blurRadius: 100,
              ),
            ),
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Explore",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                              letterSpacing: -1,
                            ),
                          ),
                          Text(
                            "Prove your expertise",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const CircleAvatar(
                        backgroundColor: AppColors.slateLighter,
                        child: Icon(Icons.person_outline, color: AppColors.textPrimary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  
                  // Category Chips
                  SizedBox(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildCategoryChip("All", true),
                        _buildCategoryChip("Python", false),
                        _buildCategoryChip("FastAPI", false),
                        _buildCategoryChip("Docker", false),
                        _buildCategoryChip("Flutter", false),
                        _buildCategoryChip("Postgres", false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Challenge Grid (Bento Style)
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.85,
                      children: [
                        ChallengeCard(
                          title: "The Great Sandbox",
                          category: "System Design",
                          difficulty: "Hard",
                          isFeatured: true,
                          onTap: () {},
                        ),
                        ChallengeCard(
                          title: "API Architect",
                          category: "FastAPI",
                          difficulty: "Medium",
                          onTap: () {},
                        ),
                        ChallengeCard(
                          title: "Query Master",
                          category: "PostgreSQL",
                          difficulty: "Easy",
                          onTap: () {},
                        ),
                        ChallengeCard(
                          title: "Flutter Flow",
                          category: "Frontend",
                          difficulty: "Medium",
                          onTap: () {},
                        ),
                        ChallengeCard(
                          title: "Logic Puzzle",
                          category: "Python",
                          difficulty: "Easy",
                          onTap: () {},
                        ),
                        ChallengeCard(
                          title: "Secure Auth",
                          category: "Security",
                          difficulty: "Hard",
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.deepIndigo : AppColors.slateLighter,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppColors.electricCyan : AppColors.glassSurface,
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

