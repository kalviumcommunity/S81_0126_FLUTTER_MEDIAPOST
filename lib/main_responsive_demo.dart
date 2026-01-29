import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/responsive_home.dart';
import 'utils/colors.dart';

// Responsive Mobile UI Demo
// This file demonstrates how to integrate the responsive_home.dart screen
// into your Flutter application.
//
// Features:
// - MediaQuery-based responsive design
// - Automatic layout adaptation for mobile/tablet/desktop
// - Orientation-aware layouts
// - Touch-friendly design patterns

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Firebase initialization failed: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone - Responsive UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Light theme with Material 3 design
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
          brightness: Brightness.light,
        ),
        // Custom app bar theme
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 2,
          surfaceTintColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Custom bottom navigation bar theme
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),
        // Custom floating action button theme
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.light,
      // Set ResponsiveHome as home screen
      home: const ResponsiveHome(),
      // Global error handler
      builder: (context, child) {
        return Scaffold(
          body: child,
          // Show safe area to demonstrate MediaQuery info
          // Uncomment to debug safe area and device info
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     _showDeviceInfo(context);
          //   },
          //   child: const Icon(Icons.info),
          // ),
        );
      },
    );
  }
}

// Debug helper to show device information
void _showDeviceInfo(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
  final size = mediaQuery.size;
  final padding = mediaQuery.padding;
  final viewInsets = mediaQuery.viewInsets;
  final orientation = mediaQuery.orientation;
  final devicePixelRatio = mediaQuery.devicePixelRatio;

  String deviceType = size.width >= 600 ? 'Tablet' : 'Phone';
  String orientationStr = orientation == Orientation.portrait ? 'Portrait' : 'Landscape';

  String info = '''
Device Information:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Screen Size: ${size.width.toStringAsFixed(0)} × ${size.height.toStringAsFixed(0)} dp
Device Type: $deviceType
Orientation: $orientationStr
Device Pixel Ratio: ${devicePixelRatio.toStringAsFixed(2)}

Safe Area Padding:
  Top: ${padding.top.toStringAsFixed(0)}
  Bottom: ${padding.bottom.toStringAsFixed(0)}
  Left: ${padding.left.toStringAsFixed(0)}
  Right: ${padding.right.toStringAsFixed(0)}

View Insets (Keyboard):
  Top: ${viewInsets.top.toStringAsFixed(0)}
  Bottom: ${viewInsets.bottom.toStringAsFixed(0)}

Layout Mode:
  Mobile (<600): Single column, bottom nav
  Tablet (≥600, portrait): Sidebar + content
  Tablet (≥600, landscape): Sidebar + 2-column
  ''';

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Device Information'),
      content: SingleChildScrollView(
        child: Text(
          info,
          style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}

// ============================================================================
// USAGE EXAMPLES & BEST PRACTICES
// ============================================================================

/*
RESPONSIVE DESIGN PATTERNS IN THIS APP:

1. BREAKPOINT STRATEGY
   ─────────────────────
   • Mobile: < 600dp width
   • Tablet: ≥ 600dp width
   • Landscape triggers additional layout changes
   
   Usage:
   ```dart
   if (MediaQuery.of(context).size.width >= 600) {
     return tabletLayout();
   } else {
     return mobileLayout();
   }
   ```

2. RESPONSIVE TYPOGRAPHY
   ──────────────────────
   Different font sizes for different screens:
   
   // Mobile
   Headline: 20sp
   Body: 14sp
   Caption: 12sp
   
   // Tablet
   Headline: 24sp
   Body: 16sp
   Caption: 14sp
   
   Usage:
   ```dart
   Text(
     'Title',
     style: TextStyle(
       fontSize: ResponsiveHelper.getHeadlineSmall(context),
     ),
   )
   ```

3. FLEXIBLE WIDGETS
   ────────────────
   Use Expanded/Flexible to fill available space:
   
   Usage:
   ```dart
   Row(
     children: [
       Container(width: 100),  // Fixed
       Expanded(              // Takes remaining space
         child: Container(),
       ),
     ],
   )
   ```

4. LAYOUT BUILDER
   ──────────────
   Get constraints and choose layout:
   
   Usage:
   ```dart
   LayoutBuilder(
     builder: (context, constraints) {
       if (constraints.maxWidth > 600) {
         return wideLayout();
       } else {
         return narrowLayout();
       }
     },
   )
   ```

5. ASPECT RATIO
   ────────────
   Maintain aspect ratio for images:
   
   Usage:
   ```dart
   AspectRatio(
     aspectRatio: 16 / 9,
     child: Image.network(url),
   )
   ```

6. ORIENTATION DETECTION
   ─────────────────────
   Handle portrait vs landscape:
   
   Usage:
   ```dart
   if (MediaQuery.of(context).orientation == Orientation.portrait) {
     return portraitLayout();
   } else {
     return landscapeLayout();
   }
   ```

7. SAFE AREA
   ─────────
   Avoid notches and system UI:
   
   Usage:
   ```dart
   SafeArea(
     child: Container(),
   )
   ```

8. RESPONSIVE PADDING & SPACING
   ────────────────────────────
   Scale spacing based on screen size:
   
   Usage:
   ```dart
   Container(
     padding: EdgeInsets.all(
       ResponsiveHelper.horizontalPadding(context),
     ),
   )
   ```

TESTING CHECKLIST:
✓ Test on Pixel (412dp width)
✓ Test on Pixel XL (412dp width in landscape)
✓ Test on iPad Mini (768dp width)
✓ Test on iPad Pro (1024dp width)
✓ Test orientation changes
✓ Test with notch/safe area
✓ Test keyboard appearing
✓ Test at different DPI scales
✓ Test with system font size increased
✓ Test with different text scales

PERFORMANCE TIPS:
• Use const constructors to prevent rebuilds
• Use LayoutBuilder instead of rebuilding entire tree
• Use ListView.builder for scrollable lists
• Cache expensive calculations
• Use keys for list items
• Profile with DevTools
• Test on real devices, not just emulators

COMMON MISTAKES TO AVOID:
✗ Using fixed sizes (avoid hardcoding 100.0, 200.0)
✗ Not testing landscape orientation
✗ Forgetting safe area (notches, system UI)
✗ Not handling keyboard appearance
✗ Overflow issues on small screens
✗ Assuming same DPI on all devices
✗ Not testing with real devices
✗ Ignoring touch target minimum size (48x48dp)
✗ Using too many nested columns/rows
✗ Not considering accessibility

RESPONSIVE FRAMEWORKS:
• MediaQuery - Get device info (this app)
• LayoutBuilder - Conditional layout
• FittedBox - Fit content to constraints
• AspectRatio - Maintain aspect ratio
• Expanded/Flexible - Fill available space
• Wrap - Wrap items when they overflow
• GridView - Grid layout
• CustomMultiChildLayout - Complex layouts
*/
