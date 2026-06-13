import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import '../models/package_model.dart';
import '../app_theme.dart';

class GamePage extends StatefulWidget {
  final GamePackage package;

  const GamePage({super.key, required this.package});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _shakeController;

  bool get isToxic => widget.package.level == PackageLevel.toxic;
  Color get levelColor => widget.package.levelColor;
  List<String> get questions => widget.package.questions;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    if (isToxic) _triggerShake();
  }

  void _triggerShake() => _shakeController.forward(from: 0.0);

  void _nextCard() {
    setState(() => _currentIndex = (_currentIndex < questions.length - 1) ? _currentIndex + 1 : 0);
    if (isToxic) _triggerShake();
  }

  void _prevCard() {
    setState(() => _currentIndex = (_currentIndex > 0) ? _currentIndex - 1 : questions.length - 1);
    if (isToxic) _triggerShake();
  }

  void _showRandomQuestion() {
    final random = (List<String>.from(questions)..shuffle()).first;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Color(0xff18181B),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
          border: Border(top: BorderSide(color: Color(0xff8B5CF6), width: 2)),
        ),
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 50, height: 4, decoration: BoxDecoration(color: Colors.grey[600], borderRadius: BorderRadius.circular(10))),
            const SizedBox(height: 24),
            Text(
              '🎲 سوال تصادفی',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xff8B5CF6), fontFamilyFallback: AppTheme.fontFamilyFallback),
            ),
            const SizedBox(height: 20),
            Text(random, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, color: Color(0xffFAFAFA), height: 1.5)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff8B5CF6),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                'فهمیدم 🤝',
                style: TextStyle(fontWeight: FontWeight.bold, fontFamilyFallback: AppTheme.fontFamilyFallback),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progressValue = (_currentIndex + 1) / questions.length;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff0F172A), Color(0xff09090B)],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: MediaQuery.of(context).size.height * 0.25,
                left: MediaQuery.of(context).size.width * 0.15,
                child: Container(
                  width: 260, height: 260,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: levelColor.withOpacity(0.12), blurRadius: 90, spreadRadius: 10)],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // هدر
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xffFAFAFA), size: 20),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Column(
                          children: [
                            Text(
                              widget.package.title,
                              style: const TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                            Text(
                              widget.package.levelLabel,
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: levelColor),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xff18181B),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white10),
                          ),
                          child: Row(
                            children: [
                              const Text('کارت ', style: TextStyle(fontSize: 13, color: Colors.grey)),
                              Text('${_currentIndex + 1}', style: TextStyle(fontFamily: 'ShabnamFD', fontWeight: FontWeight.bold, color: levelColor)),
                              const Text(' از ', style: TextStyle(fontSize: 13, color: Colors.grey)),
                              Text('${questions.length}', style: const TextStyle(fontFamily: 'ShabnamFD', fontWeight: FontWeight.bold, color: Color(0xffFAFAFA))),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // progress bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progressValue,
                        backgroundColor: Colors.white10,
                        color: levelColor,
                        minHeight: 6,
                      ),
                    ),
                    const Spacer(),

                    // کارت سوال
                    AnimatedBuilder(
                      animation: _shakeController,
                      builder: (context, child) {
                        double offset = _shakeController.value > 0 ? math.sin(_shakeController.value * 4 * math.pi) * 8 : 0.0;
                        return Transform.translate(offset: Offset(offset, 0), child: child);
                      },
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 350),
                        transitionBuilder: (child, animation) => ScaleTransition(
                          scale: animation,
                          child: FadeTransition(opacity: animation, child: child),
                        ),
                        child: KeyedSubtree(
                          key: ValueKey<int>(_currentIndex),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.45,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xff1E293B), Color(0xff0F172A)],
                              ),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: levelColor.withOpacity(0.4), width: 2),
                              boxShadow: [BoxShadow(color: levelColor.withOpacity(0.15), blurRadius: 25, spreadRadius: 2)],
                            ),
                            padding: const EdgeInsets.all(32),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${widget.package.levelEmoji} ${widget.package.levelLabel}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.5,
                                    color: levelColor,
                                    fontFamilyFallback: AppTheme.fontFamilyFallback,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  questions[_currentIndex],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xffFAFAFA), height: 1.6),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('👈 قبلی', style: TextStyle(fontSize: 12, color: Colors.grey[500], fontFamilyFallback: AppTheme.fontFamilyFallback)),
                                    Text('بعدی 👉', style: TextStyle(fontSize: 12, color: Colors.grey[500], fontFamilyFallback: AppTheme.fontFamilyFallback)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),

                    // دکمه‌ها
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _prevCard,
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white24),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                            child: Text(
                              'کارت قبلی 🫣',
                              style: TextStyle(color: const Color(0xffFAFAFA), fontSize: 15, fontFamilyFallback: AppTheme.fontFamilyFallback),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _nextCard,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: levelColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              elevation: 5,
                              shadowColor: levelColor.withOpacity(0.4),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                            child: Text(
                              'کارت بعدی 👀',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamilyFallback: AppTheme.fontFamilyFallback),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    ElevatedButton.icon(
                      onPressed: _showRandomQuestion,
                      icon: const Icon(Icons.casino, size: 20),
                      label: Text(
                        '🎲 سوال تصادفی',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamilyFallback: AppTheme.fontFamilyFallback),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff18181B),
                        foregroundColor: const Color(0xff8B5CF6),
                        side: const BorderSide(color: Color(0xff8B5CF6), width: 1.5),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    const SizedBox(height: 10),
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