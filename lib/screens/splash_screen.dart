import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'welcome_screen.dart';

// ── Color tokens matching HTML config ────────────────────────────────────────
class _Colors {
  static const primary = Color(0xFF5152B9);
  static const primaryContainer = Color(0xFF8E8FFA);
  static const secondaryContainer = Color(0xFFFFB8F8);
  static const onSurfaceVariant = Color(0xFF464552);
  static const outline = Color(0xFF777684);
  static const surfaceContainer = Color(0xFFECEEF3);
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // Animation controllers
  late final AnimationController _pulseController;
  late final AnimationController _floatController;
  late final AnimationController _fadeInUpController;
  late final AnimationController _loadingBarController;
  late final AnimationController _bottomFadeController;

  // Animations
  late final Animation<double> _pulseGlow;
  late final Animation<double> _floatOffset;
  late final Animation<double> _fadeInOpacity;
  late final Animation<double> _fadeInTranslate;
  late final Animation<double> _loadingProgress;
  late final Animation<double> _bottomFadeOpacity;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    // 1. Soft pulse animation (Logo glow & background orb)
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _pulseGlow = Tween<double>(begin: 0.8, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // 2. Float animation (Logo & background orb)
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);

    _floatOffset = Tween<double>(begin: 0.0, end: -10.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // 3. Central cluster Fade In Up animation (1.2 seconds)
    _fadeInUpController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeInOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeInUpController, curve: const Interval(0.0, 0.8, curve: Curves.easeOut)),
    );

    _fadeInTranslate = Tween<double>(begin: 20.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeInUpController, curve: Curves.easeOutCubic),
    );

    // 4. Loading Bar animation (starts after 0.5s delay, runs for 3 seconds)
    _loadingBarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 10000),
    );

    _loadingProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _loadingBarController, curve: Curves.easeOutSine),
    );

    // 5. Bottom Loading indicator fade-in (2 seconds delay)
    _bottomFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _bottomFadeOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _bottomFadeController, curve: Curves.easeIn),
    );

    // Start execution sequence
    _fadeInUpController.forward();

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _loadingBarController.forward();
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) _bottomFadeController.forward();
    });

    // Auto-redirect to WelcomeScreen after 4.5 seconds
    Future.delayed(const Duration(milliseconds: 4500), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const WelcomeScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _floatController.dispose();
    _fadeInUpController.dispose();
    _loadingBarController.dispose();
    _bottomFadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      body: Stack(
        children: [
          // ── 1. Gradient Background ──
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.9,
                  colors: [
                    Color(0xFFE2DFFF), // center pale lavender
                    Color(0xFFF8F9FF), // brand background
                    Color(0xFFF1F3F9), // subtle edge tint
                  ],
                  stops: [0.0, 0.7, 1.0],
                ),
              ),
            ),
          ),

          // ── 2. Subtle Background Pattern Image (Opacity 0.03) ──
          Positioned.fill(
            child: Opacity(
              opacity: 0.03,
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuDVR8oTimqJy4RveNUDEQyjdHGnim6RB1zddCt5QshC_IZLcJX7zaPcjkpXVyH906qAK_6FgUwOnqvV1dYU-tPKCprAN1ISQONrvOe3TGQ_5ERjF5eGNC8DNKPiE-5FjurEl33BR9iAv6UbUsdbxFFS0yNUjGVydSO1Et4chOXId6BINpubTPxwpOjyPvjK1QOTRAVKoQMOCA5Lahht4H9F-e6W2UnmiXf7a30pR7OiGDOWgZElsDCBO0It3unXF55zdrO-Z-qZ5pOu',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          ),

          // ── 3. Abstract Background Orbs for Depth ──
          // Top-Left Orb (Pulses)
          Positioned(
            top: -screenWidth * 0.15,
            left: -screenWidth * 0.15,
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Container(
                  width: screenWidth * 0.6,
                  height: screenWidth * 0.6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        _Colors.primaryContainer.withValues(alpha: 0.18 * _pulseGlow.value),
                        _Colors.primaryContainer.withValues(alpha: 0.0),
                      ],
                      stops: const [0.2, 0.8],
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom-Right Orb (Floats)
          Positioned(
            bottom: -screenWidth * 0.1,
            right: -screenWidth * 0.1,
            child: AnimatedBuilder(
              animation: _floatController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _floatOffset.value * 0.8),
                  child: Container(
                    width: screenWidth * 0.5,
                    height: screenWidth * 0.5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          _Colors.secondaryContainer.withValues(alpha: 0.18),
                          _Colors.secondaryContainer.withValues(alpha: 0.0),
                        ],
                        stops: const [0.2, 0.8],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // ── 4. Central Identity Cluster ──
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AnimatedBuilder(
                animation: _fadeInUpController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeInOpacity.value,
                    child: Transform.translate(
                      offset: Offset(0, _fadeInTranslate.value),
                      child: child,
                    ),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo Container
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // Outer Glow
                        AnimatedBuilder(
                          animation: _pulseController,
                          builder: (context, child) {
                            return Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: _Colors.primaryContainer.withValues(alpha: 0.25 * _pulseGlow.value),
                                    blurRadius: 40,
                                    spreadRadius: 8,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        // Main Logo Glass Panel with Float Animation
                        AnimatedBuilder(
                          animation: _floatController,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, _floatOffset.value),
                              child: child,
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(32),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                              child: Container(
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.4),
                                  borderRadius: BorderRadius.circular(32),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.6),
                                    width: 1.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.08),
                                      blurRadius: 32,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // Main Icon
                                    const Icon(
                                      Icons.spa_rounded,
                                      size: 52,
                                      color: _Colors.primary,
                                    ),

                                    // Spark Detail / Flare
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: AnimatedBuilder(
                                        animation: _pulseController,
                                        builder: (context, child) {
                                          return Opacity(
                                            opacity: (0.5 + 0.5 * _pulseGlow.value).clamp(0.0, 1.0),
                                            child: const Icon(
                                              Icons.flare,
                                              size: 16,
                                              color: Color(0xFF844981), // secondary color
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Brand Typography
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
                      'Personalized metabolic and hormonal wellness.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: _Colors.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── 5. Bottom Loading Indicator & Progress Bar ──
          Positioned(
            bottom: 64,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _bottomFadeController,
              builder: (context, child) {
                return Opacity(
                  opacity: _bottomFadeOpacity.value,
                  child: child,
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Progress Loading Bar track
                  Container(
                    width: 192,
                    height: 4,
                    decoration: BoxDecoration(
                      color: _Colors.surfaceContainer,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    alignment: Alignment.centerLeft,
                    child: AnimatedBuilder(
                      animation: _loadingProgress,
                      builder: (context, child) {
                        return FractionallySizedBox(
                          widthFactor: _loadingProgress.value,
                          child: Container(
                            decoration: BoxDecoration(
                              color: _Colors.primaryContainer,
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Status Label
                  Text(
                    'Preparing your insights',
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: _Colors.outline,
                      letterSpacing: 1.5,
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
}