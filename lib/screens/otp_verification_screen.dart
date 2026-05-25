import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../core/theme.dart';
import 'auth_success_screen.dart';

class OTPVerificationScreen extends StatelessWidget {
  const OTPVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: const TextStyle(fontSize: 24, color: AppColors.textPrimary, fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.transparent),
      ),
    );

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
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Verify Email',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 12),
              RichText(
                text: TextSpan(
                  text: 'We\'ve sent a 4-digit code to ',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 16, height: 1.4),
                  children: const [
                    TextSpan(
                      text: 'jane@example.com',
                      style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              Center(
                child: Pinput(
                  length: 4,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(color: AppColors.primary),
                    ),
                  ),
                  onCompleted: (pin) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const AuthSuccessScreen()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                   Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const AuthSuccessScreen()),
                  );
                },
                child: const Text('Verify'),
              ),
              const SizedBox(height: 24),
              Center(
                child: Column(
                  children: [
                    Text('Didn\'t receive the code?', style: TextStyle(color: Colors.grey[600])),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Resend Code',
                        style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
