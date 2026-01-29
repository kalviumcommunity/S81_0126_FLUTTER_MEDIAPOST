import 'package:flutter/material.dart';

/// Navigation Home Screen
/// Demonstrates multi-screen navigation using Navigator and named routes
class NavigationHomeScreen extends StatelessWidget {
  const NavigationHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('🏠 NavigationHomeScreen: Build called');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Hub'),
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Multi-Screen Navigation Demo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Navigate between screens using Navigator.pushNamed()',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 32),
              
              /// Route 1: Simple Navigation
              _NavigationCard(
                icon: Icons.arrow_forward,
                title: 'Simple Navigation',
                description: 'Navigate to Details Screen using pushNamed',
                color: Colors.blue,
                onTap: () {
                  debugPrint('🔵 Navigating to /details');
                  Navigator.pushNamed(context, '/details');
                },
              ),

              /// Route 2: Navigation with Data
              _NavigationCard(
                icon: Icons.send,
                title: 'Pass Data to Screen',
                description: 'Navigate with arguments using pushNamed',
                color: Colors.green,
                onTap: () {
                  debugPrint('🟢 Navigating to /profile with data');
                  Navigator.pushNamed(
                    context,
                    '/profile',
                    arguments: 'Data from HomeScreen',
                  );
                },
              ),

              /// Route 3: Settings Screen
              _NavigationCard(
                icon: Icons.settings,
                title: 'Settings Screen',
                description: 'Navigate to app settings',
                color: Colors.purple,
                onTap: () {
                  debugPrint('🟣 Navigating to /settings');
                  Navigator.pushNamed(context, '/settings');
                },
              ),

              /// Route 4: Nested Navigation
              _NavigationCard(
                icon: Icons.layers,
                title: 'Nested Navigation',
                description: 'Multi-level screen navigation',
                color: Colors.orange,
                onTap: () {
                  debugPrint('🟠 Navigating to /nested');
                  Navigator.pushNamed(context, '/nested');
                },
              ),

              const SizedBox(height: 32),
              
              /// Navigation Info Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '📚 How Navigation Works:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _InfoRow(
                      icon: Icons.stack_exchange,
                      title: 'Stack-Based Model',
                      description: 'Screens are pushed and popped like a stack',
                    ),
                    _InfoRow(
                      icon: Icons.label,
                      title: 'Named Routes',
                      description: 'Routes are defined in main.dart with names',
                    ),
                    _InfoRow(
                      icon: Icons.data_object,
                      title: 'Pass Arguments',
                      description: 'Send data along with navigation',
                    ),
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

/// Reusable Navigation Card Widget
class _NavigationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const _NavigationCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward, color: color),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Info Row Widget
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.blue.shade700),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
