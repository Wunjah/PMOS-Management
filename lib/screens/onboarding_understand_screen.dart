import 'package:flutter/material.dart';
import '../core/theme.dart';
import 'select_focus_screen.dart';

class OnboardingUnderstandScreen extends StatelessWidget {
  const OnboardingUnderstandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              LinearProgressIndicator(
                value: 0.1,
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
              const SizedBox(height: 48),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.auto_awesome, color: AppColors.secondary, size: 32),
              ),
              const SizedBox(height: 32),
              const Text(
                'How PMOS Care works',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 16),
              _buildFeatureRow(
                Icons.edit_note,
                'Log daily symptoms',
                'Track cycles, energy, and metabolic markers effortlessly.',
              ),
              _buildFeatureRow(
                Icons.analytics_outlined,
                'AI pattern detection',
                'Our AI identifies hormonal patterns without diagnosing.',
              ),
              _buildFeatureRow(
                Icons.medical_services_outlined,
                'Care coordination',
                'Seamlessly connect with specialists when patterns emerge.',
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const SelectFocusScreen()),
                  );
                },
                child: const Text('Continue'),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 4),
                Text(description, style: TextStyle(color: AppColors.textSecondary, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
