import 'package:flutter/material.dart';
import '../models/package_model.dart';
import '../app_theme.dart';
import 'game_page.dart';
import '../data/questions_data.dart';

class PackagePage extends StatelessWidget {
  final PackageCategory category;

  const PackagePage({super.key, required this.category});

  String get categoryTitle {
    switch (category) {
      case PackageCategory.friends: return 'دورهمی دوستانه';
      case PackageCategory.date: return 'دیت و روابط';
      case PackageCategory.philosophy: return 'سوالات فلسفی';
    }
  }

  String get categoryEmoji {
    switch (category) {
      case PackageCategory.friends: return '🥳';
      case PackageCategory.date: return '❤️';
      case PackageCategory.philosophy: return '🧠';
    }
  }

  List<GamePackage> getPackages(List<GamePackage> all) {
    return all.where((p) => p.category == category).toList();
  }

  @override
  Widget build(BuildContext context) {
    final packages = getPackages(allPackages);

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // هدر
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xffFAFAFA), size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        categoryTitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xffFAFAFA)),
                      ),
                    ),
                    Text(
                      categoryEmoji,
                      style: TextStyle(fontSize: 28, fontFamilyFallback: AppTheme.fontFamilyFallback),
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                child: Text(
                  'بسته مناسب جمعت رو انتخاب کن',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ),

              const SizedBox(height: 16),

              // لیست بسته‌ها
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  itemCount: packages.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final package = packages[index];
                    return _PackageCard(package: package);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PackageCard extends StatelessWidget {
  final GamePackage package;

  const _PackageCard({required this.package});

  void _onTap(BuildContext context) {
    if (package.isFree) {
      _startGame(context);
    } else {
      _showPurchaseSheet(context);
    }
  }

  void _startGame(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => GamePage(package: package)),
    );
  }

  void _showPurchaseSheet(BuildContext context) {
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
              '🔒 این بسته پریمیومه',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xffFAFAFA), fontFamilyFallback: AppTheme.fontFamilyFallback),
            ),
            const SizedBox(height: 8),
            Text(
              '${package.title} — ${package.levelLabel}',
              style: TextStyle(fontSize: 14, color: package.levelColor),
            ),
            const SizedBox(height: 24),

            // قیمت
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xff8B5CF6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xff8B5CF6).withOpacity(0.3)),
              ),
              child: Text(
                '${(package.price / 10).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')} تومان',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xffFAFAFA), fontFamily: 'ShabnamFD'),
              ),
            ),
            const SizedBox(height: 24),

            // دکمه خرید
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // TODO: پیاده‌سازی پرداخت
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff8B5CF6),
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                '🛒 خرید بسته',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamilyFallback: AppTheme.fontFamilyFallback),
              ),
            ),
            const SizedBox(height: 12),

            // دکمه تماشای تبلیغ
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
                // TODO: نمایش تبلیغ و رفتن به بازی
                _startGame(context);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: package.levelColor.withOpacity(0.5)),
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                '📺 تماشای تبلیغ (رایگان)',
                style: TextStyle(color: const Color(0xffFAFAFA), fontSize: 15, fontFamilyFallback: AppTheme.fontFamilyFallback),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(context),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff18181B),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: package.levelColor.withOpacity(0.35), width: 2),
          boxShadow: [BoxShadow(color: package.levelColor.withOpacity(0.1), blurRadius: 15, offset: const Offset(0, 5))],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // هدر کارت
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: package.levelColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: package.levelColor.withOpacity(0.4)),
                  ),
                  child: Text(
                    '${package.levelEmoji}  ${package.levelLabel}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: package.levelColor,
                      fontFamilyFallback: AppTheme.fontFamilyFallback,
                    ),
                  ),
                ),
                const Spacer(),
                if (package.isFree)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xff22C55E).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xff22C55E).withOpacity(0.4)),
                    ),
                    child: const Text('رایگان', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xff22C55E))),
                  )
                else
                  Text(
                    '${(package.price / 10).toStringAsFixed(0)} تومان',
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xffFAFAFA), fontFamily: 'ShabnamFD'),
                  ),
              ],
            ),

            const SizedBox(height: 14),

            // عنوان و زیرعنوان
            Text(
              package.subtitle,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xffFAFAFA)),
            ),
            const SizedBox(height: 4),
            Text(
              '${package.questions.length} کارت سوال',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),

            const SizedBox(height: 16),

            // تگ‌ها
            ...package.tags.map((tag) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  SizedBox(
                    width: 70,
                    child: Text(tag.label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: List.generate(5, (i) => Container(
                      margin: const EdgeInsets.only(right: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i < tag.score ? package.levelColor : Colors.white12,
                      ),
                    )),
                  ),
                ],
              ),
            )),

            const SizedBox(height: 8),

            // دکمه پایین
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _onTap(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: package.isFree ? package.levelColor : const Color(0xff8B5CF6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: Text(
                  package.isFree ? '🎮 شروع بازی' : '🔓 باز کردن بسته',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamilyFallback: AppTheme.fontFamilyFallback),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}