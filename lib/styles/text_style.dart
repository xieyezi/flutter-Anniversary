import 'dart:ui';
import 'package:flutter/material.dart';

class AppTextStyles {
  /// APP Title
  static const TextStyle appTitle = TextStyle(
    decoration: TextDecoration.none,
    fontSize: 30,
    color: Colors.black87,
    fontWeight: FontWeight.bold,
    fontFamily: 'Conspired',
  );

  /// APP Welcome
  static const TextStyle appTip = TextStyle(
    fontSize: 12,
    decoration: TextDecoration.none,
    color: Colors.black54,
  );

  /// Daily title
  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 30,
    color: Colors.white,
    decoration: TextDecoration.none,
  );

  /// Daily headText
  static const TextStyle headTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.white,
    decoration: TextDecoration.none,
  );

  /// Daily targetDay
  static const TextStyle targetDayStyle = TextStyle(
    fontSize: 16,
    color: Colors.white,
    decoration: TextDecoration.none,
  );

  /// (Daily countYear countMonth countDay countTotalDay) Title
  static const TextStyle countTitleStyle = TextStyle(
    fontSize: 24,
    color: Colors.white,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
  );

  /// (Daily countYear countMonth countDay countTotalDay) BottomTip
  static const TextStyle countBottomTipStyle = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.none,
  );

  /// (Daily detail Content) BottomTip
  static const TextStyle contentStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w200,
    letterSpacing: 1.1,
    height: 1.5,
  );
}
