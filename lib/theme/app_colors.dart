import 'package:flutter/material.dart';

/// Comprehensive color palette for the Instagram-inspired app
/// Follows Material Design 3 principles with custom Instagram branding
class AppColors {
  AppColors._(); // Private constructor

  // ============ PRIMARY COLORS ============
  /// Instagram primary gradient start - Deep vibrant pink/purple
  static const Color primaryStart = Color(0xFFE1306C);

  /// Instagram primary gradient end - Deep orange
  static const Color primaryEnd = Color(0xFFFD1D1D);

  /// Instagram secondary gradient color - Yellow/Gold
  static const Color tertiary = Color(0xFFFEDA75);

  /// Main primary color for buttons and highlights
  static const Color primary = Color(0xFFE1306C);

  /// Secondary color for accents
  static const Color secondary = Color(0xFFFD1D1D);

  /// Tertiary for additional accents
  static const Color accent = Color(0xFFFEDA75);

  // ============ BACKGROUND & SURFACE COLORS ============
  /// Main app background - Clean white
  static const Color appBackground = Color(0xFFFAFAFA);

  /// Surface color for cards and containers
  static const Color surface = Color(0xFFFFFFFF);

  /// Secondary surface for nested elements
  static const Color surfaceVariant = Color(0xFFF3F3F3);

  /// Tertiary surface for hover/selected states
  static const Color surfaceAlt = Color(0xFFEFEFEF);

  // ============ TEXT & CONTENT COLORS ============
  /// Primary text color - Dark for readability
  static const Color textPrimary = Color(0xFF262626);

  /// Secondary text color - Medium gray
  static const Color textSecondary = Color(0xFF65676B);

  /// Tertiary text color - Light gray
  static const Color textTertiary = Color(0xFFA8A8A8);

  /// Disabled/hint text color
  static const Color textDisabled = Color(0xFFBDBDBD);

  /// Text on dark backgrounds (white)
  static const Color textOnDark = Color(0xFFFFFFFF);

  // ============ INTERACTIVE COLORS ============
  /// Success color for positive actions
  static const Color success = Color(0xFF31A24C);

  /// Error/danger color for destructive actions
  static const Color error = Color(0xFFED4956);

  /// Warning color for caution messages
  static const Color warning = Color(0xFFFFA500);

  /// Info color for informational messages
  static const Color info = Color(0xFF0095F6);

  /// Like button color (Instagram red)
  static const Color like = Color(0xFFED4956);

  // ============ BORDER & DIVIDER COLORS ============
  /// Light border color for subtle divisions
  static const Color borderLight = Color(0xFFDBDBDB);

  /// Dark border color for emphasis
  static const Color borderDark = Color(0xFFD0D0D0);

  /// Divider color for separating content
  static const Color divider = Color(0xFFEDEDED);

  // ============ OVERLAY & SHADOW COLORS ============
  /// Overlay for modals and overlays
  static const Color overlay = Color(0x80000000); // 50% black

  /// Light overlay for subtle backgrounds
  static const Color overlayLight = Color(0x14000000); // 8% black

  /// Shadow color for depth
  static const Color shadow = Color(0x1F000000); // 12% black

  // ============ SPECIAL COLORS ============
  /// Gradient start for Instagram brand
  static const Color gradientStart = Color(0xFFE1306C);

  /// Gradient end for Instagram brand
  static const Color gradientEnd = Color(0xFFFD1D1D);

  /// Gradient accent for highlight
  static const Color gradientAccent = Color(0xFFFEDA75);

  /// Stories gradient color
  static const Color storiesGradient = Color(0xFFF7CE34);

  /// Verified checkmark color
  static const Color verified = Color(0xFF0095F6);

  /// Online indicator color
  static const Color online = Color(0xFF31A24C);

  /// Away indicator color
  static const Color away = Color(0xFFFFA500);

  // ============ UTILITY COLORS ============
  /// Transparent color
  static const Color transparent = Color(0x00000000);

  /// White color
  static const Color white = Color(0xFFFFFFFF);

  /// Black color
  static const Color black = Color(0xFF000000);

  /// Light gray for backgrounds
  static const Color lightGray = Color(0xFFF0F0F0);

  /// Dark gray for text
  static const Color darkGray = Color(0xFF3C3C3C);

  // ============ COLOR SWATCHES ============
  /// Extended color palette for various uses
  static const Map<int, Color> primarySwatch = {
    50: Color(0xFFFCEEF4),
    100: Color(0xFFF7D4E3),
    200: Color(0xFFF0B8D0),
    300: Color(0xFFE99CBD),
    400: Color(0xFFE47BB3),
    500: Color(0xFFE1306C),
    600: Color(0xFFDD2B63),
    700: Color(0xFFD72558),
    800: Color(0xFFD11F4E),
    900: Color(0xFFC9113D),
  };

  static const Map<int, Color> secondarySwatch = {
    50: Color(0xFFFEF0ED),
    100: Color(0xFFFDDDD5),
    200: Color(0xFFFCC7B8),
    300: Color(0xFFFB9B86),
    400: Color(0xFFFB7D5E),
    500: Color(0xFFFD1D1D),
    600: Color(0xFFFA1C1C),
    700: Color(0xFFF31A1A),
    800: Color(0xFFE51918),
    900: Color(0xFFD60F0F),
  };

  // ============ GRADIENT DEFINITIONS ============
  /// Main Instagram gradient (horizontal)
  static const LinearGradient instagramGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFE1306C),
      Color(0xFFFD1D1D),
    ],
  );

  /// Alternative gradient (bottom to top)
  static const LinearGradient instagramGradientVertical = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFE1306C),
      Color(0xFFFD1D1D),
    ],
  );

  /// Subtle gradient for backgrounds
  static const LinearGradient subtleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFAFAFA),
      Color(0xFFF3F3F3),
    ],
  );

  /// Rich gradient with all three colors
  static const LinearGradient richGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFE1306C),
      Color(0xFFFD1D1D),
      Color(0xFFFEDA75),
    ],
  );

  // ============ OPACITY UTILITIES ============
  /// Get a color with custom opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  /// Blend two colors
  static Color blend(Color color1, Color color2, double ratio) {
    return Color.alphaBlend(
      color2.withOpacity(ratio),
      color1,
    );
  }
}
