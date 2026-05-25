import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'sign_in_screen.dart';
import 'create_account_screen.dart';

// ── Color tokens (from Tailwind config) ─────────────────────────────────────
class AppColors {
  static const background     = Color(0xFFF8F9FF);
  static const surface        = Color(0xFFF8F9FF);
  static const primary        = Color(0xFF5152B9);
  static const primaryContainer   = Color(0xFF8E8FFA);
  static const primaryFixed       = Color(0xFFE2DFFF);
  static const onPrimaryFixed     = Color(0xFF0A006B);
  static const onPrimaryContainer = Color(0xFF221F8A);
  static const secondary      = Color(0xFF844981);
  static const tertiary       = Color(0xFF00696A);
  static const onBackground   = Color(0xFF191C20);
  static const onSurface      = Color(0xFF191C20);
  static const onSurfaceVariant = Color(0xFF464552);
  static const surfaceContainerLowest = Color(0xFFFFFFFF);
  static const surfaceContainerHigh   = Color(0xFFE7E8EE);
  static const surfaceVariant  = Color(0xFFE1E2E8);
  static const outline         = Color(0xFF777684);
  static const outlineVariant  = Color(0xFFC7C5D4);
  static const secondaryContainer = Color(0xFFFFB8F8);
}

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(const PMOSCareApp());
}

class PMOSCareApp extends StatelessWidget {
  const PMOSCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PMOS Care',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          surface: AppColors.surface,
        ),
        fontFamily: 'Manrope',
      ),
      home: const WelcomeScreen(),
    );
  }
}

