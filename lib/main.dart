import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'app_theme.dart';

void main() {
  runApp(const CringeGameApp());
}

class CringeGameApp extends StatelessWidget {
  const CringeGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cringe',
      debugShowCheckedModeBanner: false,
      locale: const Locale('fa', 'IR'),
      supportedLocales: const [Locale('fa', 'IR')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: AppTheme.darkTheme,
      home: const MainMenuPage(),
    );
  }
}

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
                              shadows: [Shadow(color: const Color(0xffFF3B5C).withOpacity(0.8), blurRadius: 25)],
                              color: Colors.transparent,
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
                    AnimatedGlassMenuButton(
                      title: '🥳  دورهمی دوستانه',
                      subtitle: 'مخصوص جمع‌های رفقا و اکیپ‌های صمیمی',
                      icon: '🎉',
                      gradientColors: [const Color(0xffFF3B5C).withOpacity(0.15), const Color(0xff8B5CF6).withOpacity(0.05)],
                      borderColor: const Color(0xffFF3B5C).withOpacity(0.3),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LevelSelectionPage(category: 'friends'))),
                    ),
                    const SizedBox(height: 20),
                    AnimatedGlassMenuButton(
                      title: '❤️  دیت و روابط عاطفی',
                      subtitle: 'مخصوص شناخت بیشتر و شکستن یخ رابطه',
                      icon: '❤️',
                      gradientColors: [const Color(0xff8B5CF6).withOpacity(0.15), const Color(0xffFF3B5C).withOpacity(0.05)],
                      borderColor: const Color(0xff8B5CF6).withOpacity(0.3),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LevelSelectionPage(category: 'date'))),
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

