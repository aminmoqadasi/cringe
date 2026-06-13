import 'package:flutter/material.dart';
import 'dart:ui';
import '../models/package_model.dart';
import '../app_theme.dart';
import 'package_page.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
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
        child: SafeArea(
          child: Stack(
            children: [
              // نئون چپ
              Positioned(
                top: 100, left: -50,
                child: Container(
                  width: 200, height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: const Color(0xffFF3B5C).withOpacity(0.15), blurRadius: 80, spreadRadius: 20)],
                  ),
                ),
              ),
              // نئون راست
              Positioned(
                bottom: 150, right: -50,
                child: Container(
                  width: 250, height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: const Color(0xff8B5CF6).withOpacity(0.15), blurRadius: 100, spreadRadius: 25)],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                child: Column(
                  children: [
                    const Spacer(flex: 2),

                    // لوگو
                    ScaleTransition(
                      scale: Tween<double>(begin: 0.96, end: 1.04).animate(
                        CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            '🔥 CRINGE 🔥',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                              fontFamilyFallback: AppTheme.fontFamilyFallback,
                              color: Colors.transparent,
                              shadows: [Shadow(color: const Color(0xffFF3B5C).withOpacity(0.8), blurRadius: 25)],
                            ),
                          ),
                          Text(
                            '🔥 CRINGE 🔥',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                              fontFamilyFallback: AppTheme.fontFamilyFallback,
                              color: const Color(0xffFAFAFA),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // تگ
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
                    ),

                    const Spacer(flex: 2),

                    // دکمه‌های دسته‌بندی
                    _CategoryButton(
                      title: '🥳  دورهمی دوستانه',
                      subtitle: 'مخصوص جمع‌های رفقا و اکیپ‌های صمیمی',
                      emoji: '🎉',
                      gradientColors: [const Color(0xffFF3B5C).withOpacity(0.15), const Color(0xff8B5CF6).withOpacity(0.05)],
                      borderColor: const Color(0xffFF3B5C).withOpacity(0.3),
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (_) => const PackagePage(category: PackageCategory.friends),
                      )),
                    ),

                    const SizedBox(height: 16),

                    _CategoryButton(
                      title: '❤️  دیت و روابط',
                      subtitle: 'مخصوص شناخت بیشتر و شکستن یخ رابطه',
                      emoji: '❤️',
                      gradientColors: [const Color(0xff8B5CF6).withOpacity(0.15), const Color(0xffFF3B5C).withOpacity(0.05)],
                      borderColor: const Color(0xff8B5CF6).withOpacity(0.3),
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (_) => const PackagePage(category: PackageCategory.date),
                      )),
                    ),

                    const SizedBox(height: 16),

                    _CategoryButton(
                      title: '🧠  سوالات فلسفی',
                      subtitle: 'مخصوص تأمل، کشف و چالش‌های عمیق',
                      emoji: '🧠',
                      gradientColors: [const Color(0xff6366F1).withOpacity(0.15), const Color(0xff8B5CF6).withOpacity(0.05)],
                      borderColor: const Color(0xff6366F1).withOpacity(0.3),
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (_) => const PackagePage(category: PackageCategory.philosophy),
                      )),
                    ),

                    const Spacer(),
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

class _CategoryButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final String emoji;
  final List<Color> gradientColors;
  final Color borderColor;
  final VoidCallback onTap;

  const _CategoryButton({
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.gradientColors,
    required this.borderColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: gradientColors, begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(24),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xffFAFAFA), fontFamilyFallback: AppTheme.fontFamilyFallback),
                        ),
                        const SizedBox(height: 6),
                        Text(subtitle, style: const TextStyle(fontSize: 13, color: Colors.grey, height: 1.4)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(emoji, style: TextStyle(fontSize: 40, fontFamilyFallback: AppTheme.fontFamilyFallback)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}