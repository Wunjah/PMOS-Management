import 'package:flutter/material.dart';
import '../core/theme.dart';
import 'onboarding_complete_screen.dart';

class NotificationSetupScreen extends StatefulWidget {
  const NotificationSetupScreen({super.key});

  @override
  State<NotificationSetupScreen> createState() => _NotificationSetupScreenState();
}

class _NotificationSetupScreenState extends State<NotificationSetupScreen> {
  bool _dailyLog = true;
  bool _cycleAlerts = true;
  bool _medReminders = false;

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
            value: 1.0, // Step 5 of 5
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
                'Stay Consistent',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Logging daily is the best way for the AI to identify your unique hormonal patterns.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              _buildNotificationTile(
                title: 'Daily Symptom Logging',
                subtitle: 'A gentle nudge to track how you feel.',
                icon: Icons.calendar_today_outlined,
                value: _dailyLog,
                onChanged: (v) => setState(() => _dailyLog = v),
              ),
              const SizedBox(height: 16),
              _buildNotificationTile(
                title: 'Cycle & Ovulation Alerts',
                subtitle: 'Predictions based on your logged history.',
                icon: Icons.water_drop_outlined,
                value: _cycleAlerts,
                onChanged: (v) => setState(() => _cycleAlerts = v),
              ),
              const SizedBox(height: 16),
              _buildNotificationTile(
                title: 'Medication Reminders',
                subtitle: 'Stay on top of your prescriptions.',
                icon: Icons.medication_outlined,
                value: _medReminders,
                onChanged: (v) => setState(() => _medReminders = v),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const OnboardingCompleteScreen()),
                      (route) => false,
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
                    'Complete Setup',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'Step 5 of 5',
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

  Widget _buildNotificationTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[100]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
        ),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.secondary,
        ),
      ),
    );
  }
}