class LevelSelectionPage extends StatelessWidget {
  final String category;
  const LevelSelectionPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    bool isFriends = category == 'friends';
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
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xffFAFAFA), size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Text(
                        'انتخاب لول بازی',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xffFAFAFA)),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  isFriends ? 'چقدر با هم صمیمی هستید؟' : 'در چه مرحله‌ای از دیت هستید؟',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: LevelCard(
                    title: 'SAFE',
                    subtitle: isFriends ? 'محترمانه و مجلسی' : 'دیت اول (یخ‌شکن)',
                    emoji: '😇',
                    color: const Color(0xff22C55E),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GamePage(category: category, level: 1))),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: LevelCard(
                    title: 'SPICY',
                    subtitle: isFriends ? 'صمیمی و رفاقتی' : 'دیت دوم (عمیق‌تر)',
                    emoji: '😏',
                    color: const Color(0xffF59E0B),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GamePage(category: category, level: 2))),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: LevelCard(
                    title: 'TOXIC',
                    subtitle: isFriends ? 'سمی و دارک (بدون تعارف)' : 'دیت سوم به بعد (خفن)',
                    emoji: '☠️',
                    color: const Color(0xffEF4444),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GamePage(category: category, level: 3))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GamePage extends StatefulWidget {
  final String category;
  final int level;
  const GamePage({super.key, required this.category, required this.level});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with SingleTickerProviderStateMixin {
  late List<String> _selectedQuestions;
  int _currentIndex = 0;
  late AnimationController _shakeController;

  final Map<String, Map<int, List<String>>> _questionsRepository = {
    'friends': {
      1: [
        "اگر همین الان مجبور باشی یکی از رازهای کوچکت رو به نفر سمت راستت بگی، چی بهش می‌گی؟",
        "آخرین باری که وانمود کردی کسی رو نشناختی تا باهاش سلام‌علیک نکنی کی بوده؟",
        "کرینج‌ترین و ضایع‌ترین سوتی که موقع فرستادن یک پیام در واتس‌اپ یا تلگرام دادی چی بوده？",
        "اگر بتونی بدون اینکه کسی بفهمه، یک شبانه‌روز جای یکی از افراد این جمع باشی، کی رو انتخاب می‌کنی؟",
        "بامزه‌ترین یا عجیب‌ترین چیزی که توی بچگی بهش باور داشتی و الان بهش می‌خندی چیه؟",
      ],
      2: [
        "آخرین باری که از شدت خجالت یا ضایع‌شدن می‌خواستی زمین دهن باز کنه و بری توش کی بود؟ چکار کردی؟",
        "کرینج‌ترین جوک، تکه یا استوری که تا حالا گذاشتی و هیچ‌کس بهش ری‌اکشن نشون نداده رو تعریف کن.",
        "تا حالا شده مخفیانه از یکی از دوستای این جمع شدیداً دلخور بشی ولی به رویش نیاری؟ چرا؟",
        "اگر گوشی‌ت همین الان بدون رمز بیفته دست این جمع، بیشترین ترست از لو رفتن چیه؟ (عکس، چت یا سرچ گوگل؟)",
        "یک عادت خیلی عجیب یا سمی که موقع تنهایی داری و هیچ‌کس ازش خبر نداره چیه؟",
      ],
      3: [
        "عجیب‌ترین، سمی‌ترین یا خجالت‌آورترین چیزی که تا حالا توی گوگل سرچ کردی و آبروبره چی بوده؟",
        "اگر مجبور باشی برای نجات جونت، یک نفر از افراد این جمع رو برای همیشه از زندگیت بلاک و حذف کنی، اون کیه؟",
        "پشت سر کدام‌یک از افراد حاضر در این جمع تا حالا حرف زدی یا غیبت کردی؟ صریح بگو در چه موردی بود؟",
        "بزرگ‌ترین دروغی که در چند سال اخیر به رفقات یا خانواده‌ت گفتی تا از یک موقعیت فرار کنی چی بوده؟",
        "اگر یک کیسه پول بهت بدن و بگن باید صمیمی‌ترین دوستت در این جمع رو بفروشی (دیگه نبینیش)، با این پول چکار می‌کنی؟",
      ],
    },
    'date': {
      1: [
        "اولین ویژگی ظاهری یا رفتاری که در نگاه اول توی دیت‌ها جلب توجهت می‌کنه چیه؟",
        "ایده‌آل‌ترین و رویایی‌ترین تعریف تو از یک قرار عاشقانه (Date) بی‌نقص چیه؟",
        "بزرگ‌ترین خط قرمز یا ردفلگ (Red Flag) فوری تو در همان برخوردهای اول چیه؟",
        "عجیب‌ترین یا بی‌ربط‌ترین سوالی که تا حالا توی یک دیت اول ازت پرسیدن چی بوده؟",
        "اگر یک نفر بخواد خیلی سریع دلت رو به دست بیاره، باید چکار کنه یا چی بگه؟",
      ],
      2: [
        "اگر پارتنرت بتونه کاملاً ذهنت رو بخونه، اولین چیزی که ممکنه باعث بشه سریع باهات کات کنه چیه؟",
        "آخرین باری که به خاطر یک رابطه عاطفی یا دلتنگی گریه کردی کی بود و ماجراش چی بود؟",
        "کرینج‌ترین یا ضایع‌ترین حرکتی که تا حالا توی یک دیت برای تحت تأثیر قرار دادن طرف مقابل کردی چی بوده؟",
        "تا حالا شده وسط دیت بفهمی اصلاً از طرف خوشت نمیاد؟ چطوری اون موقعیت رو جمع کردی یا فرار کردی؟",
        "کدام ویژگی اخلاقی پارتنر قبلی‌ت بوده که اگر در فرد جدید هم ببینی، ثانیه‌ای در رابطه نمی‌مونی؟",
      ],
      3: [
        "یک راز، فانتزی یا طرز فکر خاص در مورد رابطه که تا حالا به هیچ‌کس (حتی نزدیک‌ترین چشمت) نگفتی چیه؟",
        "بزرگ‌ترین گندکاری، خیانت یا اشتباهی که تا حالا در رابطه‌های عاطفی گذشته‌ت مرتکب شدی چی بوده؟",
        "اگر همین الان اکس‌ت (پارتنر قبلیت) پیام بده و بگه 'دلم برات تنگ شده'، ته دلت واقعاً چه واکنشی نشون می‌دی؟",
        "تا حالا شده هم‌زمان به دو نفر حس داشته باشی یا بخوای هر دو رو توی مایه دیت نگه داری؟ چکار کردی؟",
        "به نظرت سمی‌ترین و تاریک‌ترین بخش شخصیت تو در یک رابطه عاطفی که طرف مقابل بعداً می‌فهمه چیه؟",
      ],
    }
  };

  @override
  void initState() {
    super.initState();
    _selectedQuestions = _questionsRepository[widget.category]?[widget.level] ?? ["سوالی یافت نشد!"];
    _shakeController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    if (widget.level == 3) _triggerShake();
  }

  void _triggerShake() => _shakeController.forward(from: 0.0);

  void _nextCard() {
    setState(() => _currentIndex = (_currentIndex < _selectedQuestions.length - 1) ? _currentIndex + 1 : 0);
    if (widget.level == 3) _triggerShake();
  }

  void _prevCard() {
    setState(() => _currentIndex = (_currentIndex > 0) ? _currentIndex - 1 : _selectedQuestions.length - 1);
    if (widget.level == 3) _triggerShake();
  }

  void _showRandomQuestionBottomSheet() {
    final allQuestions = _questionsRepository[widget.category]!.values.expand((e) => e).toList();
    final randomQuestion = (allQuestions..shuffle()).first;
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
              '🎲 سوال تصادفی و شانس تو',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xff8B5CF6), fontFamilyFallback: AppTheme.fontFamilyFallback),
            ),
            const SizedBox(height: 20),
            Text(randomQuestion, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, color: Color(0xffFAFAFA), height: 1.5)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff8B5CF6),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                'فهمیدم چالش رو 🤝',
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
    double progressValue = (_currentIndex + 1) / _selectedQuestions.length;
    bool isToxic = widget.level == 3;
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
                    boxShadow: [BoxShadow(color: (isToxic ? const Color(0xffEF4444) : const Color(0xffFF3B5C)).withOpacity(0.12), blurRadius: 90, spreadRadius: 10)],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xffFAFAFA), size: 20),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(color: const Color(0xff18181B), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white10)),
                          child: Row(
                            children: [
                              const Text('کارت ', style: TextStyle(fontSize: 13, color: Colors.grey)),
                              Text('${_currentIndex + 1}', style: const TextStyle(fontFamily: 'ShabnamFD', fontWeight: FontWeight.bold, color: Color(0xffFF3B5C))),
                              const Text(' از ', style: TextStyle(fontSize: 13, color: Colors.grey)),
                              Text('${_selectedQuestions.length}', style: const TextStyle(fontFamily: 'ShabnamFD', fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progressValue,
                        backgroundColor: Colors.white10,
                        color: isToxic ? const Color(0xffEF4444) : const Color(0xffFF3B5C),
                        minHeight: 6,
                      ),
                    ),
                    const Spacer(),
                    AnimatedBuilder(
                      animation: _shakeController,
                      builder: (context, child) {
                        double offset = _shakeController.value > 0 ? math.sin(_shakeController.value * 4 * math.pi) * 8 : 0.0;
                        return Transform.translate(offset: Offset(offset, 0), child: child);
                      },
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 350),
                        transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: FadeTransition(opacity: animation, child: child)),
                        child: KeyedSubtree(
                          key: ValueKey<int>(_currentIndex),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.48,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xff1E293B), Color(0xff0F172A)]),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: isToxic ? const Color(0xffEF4444).withOpacity(0.5) : const Color(0xffFF3B5C).withOpacity(0.3), width: 2),
                              boxShadow: [BoxShadow(color: (isToxic ? const Color(0xffEF4444) : const Color(0xffFF3B5C)).withOpacity(0.15), blurRadius: 25, spreadRadius: 2)],
                            ),
                            padding: const EdgeInsets.all(32),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  isToxic ? '☠️ TOXIC QUESTION' : '🔥 CRINGE CARD',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.5,
                                    fontFamilyFallback: AppTheme.fontFamilyFallback,
                                    color: isToxic ? const Color(0xffEF4444) : const Color(0xffFF3B5C),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  _selectedQuestions[_currentIndex],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xffFAFAFA), height: 1.6),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('👈 رد کن', style: TextStyle(fontSize: 12, color: Colors.grey[500], fontFamilyFallback: AppTheme.fontFamilyFallback)),
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
                              backgroundColor: isToxic ? const Color(0xffEF4444) : const Color(0xffFF3B5C),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              elevation: 5,
                              shadowColor: (isToxic ? const Color(0xffEF4444) : const Color(0xffFF3B5C)).withOpacity(0.4),
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
                      onPressed: _showRandomQuestionBottomSheet,
                      icon: const Icon(Icons.casino, size: 20),
                      label: Text(
                        '🎲 سوال تصادفی (چالش آنی)',
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

class AnimatedGlassMenuButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  final List<Color> gradientColors;
  final Color borderColor;
  final VoidCallback onTap;

  const AnimatedGlassMenuButton({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
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
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xffFAFAFA), fontFamilyFallback: AppTheme.fontFamilyFallback),
                        ),
                        const SizedBox(height: 6),
                        Text(subtitle, style: const TextStyle(fontSize: 13, color: Colors.grey, height: 1.4)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(icon, style: TextStyle(fontSize: 44, fontFamilyFallback: AppTheme.fontFamilyFallback)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LevelCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String emoji;
  final Color color;
  final VoidCallback onTap;

  const LevelCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.color,
    required this.onTap,
  });

  @override
  State<LevelCard> createState() => _LevelCardState();
}

class _LevelCardState extends State<LevelCard> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.96),
      onTapUp: (_) { setState(() => _scale = 1.0); widget.onTap(); },
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        transform: Matrix4.identity()..scale(_scale),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xff18181B),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: widget.color.withOpacity(0.35), width: 2),
          boxShadow: [BoxShadow(color: widget.color.withOpacity(0.1), blurRadius: 15, offset: const Offset(0, 5))],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Text(widget.emoji, style: TextStyle(fontSize: 36, fontFamilyFallback: AppTheme.fontFamilyFallback)),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: widget.color, letterSpacing: 1)),
                  const SizedBox(height: 2),
                  Text(widget.subtitle, style: const TextStyle(fontSize: 13, color: Color(0xffFAFAFA))),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: widget.color.withOpacity(0.6), size: 18),
          ],
        ),
      ),
    );
  }
}