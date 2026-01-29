import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:instagram/constants/colors.dart';
import 'package:instagram/responsive/responsive_layout_screen.dart';
import 'package:instagram/screens/mobile_screen_layout.dart';
import 'package:instagram/screens/web_screen_layout.dart';
import 'screens/stateless_stateful_demo.dart';
import 'screens/devtools_demo.dart';
import 'screens/navigation_home_screen.dart';
import 'screens/details_screen.dart';
import 'screens/navigation_profile_screen.dart';
import 'screens/navigation_settings_screen.dart';
import 'screens/navigation_nested_screen.dart';
import 'screens/responsive_layout_demo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: FirebaseConfig.currentPlatform,
    );
  } catch (e) {
    print('Firebase initialization error: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Set to true to view demo screens instead of the main app
    // Change isDemoMode to true to access all learning demos
    const bool isDemoMode = false;
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: isDemoMode ? 'Flutter Development Demos' : 'Instagram clone',
      theme: isDemoMode
          ? ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
            )
          : ThemeData.dark().copyWith(
              scaffoldBackgroundColor: mobileBackgroundColor,
            ),
      home: isDemoMode
          ? const DemoHomeScreen()
          : const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
      routes: {
        '/navigation': (context) => const NavigationHomeScreen(),
        '/details': (context) => const DetailsScreen(),
        '/profile': (context) => const NavigationProfileScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/nested': (context) => const NestedNavigationScreen(),
      },
    );
  }
}

/// Demo Home Screen - Access all learning demos
class DemoHomeScreen extends StatelessWidget {
  const DemoHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Learning Demos'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Sprint #2 - Developer Tools & Widgets',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _DemoCard(
                title: 'Stateless vs Stateful Widgets',
                description: 'Learn the difference between immutable and stateful widgets',
                icon: Icons.widgets,
                color: Colors.blue,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StatelessStatefulDemoScreen(),
                    ),
                  );
                },
              ),
              _DemoCard(
                title: 'Hot Reload & DevTools',
                description: 'Master Hot Reload, Debug Console, and DevTools effectively',
                icon: Icons.build,
                color: Colors.purple,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DevToolsDemoScreen(),
                    ),
                  );
                },
              ),
              _DemoCard(
                title: 'Multi-Screen Navigation',
                description: 'Learn Navigator, named routes, and data passing',
                icon: Icons.navigation,
                color: Colors.green,
                onTap: () {
                  Navigator.pushNamed(context, '/navigation');
                },
              ),
              _DemoCard(
                title: 'Responsive Layout Design',
                description: 'Master Rows, Columns, Containers, and MediaQuery',
                icon: Icons.device_unknown,
                color: Colors.orange,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResponsiveLayoutHub(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DemoCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _DemoCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.3),
                color.withOpacity(0.1),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 32, color: color),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_forward, color: color),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
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

