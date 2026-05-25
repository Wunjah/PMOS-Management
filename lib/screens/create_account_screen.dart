import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sign_in_screen.dart';
import 'otp_verification_screen.dart';
import 'welcome_screen.dart';

// ── Color tokens matching HTML config ────────────────────────────────────────
class _Colors {
  static const primary = Color(0xFF5152B9);
  static const primaryContainer = Color(0xFF8E8FFA);
  static const background = Color(0xFFF8F9FF);
  static const onSurface = Color(0xFF191C20);
  static const onSurfaceVariant = Color(0xFF464552);
  static const outline = Color(0xFF777684);
  static const outlineVariant = Color(0xFFC7C5D4);
  static const surfaceContainerLow = Color(0xFFF2F3F9);
  static const surfaceContainerLowest = Color(0xFFFFFFFF);
  static const tertiary = Color(0xFF00696A);
}

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool _obscurePassword = true;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final topPadding = mediaQuery.padding.top;

    return Scaffold(
      backgroundColor: _Colors.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 850;

          // Main form canvas widget
          Widget mainContentCanvas = Stack(
            children: [
              // Radial Gradients for Depth (only background medical_gradient pattern)
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.topRight,
                      radius: 1.2,
                      colors: [
                        Color(0xFFE2DFFF),
                        Color(0x00E2DFFF),
                      ],
                      stops: [0.0, 0.7],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.bottomLeft,
                      radius: 1.0,
                      colors: [
                        Color(0x1AFFB8F8),
                        Color(0x00FFB8F8),
                      ],
                      stops: [0.0, 0.5],
                    ),
                  ),
                ),
              ),

              // Glass Header
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: topPadding + 64,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      padding: EdgeInsets.only(top: topPadding, left: 8, right: 20),
                      color: _Colors.background.withValues(alpha: 0.4),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: _Colors.primary),
                            onPressed: () {
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              } else {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                                );
                              }
                            },
                          ),
                          const SizedBox(width: 4),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: _Colors.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.medical_services_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'PMOS Care',
                            style: GoogleFonts.manrope(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: _Colors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Canvas Content
              Positioned.fill(
                top: topPadding + 64,
                child: SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 16),

                          // Hero Visual Section
                          Text(
                            'Start your health journey',
                            textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                            style: GoogleFonts.manrope(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: _Colors.onSurface,
                              letterSpacing: -0.64,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'A clinically-precise space designed for your metabolic and hormonal wellness.',
                            textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                            style: GoogleFonts.atkinsonHyperlegible(
                              fontSize: 16,
                              color: _Colors.onSurfaceVariant,
                              height: 1.4,
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Sign Up Card
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: _Colors.surfaceContainerLowest,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: _Colors.outlineVariant.withValues(alpha: 0.3),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: _Colors.primary.withValues(alpha: 0.05),
                                  blurRadius: 32,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Full Name Field
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4, bottom: 4),
                                      child: Text(
                                        'Full Name',
                                        style: GoogleFonts.manrope(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: _Colors.onSurfaceVariant,
                                        ),
                                      ),
                                    ),
                                    TextField(
                                      controller: _nameController,
                                      style: GoogleFonts.atkinsonHyperlegible(
                                        fontSize: 14,
                                        color: _Colors.onSurface,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Enter your full name',
                                        hintStyle: GoogleFonts.atkinsonHyperlegible(
                                          color: _Colors.outline.withValues(alpha: 0.4),
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.person_outline_rounded,
                                          color: _Colors.outline,
                                          size: 20,
                                        ),
                                        filled: true,
                                        fillColor: _Colors.surfaceContainerLow,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                            color: _Colors.outlineVariant.withValues(alpha: 0.5),
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: _Colors.primary,
                                            width: 1.5,
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                // Email Field
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4, bottom: 4),
                                      child: Text(
                                        'Email Address',
                                        style: GoogleFonts.manrope(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: _Colors.onSurfaceVariant,
                                        ),
                                      ),
                                    ),
                                    TextField(
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      style: GoogleFonts.atkinsonHyperlegible(
                                        fontSize: 14,
                                        color: _Colors.onSurface,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'name@example.com',
                                        hintStyle: GoogleFonts.atkinsonHyperlegible(
                                          color: _Colors.outline.withValues(alpha: 0.4),
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.mail_outline_rounded,
                                          color: _Colors.outline,
                                          size: 20,
                                        ),
                                        filled: true,
                                        fillColor: _Colors.surfaceContainerLow,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                            color: _Colors.outlineVariant.withValues(alpha: 0.5),
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: _Colors.primary,
                                            width: 1.5,
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                // Password Field
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4, bottom: 4),
                                      child: Text(
                                        'Password',
                                        style: GoogleFonts.manrope(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: _Colors.onSurfaceVariant,
                                        ),
                                      ),
                                    ),
                                    TextField(
                                      controller: _passwordController,
                                      obscureText: _obscurePassword,
                                      style: GoogleFonts.atkinsonHyperlegible(
                                        fontSize: 14,
                                        color: _Colors.onSurface,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Create a strong password',
                                        hintStyle: GoogleFonts.atkinsonHyperlegible(
                                          color: _Colors.outline.withValues(alpha: 0.4),
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.lock_outline_rounded,
                                          color: _Colors.outline,
                                          size: 20,
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscurePassword ? Icons.visibility : Icons.visibility_off,
                                            color: _Colors.outline,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _obscurePassword = !_obscurePassword;
                                            });
                                          },
                                        ),
                                        filled: true,
                                        fillColor: _Colors.surfaceContainerLow,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                            color: _Colors.outlineVariant.withValues(alpha: 0.5),
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: _Colors.primary,
                                            width: 1.5,
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 24),

                                // Continue Button
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const OTPVerificationScreen(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _Colors.primaryContainer,
                                    foregroundColor: Colors.white,
                                    shadowColor: _Colors.primary.withValues(alpha: 0.2),
                                    elevation: 8,
                                    minimumSize: const Size(double.infinity, 56),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Continue',
                                        style: GoogleFonts.manrope(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(Icons.arrow_forward, size: 20),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 24),

                                // PHI / HIPAA Compliance Note
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF93F2F3).withValues(alpha: 0.1), // tertiary-fixed-dim
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: const Color(0xFF76D6D6).withValues(alpha: 0.2),
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.verified_user_rounded,
                                        color: _Colors.tertiary,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Secure and Compliant',
                                              style: GoogleFonts.manrope(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: _Colors.tertiary,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Your Protected Health Information (PHI) is encrypted and managed in strict accordance with HIPAA standards. We prioritize your privacy above all else.',
                                              style: GoogleFonts.manrope(
                                                fontSize: 11,
                                                color: _Colors.tertiary.withValues(alpha: 0.8),
                                                height: 1.4,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Footer Actions
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignInScreen(),
                                ),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                style: GoogleFonts.atkinsonHyperlegible(
                                  fontSize: 14,
                                  color: _Colors.onSurfaceVariant,
                                ),
                                children: const [
                                  TextSpan(text: 'Already have an account? '),
                                  TextSpan(
                                    text: 'Sign In',
                                    style: TextStyle(
                                      color: _Colors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );

          if (!isDesktop) {
            return mainContentCanvas;
          }

          // Desktop Row Split
          return Row(
            children: [
              Expanded(
                flex: 6,
                child: mainContentCanvas,
              ),
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuD201o4-LyJ4Nh_LSUBKp2PAS4fLbsFJhD7Rc0bSKku7-UITClUI-a2PpKIjKGt6KiW8-XlCPHNflKyMjI8FVY9vr_7o-jy9fGsk5Bogz3VZjXm9FzLKH5ssW6L8NFeAMwIO97wlLv8aUbMk9wpWCyNrZgGvEqKwOk4I8bS9EwnDHPZEe1xPOscyPFu8MvK1926EjngCiUG9uQrLgnD26x62njNiYwujiPepHHW2KVipblX1GbL-NNF9j-dRrgQti7hWVT4kDu8MgaP',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(color: _Colors.primary.withValues(alpha: 0.1)),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [
                              Colors.transparent,
                              _Colors.background.withValues(alpha: 0.8),
                              _Colors.background,
                            ],
                            stops: const [0.0, 0.9, 1.0],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 48,
                      left: 48,
                      right: 48,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Care that understands you.',
                            style: GoogleFonts.manrope(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: _Colors.primary,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Precision health metrics combined with an empathetic approach to chronic management.',
                            style: GoogleFonts.atkinsonHyperlegible(
                              fontSize: 16,
                              color: _Colors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
