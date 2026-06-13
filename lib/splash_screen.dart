import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'app_theme.dart';
import 'pages/main_menu_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _glowController;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    Future.delayed(const Duration(milliseconds: 4000), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const MainMenuPage(),
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
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff0F172A), Color(0xff1E1B4B), Color(0xff09090B)],
          ),
        ),
        child: Stack(
          children: [
            // نئون چپ
            Positioned(
              top: 100, left: -60,
              child: AnimatedBuilder(
                animation: _glowController,
                builder: (context, child) => Container(
                  width: 250, height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(
                      color: const Color(0xffFF3B5C).withOpacity(0.1 + _glowController.value * 0.1),
                      blurRadius: 100, spreadRadius: 20,
                    )],
                  ),
                ),
              ),
            ),
            // نئون راست
            Positioned(
              bottom: 100, right: -60,
              child: AnimatedBuilder(
                animation: _glowController,
                builder: (context, child) => Container(
                  width: 250, height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(
                      color: const Color(0xff8B5CF6).withOpacity(0.1 + _glowController.value * 0.1),
                      blurRadius: 100, spreadRadius: 20,
                    )],
                  ),
                ),
              ),
            ),

            // محتوای اصلی
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ایموجی آتش
                  Text('🔥', style: TextStyle(fontSize: 64, fontFamilyFallback: AppTheme.fontFamilyFallback))
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 200.ms)
                    .scaleXY(begin: 0.5, end: 1.0, duration: 600.ms, delay: 200.ms, curve: Curves.elasticOut),

                  const SizedBox(height: 24),

                  // لوگو CRINGE
                  AnimatedBuilder(
                    animation: _glowController,
                    builder: (context, child) => Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          'CRINGE',
                          style: TextStyle(
                            fontSize: 52,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 4,
                            color: Colors.transparent,
                            shadows: [Shadow(
                              color: const Color(0xffFF3B5C).withOpacity(0.6 + _glowController.value * 0.4),
                              blurRadius: 30 + _glowController.value * 20,
                            )],
                          ),
                        ),
                        const Text(
                          'CRINGE',
                          style: TextStyle(
                            fontSize: 52,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 4,
                            color: Color(0xffFAFAFA),
                          ),
                        ),
                      ],
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 700.ms, delay: 500.ms)
                  .slideY(begin: 0.3, end: 0.0, duration: 700.ms, delay: 500.ms, curve: Curves.easeOut),

                  const SizedBox(height: 12),

                  // تگ PARTY EDITION
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xffFF3B5C).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xffFF3B5C).withOpacity(0.3)),
                    ),
                    child: Text(
                      'PARTY EDITION 🎲',
                      style: TextStyle(
                        color: const Color(0xffFF3B5C),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontFamilyFallback: AppTheme.fontFamilyFallback,
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 900.ms),

                  const SizedBox(height: 80),

                  // نوشته استودیو
                  Column(
                    children: [
                      Text(
                        'CRINGE GAME STUDIO',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 3,
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: 40, height: 1,
                        color: Colors.white.withOpacity(0.15),
                      ),
                    ],
                  )
                  .animate()
                  .fadeIn(duration: 800.ms, delay: 1400.ms),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}