import 'package:flutter/material.dart';
import '../core/theme.dart';
import 'personal_details_screen.dart';

class SelectFocusScreen extends StatefulWidget {
  const SelectFocusScreen({super.key});

  @override
  State<SelectFocusScreen> createState() => _SelectFocusScreenState();
}

class _SelectFocusScreenState extends State<SelectFocusScreen> {
  final List<String> _goals = [
    'Manage Symptoms',
    'Track Fertility',
    'Weight Management',
    'Improve Energy',
    'Clearer Skin',
    'Understand My Body',
  ];

  final Set<String> _selectedGoals = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'What is your primary focus?',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 12),
              const Text(
                'Select as many as apply. This helps us customize your insights.',
                style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.builder(
                  itemCount: _goals.length,
                  itemBuilder: (context, index) {
                    final goal = _goals[index];
                    final isSelected = _selectedGoals.contains(goal);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedGoals.remove(goal);
                            } else {
                              _selectedGoals.add(goal);
                            }
                          });
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primary.withOpacity(0.05) : AppColors.background,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected ? AppColors.primary : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                goal,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                  color: isSelected ? AppColors.primary : AppColors.textPrimary,
                                ),
                              ),
                              if (isSelected)
                                const Icon(Icons.check_circle, color: AppColors.primary)
                              else
                                const Icon(Icons.add_circle_outline, color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const PersonalDetailsScreen()),
                  );
                },
                child: const Text('Continue'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
