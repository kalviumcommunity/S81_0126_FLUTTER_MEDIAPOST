import 'package:flutter/material.dart';

/// Details Screen
/// Demonstrates simple navigation with pop operation
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('📋 DetailsScreen: Build called');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
        backgroundColor: Colors.blue.shade600,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            debugPrint('🔙 DetailsScreen: Popping back to home');
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Header Card
              Card(
                elevation: 4,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade400, Colors.blue.shade600],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.info,
                        size: 48,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Screen Information',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'You navigated using Navigator.pushNamed()',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// Details Section
              const Text(
                'Route Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              _DetailCard(
                icon: Icons.route,
                title: 'Route Name',
                value: '/details',
                description: 'Named route defined in main.dart',
              ),

              _DetailCard(
                icon: Icons.receipt,
                title: 'Widget Type',
                value: 'StatelessWidget',
                description: 'No state management needed',
              ),

              _DetailCard(
                icon: Icons.directions,
                title: 'Navigation Method',
                value: 'Navigator.pushNamed()',
                description: 'Push new route onto the stack',
              ),

              const SizedBox(height: 24),

              /// Features Section
              const Text(
                'Features',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              _FeatureItem(
                number: '1',
                title: 'Stack-Based Navigation',
                description: 'This screen is placed on top of the navigation stack',
              ),

              _FeatureItem(
                number: '2',
                title: 'Pop Operation',
                description: 'Tap back to remove this screen from stack',
              ),

              _FeatureItem(
                number: '3',
                title: 'Lifecycle',
                description: 'Build called on push, dispose on pop',
              ),

              const SizedBox(height: 24),

              /// Code Example Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade700),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '💻 Code Example:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '''// Navigate to details screen
Navigator.pushNamed(context, '/details');

// Pop back to previous screen
Navigator.pop(context);''',
                      style: TextStyle(
                        color: Colors.green.shade300,
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// Action Buttons
              ElevatedButton.icon(
                icon: const Icon(Icons.arrow_back),
                label: const Text('Go Back to Home'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  debugPrint('🔙 DetailsScreen: Pop button tapped');
                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: 12),

              OutlinedButton.icon(
                icon: const Icon(Icons.home),
                label: const Text('Navigate Home Using pushNamedAndRemoveUntil'),
                onPressed: () {
                  debugPrint('🏠 DetailsScreen: Navigate home with removeUntil');
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (route) => false,
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

/// Detail Card Widget
class _DetailCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String description;

  const _DetailCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(icon, color: Colors.blue.shade600, size: 24),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
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

/// Feature Item Widget
class _FeatureItem extends StatelessWidget {
  final String number;
  final String title;
  final String description;

  const _FeatureItem({
    required this.number,
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
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.blue.shade600,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
