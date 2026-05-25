import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'forgot_password_screen.dart';
import 'create_account_screen.dart';
import 'auth_success_screen.dart';
import 'welcome_screen.dart';

// ── Color tokens matching HTML config ────────────────────────────────────────
class _Colors {
  static const primary = Color(0xFF5152B9);
  static const background = Color(0xFFF8F9FF);
  static const onSurface = Color(0xFF191C20);
  static const onSurfaceVariant = Color(0xFF464552);
  static const outline = Color(0xFF777684);
  static const outlineVariant = Color(0xFFC7C5D4);
  static const surfaceContainerLow = Color(0xFFF2F3F9);
  static const surfaceContainerHighest = Color(0xFFE1E2E8);
  static const secondary = Color(0xFF844981);
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _obscurePassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final topPadding = mediaQuery.padding.top;

    return Scaffold(
      backgroundColor: _Colors.background,
      body: Stack(
        children: [
          // ── 1. Hero Background Texture (Subtle Glows) ──
          Positioned.fill(
            child: Stack(
              children: [
                Positioned(
                  top: -screenWidth * 0.15,
                  left: -screenWidth * 0.15,
                  child: Container(
                    width: screenWidth * 0.6,
                    height: screenWidth * 0.6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          _Colors.primary.withValues(alpha: 0.08),
                          _Colors.primary.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -screenWidth * 0.15,
                  right: -screenWidth * 0.15,
                  child: Container(
                    width: screenWidth * 0.6,
                    height: screenWidth * 0.6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          _Colors.secondary.withValues(alpha: 0.08),
                          _Colors.secondary.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── 2. Secure Connection Badge (Top Right) ──
          Positioned(
            top: topPadding + 16,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF45A8A9).withValues(alpha: 0.1), // tertiary-container
                borderRadius: BorderRadius.circular(9999),
                border: Border.all(
                  color: const Color(0xFF00696A).withValues(alpha: 0.2), // tertiary
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.verified_user_rounded,
                    size: 18,
                    color: Color(0xFF00696A),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Secure Connection',
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF00696A),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── 3. Back Button (Top Left) ──
          Positioned(
            top: topPadding + 12,
            left: 12,
            child: IconButton(
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
          ),

          // ── 4. Main Scrollable Canvas ──
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 32),

                      // Header Branding
                      Column(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: _Colors.primary,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: _Colors.primary.withValues(alpha: 0.2),
                                  blurRadius: 16,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.medical_services_rounded,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'PMOS Care',
                            style: GoogleFonts.manrope(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: _Colors.primary,
                              letterSpacing: -0.64,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Secure clinical portal for metabolic health management',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.atkinsonHyperlegible(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: _Colors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Glass-panel Login Card
                      ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.4),
                              borderRadius: BorderRadius.circular(32),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.6),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: _Colors.primary.withValues(alpha: 0.06),
                                  blurRadius: 32,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
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
                                        fontSize: 16,
                                        color: _Colors.onSurface,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'name@example.com',
                                        hintStyle: GoogleFonts.atkinsonHyperlegible(
                                          color: _Colors.outline.withValues(alpha: 0.6),
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.mail_outline_rounded,
                                          color: _Colors.outline,
                                          size: 20,
                                        ),
                                        filled: true,
                                        fillColor: _Colors.surfaceContainerLow,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide.none,
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => const ForgotPasswordScreen(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Forgot Password?',
                                            style: GoogleFonts.manrope(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: _Colors.primary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TextField(
                                      controller: _passwordController,
                                      obscureText: _obscurePassword,
                                      style: GoogleFonts.atkinsonHyperlegible(
                                        fontSize: 16,
                                        color: _Colors.onSurface,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: '••••••••',
                                        hintStyle: GoogleFonts.atkinsonHyperlegible(
                                          color: _Colors.outline.withValues(alpha: 0.6),
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
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide.none,
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 24),

                                // Sign In Button
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const AuthSuccessScreen(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _Colors.primary,
                                    foregroundColor: Colors.white,
                                    shadowColor: _Colors.primary.withValues(alpha: 0.2),
                                    elevation: 8,
                                    minimumSize: const Size(double.infinity, 56),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Sign In',
                                        style: GoogleFonts.manrope(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(Icons.arrow_forward, size: 20),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 24),

                                // Biometric Integration Divider
                                Row(
                                  children: [
                                    Expanded(child: Divider(color: _Colors.outlineVariant.withValues(alpha: 0.5))),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      child: Text(
                                        'or securely sign in with',
                                        style: GoogleFonts.manrope(
                                          fontSize: 12,
                                          color: _Colors.outline,
                                        ),
                                      ),
                                    ),
                                    Expanded(child: Divider(color: _Colors.outlineVariant.withValues(alpha: 0.5))),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                // Biometric Buttons
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildBiometricButton(Icons.face_retouching_natural_rounded),
                                    const SizedBox(width: 24),
                                    _buildBiometricButton(Icons.fingerprint_rounded),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Footer Actions
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CreateAccountScreen(),
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
                              TextSpan(text: "Don't have an account? "),
                              TextSpan(
                                text: 'Create an Account',
                                style: TextStyle(
                                  color: _Colors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Regulatory links
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        children: [
                          _buildFooterLink('Privacy Policy'),
                          Text('•', style: TextStyle(color: _Colors.outlineVariant.withValues(alpha: 0.5))),
                          _buildFooterLink('HIPAA Compliance'),
                          Text('•', style: TextStyle(color: _Colors.outlineVariant.withValues(alpha: 0.5))),
                          _buildFooterLink('Help Center'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBiometricButton(IconData icon) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: _Colors.surfaceContainerHighest,
        shape: BoxShape.circle,
        border: Border.all(
          color: _Colors.primary.withValues(alpha: 0.2),
          width: 2,
        ),
      ),
      child: Center(
        child: Icon(
          icon,
          color: _Colors.primary,
          size: 32,
        ),
      ),
    );
  }

  Widget _buildFooterLink(String label) {
    return Text(
      label,
      style: GoogleFonts.manrope(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: _Colors.outline,
      ),
    );
  }
}
