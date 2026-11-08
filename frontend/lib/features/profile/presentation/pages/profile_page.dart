import "package:flutter/material.dart";
import "../../../core/constants/app_colors.dart";
import "../../../shared/widgets/glass_card.dart";

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Aesthetic Glow
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.deepIndigo.withOpacity(0.2),
                blurRadius: 100,
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Header Section
                  Center(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.electricCyan, width: 3),
                          ),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundColor: AppColors.slateLighter,
                            child: Icon(Icons.person, size: 50, color: AppColors.textPrimary),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Jaisun Developer",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const Text(
                          "Verified Full-Stack Engineer",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.electricCyan,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Skill DNA Section (The Core Innovation)
                  const Text(
                    "Skill DNA",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: GlassCard(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          // Mock Radar Chart using a Custom Paint/Container
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.glassSurface),
                            ),
                            child: Stack(
                              children: [
                                // This is a placeholder for the actual Radar Chart logic
                                Center(
                                  child: Icon(Icons.analytics, size: 80, color: AppColors.electricCyan.withOpacity(0.5)),
                                ),
                                Positioned(
                                  top: 20,
                                  left: 80,
                                  child: _buildMetricTag("Logic", 95),
                                ),
                                Positioned(
                                  bottom: 40,
                                  left: 20,
                                  child: _buildMetricTag("Speed", 70),
                                ),
                                Positioned(
                                  bottom: 40,
                                  right: 20,
                                  child: _buildMetricTag("Cleanliness", 85),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Top Skill: System Architecture",
                            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Verified Proofs (The "Trophy Room")
                  const Text(
                    "Verified Proofs",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildProofTile("The Great Sandbox", "System Design", "Hard"),
                  _buildProofTile("API Architect", "FastAPI", "Medium"),
                  _buildProofTile("Query Master", "PostgreSQL", "Easy"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricTag(String label, int value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.deepIndigo,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "$label $value%",
        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildProofTile(String title, String category, String difficulty) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.verified, color: AppColors.successEmerald, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "$category • $difficulty",
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}