// ── Welcome Screen ───────────────────────────────────────────────────────────
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late final ScrollController _scrollController;
  bool _scrolled = false;

  // Floating animation controllers
  late final AnimationController _float1;
  late final AnimationController _float2;
  late final Animation<double> _floatAnim1;
  late final Animation<double> _floatAnim2;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        final s = _scrollController.offset > 50;
        if (s != _scrolled) setState(() => _scrolled = s);
      });

    _float1 = AnimationController(
        vsync: this, duration: const Duration(seconds: 6))
      ..repeat(reverse: true);
    _float2 = AnimationController(
        vsync: this, duration: const Duration(seconds: 6))
      ..repeat(reverse: true);

    _floatAnim1 = Tween<double>(begin: 0, end: -10).animate(
      CurvedAnimation(parent: _float1, curve: Curves.easeInOut),
    );
    _floatAnim2 = Tween<double>(begin: -10, end: 0).animate(
      CurvedAnimation(parent: _float2, curve: Curves.easeInOut),
    );

    // Start second animation with offset
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) _float2.forward();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _float1.dispose();
    _float2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeroSection(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildContentCard(),
                  const SizedBox(height: 32),
                  _buildFeatureGrid(),
                  const SizedBox(height: 32),
                  _buildTrustSection(),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // ── App Bar ────────────────────────────────────────────────────────────────
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: _scrolled
          ? AppColors.surface.withValues(alpha: 0.8)
          : AppColors.surface.withValues(alpha: 0.4),
      elevation: _scrolled ? 1 : 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 20,
      title: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.spa, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 8),
          const Text(
            'PMOS Care',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignInScreen()),
              );
            },
            child: const Text(
              'Sign In',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(color: Colors.transparent),
        ),
      ),
    );
  }

  // ── Hero Section ───────────────────────────────────────────────────────────
  Widget _buildHeroSection() {
    return SizedBox(
      height: 574,
      child: Stack(
        children: [
          // Hero image
          Positioned.fill(
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuC5eUb2in1HXoOdsG371yq0XOUP5fyQmvg3Icc38zNATTd3eGF_TTkEeXnDxF2YZtmb4aFrkZPFp1w_qA260QE7CCzkWD2upafgqitWZpGqEw_-NNKv30N1gvile4h05WFc_Qm9UuXS_5mCZJfa25iLvY_2Y6KcpypkTrmQOiGtPVLzzwWB5BAXIO_FVKAYhzRoVbMNooCLjAWVdZEM13GwikLy3vXt0tJojGkDP1eGrB4C7lAdBmXkT73yx6xI86hCb0Q9lIQnvdjP',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: const Color(0xFFEDE9F6),
                child: const Center(
                  child: Icon(Icons.person_outline, size: 100, color: Color(0xFFB0A8D0)),
                ),
              ),
            ),
          ),

          // Bottom fade gradient
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.background.withValues(alpha: 0),
                    AppColors.background.withValues(alpha: 1),
                  ],
                ),
              ),
            ),
          ),

          // Floating blob 1 (top-right)
          Positioned(
            top: 80,
            right: 40,
            child: AnimatedBuilder(
              animation: _floatAnim1,
              builder: (_, child) => Transform.translate(
                offset: Offset(0, _floatAnim1.value),
                child: child,
              ),
              child: Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryContainer.withValues(alpha: 0.2),
                ),
              ),
            ),
          ),

          // Floating blob 2 (bottom-left)
          Positioned(
            bottom: 80,
            left: 40,
            child: AnimatedBuilder(
              animation: _floatAnim2,
              builder: (_, child) => Transform.translate(
                offset: Offset(0, _floatAnim2.value),
                child: child,
              ),
              child: Container(
                width: 128,
                height: 128,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.secondaryContainer.withValues(alpha: 0.2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Glassmorphism Content Card ─────────────────────────────────────────────
  Widget _buildContentCard() {
    return Transform.translate(
      offset: const Offset(0, -128),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Headline
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onBackground,
                    letterSpacing: -0.64,
                    height: 1.25,
                  ),
                  children: [
                    TextSpan(text: 'Your Hormonal Health, '),
                    TextSpan(
                      text: 'Empowered.',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Subtitle
              const Text(
                'Clinical-grade tracking and personalized support for your PMOS journey. Understand your body with precision.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Atkinson Hyperlegible Next',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),

              // Get Started button
              _RippleButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreateAccountScreen()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer,
                    borderRadius: BorderRadius.circular(9999),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Get Started',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.onPrimaryContainer,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward,
                          color: AppColors.onPrimaryContainer, size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Sign In outlined button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInScreen()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(9999),
                    border: Border.all(
                      color: AppColors.secondary,
                      width: 1.5,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }

  // ── Feature Bento Grid ─────────────────────────────────────────────────────
  Widget _buildFeatureGrid() {
    // HTML: grid-cols-2 md:grid-cols-4
    //   Mobile: [Track][Learn] (top row, equal cols)
    //           [Expert Support ————] (full row, col-span-2)
    return Transform.translate(
      offset: const Offset(0, -96),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Track card
              Expanded(
                child: _FeatureCard(
                  iconBg: AppColors.tertiary.withValues(alpha: 0.1),
                  iconColor: AppColors.tertiary,
                  icon: Icons.analytics_outlined,
                  title: 'Track',
                  subtitle: 'Metabolic insights daily.',
                ),
              ),
              const SizedBox(width: 16),
              // Learn card
              Expanded(
                child: _FeatureCard(
                  iconBg: AppColors.primary.withValues(alpha: 0.1),
                  iconColor: AppColors.primary,
                  icon: Icons.menu_book_outlined,
                  title: 'Learn',
                  subtitle: 'Evidence-based guides.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Expert Support card (col-span-2 = full row)
          const _ExpertSupportCard(),
        ],
      ),
    );
  }


  // ── Trust / Clinically Reviewed ────────────────────────────────────────────
  Widget _buildTrustSection() {
    return Transform.translate(
      offset: const Offset(0, -64),
      child: Column(
        children: [
          const Text(
            'CLINICALLY REVIEWED BY',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.5,
              color: AppColors.outline,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _trustBrand('HormoneCare'),
              const SizedBox(width: 24),
              _trustBrand('BioAnalytix'),
              const SizedBox(width: 24),
              _trustBrand('Metabolic+'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _trustBrand(String name) {
    return Opacity(
      opacity: 0.5,
      child: Text(
        name,
        style: const TextStyle(
          fontFamily: 'Manrope',
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.onBackground,
        ),
      ),
    );
  }

  // ── Footer ─────────────────────────────────────────────────────────────────
  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.surfaceVariant, width: 1),
        ),
      ),
      child: Column(
        children: [
          const Text(
            '© 2024 PMOS Care. All data is encrypted and HIPAA compliant.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.6,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Privacy Policy',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Terms of Service',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Feature Card (Track / Learn) ─────────────────────────────────────────────
class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.iconBg,
    required this.iconColor,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final Color iconBg;
  final Color iconColor;
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5152B9).withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Manrope',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontFamily: 'Atkinson Hyperlegible Next',
              fontSize: 14,
              color: AppColors.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Expert Support Card ───────────────────────────────────────────────────────
class _ExpertSupportCard extends StatelessWidget {
  final List<String> _avatarUrls = const [
    'https://lh3.googleusercontent.com/aida-public/AB6AXuBuYx13LIqGY2FND3-FQRz9RzjT6CTAZpYS2dcV57iBxvitG27XKelMgV2igLLOKO2-tmJsDK4rdb4Ep8zbB1hFPckaiz7-9-SCFb_5OcU6BUND5_mM-hc3DMoxHKVLsPhpQqqADpqf9ZLvcD8t1-qbb8jHUsw5xnmzutge0UbohH85kyWSQpQRNTEwuMGo2xEakc2peWNZbQ85srV3NJToQzxldjJatHq-VIk78fa-bHsw8wzAwB_vTtvTfgR0rJ-N56w-qNgrY9Wn',
    'https://lh3.googleusercontent.com/aida-public/AB6AXuCZn-Grqbs5gn3ojL3E9MlTl6Y52-VZo8rW6jsGbUQW3Zu3LYkqcENHKhNx1xDqpo-FODVxqAmS-4RNkxCLMTXL0HvFNVeWdUhfAqhEfUgewdkXJ9B2k0MRBZurBMvFZYHKkUWl8M6KCQ2FaCUaFKkuMvOPbALL7zZCHCaXJ8KEYKAEuY1jHbpMmv21nawrRwuxhx1YHxWJf-7g4qSfY1UQA98r4LRFywlDOg07wp47ZIuw9QHWOr5IxldIpdLhNGnwIWKauB6EVZiY',
  ];

  const _ExpertSupportCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryFixed,
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // Decorative blur circle bottom-right
          Positioned(
            right: -16,
            bottom: -16,
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Expert Support',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onPrimaryFixed,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Connect with specialists who understand your clinical needs.',
                style: TextStyle(
                  fontFamily: 'Atkinson Hyperlegible Next',
                  fontSize: 14,
                  color: AppColors.onPrimaryFixed.withValues(alpha: 0.8),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),

              // Avatar stack + count badge
              Row(
                children: [
                  SizedBox(
                    width: 64,
                    height: 32,
                    child: Stack(
                      children: [
                        for (int i = 0; i < _avatarUrls.length; i++)
                          Positioned(
                            left: i * 20.0,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.primaryFixed,
                                  width: 2,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  _avatarUrls[i],
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    color: AppColors.primaryContainer,
                                    child: const Icon(Icons.person,
                                        color: Colors.white, size: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primaryFixed, width: 2),
                    ),
                    child: const Center(
                      child: Text(
                        '15+',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: AppColors.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Ripple Button (matches HTML ripple effect) ────────────────────────────────
class _RippleButton extends StatefulWidget {
  const _RippleButton({required this.onTap, required this.child});
  final VoidCallback onTap;
  final Widget child;

  @override
  State<_RippleButton> createState() => _RippleButtonState();
}

class _RippleButtonState extends State<_RippleButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      reverseDuration: const Duration(milliseconds: 100),
    );
    _scale = Tween<double>(begin: 1, end: 0.95).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: AnimatedBuilder(
        animation: _scale,
        builder: (_, child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: widget.child,
      ),
    );
  }
}