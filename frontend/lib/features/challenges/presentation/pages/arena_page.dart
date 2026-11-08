import "package:flutter/material.dart";
import "../../../core/constants/app_colors.dart";
import "../../../shared/widgets/glass_card.dart";

class ArenaPage extends StatefulWidget {
  const ArenaPage({super.key});

  @override
  State<ArenaPage> createState() => _ArenaPageState();
}

class _ArenaPageState extends State<ArenaPage> {
  final TextEditingController _codeController = TextEditingController(
    text: "def solution():\n    # Write your code here\n    print(\"Hello SkillProof!\")\n\nsolution()"
  );

  // Mock state for test cases
  final List<Map<String, dynamic>> _testCases = [
    {"id": 1, "input": "None", "status": "Pending", "label": "Basic Functionality"},
    {"id": 2, "input": "Input A", "status": "Pending", "label": "Edge Case: Nulls"},
    {"id": 3, "input": "Input B", "status": "Pending", "label": "Performance Test"},
  ];

  void _runCode() {
    // This is where we will call the Sandbox API
    setState(() {
      for (var test in _testCases) {
        test["status"] = "Running...";
      }
    });
    
    // Mocking the return flow
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _testCases[0]["status"] = "Success";
        _testCases[1]["status"] = "Fail";
        _testCases[2]["status"] = "Success";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slateDark,
      appBar: AppBar(
        backgroundColor: AppColors.slateDark,
        elevation: 0,
        title: const Text("The Arena", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.successEmerald,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Submit Proof"),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          // LEFT: The Code Editor (70%)
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1B26), // Tokyo Night style
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.glassSurface),
                      ),
                      child: TextField(
                        controller: _codeController,
                        maxLines: null,
                        expands: true,
                        style: const TextStyle(
                          fontFamily: "monospace",
                          color: Color(0xFFC0C_A_FF), // Soft white
                          fontSize: 14,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _runCode,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.electricCyan,
                        foregroundColor: AppColors.slateDark,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Run Tests", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // RIGHT: The Results Panel (30%)
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.slateLighter.withOpacity(0.5),
                border: const Border(left: BorderSide(color: AppColors.glassSurface)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Test Results",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _testCases.length,
                      itemBuilder: (context, index) {
                        final test = _testCases[index];
                        return _buildTestTile(test);
                      },
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

  Widget _buildTestTile(Map<String, dynamic> test) {
    Color statusColor;
    IconData icon;

    switch (test["status"]) {
      case "Success": statusColor = AppColors.successEmerald; icon = Icons.check_circle; break;
      case "Fail": statusColor = AppColors.errorCrimson; icon = Icons.cancel; break;
      case "Running...": statusColor = AppColors.electricCyan; icon = Icons.sync; break;
      default: statusColor = AppColors.textSecondary; icon = Icons.hourglass_empty;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(icon, color: statusColor, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    test["label"],
                    style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Status: ${test["status"]}",
                    style: TextStyle(color: statusColor, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

