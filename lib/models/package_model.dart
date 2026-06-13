import 'package:flutter/material.dart';

enum PackageLevel { safe, spicy, toxic }

enum PackageCategory { friends, date, philosophy }

class PackageTag {
  final String label;
  final int score; // 1 تا 5

  const PackageTag({required this.label, required this.score});
}

class GamePackage {
  final String id;
  final String title;
  final String subtitle;
  final PackageCategory category;
  final PackageLevel level;
  final bool isFree;
  final int price;
  final List<String> questions;
  final List<PackageTag> tags;

  const GamePackage({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.level,
    required this.isFree,
    required this.price,
    required this.questions,
    required this.tags,
  });

  Color get levelColor {
    switch (level) {
      case PackageLevel.safe: return const Color(0xff22C55E);
      case PackageLevel.spicy: return const Color(0xffF59E0B);
      case PackageLevel.toxic: return const Color(0xffEF4444);
    }
  }

  String get levelLabel {
    switch (level) {
      case PackageLevel.safe: return 'SAFE';
      case PackageLevel.spicy: return 'SPICY';
      case PackageLevel.toxic: return 'TOXIC';
    }
  }

  String get levelEmoji {
    switch (level) {
      case PackageLevel.safe: return '😇';
      case PackageLevel.spicy: return '😏';
      case PackageLevel.toxic: return '☠️';
    }
  }
}