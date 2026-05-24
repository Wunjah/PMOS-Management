import 'package:flutter/material.dart';
import '../core/theme.dart';
import 'medical_history_screen.dart';

class SymptomsAssessmentScreen extends StatefulWidget {
  const SymptomsAssessmentScreen({super.key});

  @override
  State<SymptomsAssessmentScreen> createState() => _SymptomsAssessmentScreenState();
}

class _SymptomsAssessmentScreenState extends State<SymptomsAssessmentScreen> {
  final List<String> _symptoms = [
    'Acne / Skin Breakouts',
    'Excessive Fatigue',
    'Irregular Periods',
    'Unwanted Hair Growth',
    'Hair Thinning',
    'Mood Fluctuations',
    'Weight Gain',
    'Sleep Issues',
    'Sugar Cravings',
  ];

  final Set<String> _selectedSymptoms = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: 0.6, // Step 3 of 5
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.secondary),
            minHeight: 8,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Current Symptoms',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Which of these have you experienced in the last 3 months? Select all that apply.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.builder(
                  itemCount: _symptoms.length,
                  itemBuilder: (context, index) {
                    final symptom = _symptoms[index];
                    final isSelected = _selectedSymptoms.contains(symptom);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedSymptoms.remove(symptom);
                            } else {
                              _selectedSymptoms.add(symptom);
                            }
                          });
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primary.withOpacity(0.05) : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected ? AppColors.primary : Colors.grey[200]!,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  symptom,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                    color: isSelected ? AppColors.primary : AppColors.primary.withOpacity(0.8),
                                  ),
                                ),
                              ),
                              if (isSelected)
                                const Icon(Icons.check_circle, color: AppColors.primary)
                              else
                                Icon(Icons.add_circle_outline, color: Colors.grey[400]),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MedicalHistoryScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'Step 3 of 5',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
