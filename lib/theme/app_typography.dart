import 'package:flutter/material.dart';

/// Comprehensive typography system for the app
/// Follows Material Design 3 with custom type scales
class AppTypography {
  AppTypography._(); // Private constructor

  // ============ FONT FAMILIES ============
  /// Primary font family for the app
  static const String primaryFont = 'Segoe UI';

  /// Alternative font family (fallback)
  static const String secondaryFont = 'Roboto';

  // ============ DISPLAY STYLES (Large headlines) ============
  /// Display Large - 57sp, weight 400
  /// Used for page titles and major headlines
  static const TextStyle displayLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 57,
    fontWeight: FontWeight.w400,
    height: 1.1,
    letterSpacing: -0.5,
  );

  /// Display Medium - 45sp, weight 400
  /// Used for section titles
  static const TextStyle displayMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 45,
    fontWeight: FontWeight.w400,
    height: 1.2,
    letterSpacing: 0,
  );

  /// Display Small - 36sp, weight 400
  /// Used for subsection titles
  static const TextStyle displaySmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 36,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: 0,
  );

  // ============ HEADLINE STYLES ============
  /// Headline Large - 32sp, weight 700
  /// Used for prominent headlines
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: 0,
  );

  /// Headline Medium - 28sp, weight 700
  /// Used for medium headlines
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: 0,
  );

  /// Headline Small - 24sp, weight 700
  /// Used for small headlines and card titles
  static const TextStyle headlineSmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: 0,
  );

  // ============ TITLE STYLES ============
  /// Title Large - 22sp, weight 700
  /// Used for titles
  static const TextStyle titleLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: 0,
  );

  /// Title Medium - 16sp, weight 700
  /// Used for medium titles
  static const TextStyle titleMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.5,
    letterSpacing: 0.1,
  );

  /// Title Small - 14sp, weight 700
  /// Used for small titles
  static const TextStyle titleSmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.4,
    letterSpacing: 0.1,
  );

  // ============ BODY STYLES (Main content text) ============
  /// Body Large - 16sp, weight 400
  /// Used for main body text
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.5,
  );

  /// Body Medium - 14sp, weight 400
  /// Used for regular body text
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0.25,
  );

  /// Body Small - 12sp, weight 400
  /// Used for secondary body text
  static const TextStyle bodySmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: 0.4,
  );

  // ============ LABEL STYLES ============
  /// Label Large - 14sp, weight 700
  /// Used for labels and chips
  static const TextStyle labelLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.4,
    letterSpacing: 0.1,
  );

  /// Label Medium - 12sp, weight 700
  /// Used for medium labels
  static const TextStyle labelMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: 0.5,
  );

  /// Label Small - 11sp, weight 700
  /// Used for small labels and badges
  static const TextStyle labelSmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 11,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: 0.5,
  );

  // ============ CUSTOM STYLES ============
  /// Caption style - Small text for comments/metadata
  static const TextStyle caption = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: 0.3,
  );

  /// Overline style - Small uppercase text
  static const TextStyle overline = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    height: 1.5,
    letterSpacing: 1.5,
  );

  /// Button style - For button text
  static const TextStyle button = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.4,
    letterSpacing: 0.1,
  );

  /// Input hint style
  static const TextStyle hint = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0.25,
  );

  // ============ CUSTOM APP STYLES ============
  /// Username style - Bold medium text
  static const TextStyle username = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.4,
    letterSpacing: 0,
  );

  /// Post caption style - Large readable text
  static const TextStyle postCaption = TextStyle(
    fontFamily: primaryFont,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0.3,
  );

  /// Timestamp style - Small gray text
  static const TextStyle timestamp = TextStyle(
    fontFamily: primaryFont,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: 0.2,
  );

  /// Engagement count style
  static const TextStyle engagementCount = TextStyle(
    fontFamily: primaryFont,
    fontSize: 13,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: 0,
  );

  /// Story username style
  static const TextStyle storyUsername = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: 0.3,
  );

  /// ============ HELPER METHODS ============
  /// Create a text style with custom color
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  /// Create a text style with custom weight
  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }

  /// Create a text style with custom size
  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }

  /// Create a text style with multiple customizations
  static TextStyle custom({
    required TextStyle baseStyle,
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    double? height,
    double? letterSpacing,
  }) {
    return baseStyle.copyWith(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      height: height,
      letterSpacing: letterSpacing,
    );
  }
}
