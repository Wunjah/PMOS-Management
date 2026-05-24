import 'package:flutter/material.dart';
import '../core/theme.dart';
import 'notification_setup_screen.dart';

class MedicalHistoryScreen extends StatefulWidget {
  const MedicalHistoryScreen({super.key});

  @override
  State<MedicalHistoryScreen> createState() => _MedicalHistoryScreenState();
}

class _MedicalHistoryScreenState extends State<MedicalHistoryScreen> {
  final List<String> _diagnoses = [
    'PCOS (Polycystic Ovary Syndrome)',
    'Endometriosis',
    'Insulin Resistance / Prediabetes',
    'Thyroid Disorder',
    'Fertility Challenges',
    'None of the above',
  ];

  final Set<String> _selectedDiagnoses = {};
  bool _hasLabResults = false;

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
            value: 0.8, // Step 4 of 5
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.secondary),
            minHeight: 8,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Medical History',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Help us understand your clinical background for better AI pattern detection.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Have you been diagnosed with any of these?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),
              ..._diagnoses.map((diagnosis) {
                final isSelected = _selectedDiagnoses.contains(diagnosis);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: CheckboxListTile(
                    title: Text(
                      diagnosis,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: AppColors.primary,
                      ),
                    ),
                    value: isSelected,
                    onChanged: (val) {
                      setState(() {
                        if (val == true) {
                          _selectedDiagnoses.add(diagnosis);
                        } else {
                          _selectedDiagnoses.remove(diagnosis);
                        }
                      });
                    },
                    activeColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    tileColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  ),
                );
              }).toList(),
              const SizedBox(height: 32),
              const Text(
                'Lab Results',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: SwitchListTile(
                  title: const Text(
                    'Do you have recent lab results (last 6 months) to upload?',
                    style: TextStyle(fontSize: 14, color: AppColors.primary),
                  ),
                  subtitle: const Text(
                    'AI can analyze testosterone, insulin, or glucose levels.',
                    style: TextStyle(fontSize: 12),
                  ),
                  value: _hasLabResults,
                  onChanged: (val) => setState(() => _hasLabResults = val),
                  activeColor: AppColors.secondary,
                ),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NotificationSetupScreen()),
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
              const Center(
                child: Text(
                  'Step 4 of 5',
                  style: TextStyle(
                    color: Colors.grey,
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
