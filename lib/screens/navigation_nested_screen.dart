import 'package:flutter/material.dart';

/// Nested Navigation Screen
/// Demonstrates multi-level navigation with nested routes
class NestedNavigationScreen extends StatefulWidget {
  const NestedNavigationScreen({Key? key}) : super(key: key);

  @override
  State<NestedNavigationScreen> createState() => _NestedNavigationScreenState();
}

class _NestedNavigationScreenState extends State<NestedNavigationScreen> {
  final List<String> _navigationHistory = ['Level 1'];

  @override
  void initState() {
    super.initState();
    debugPrint('🔗 NestedNavigationScreen: initState called');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('🔗 NestedNavigationScreen: Build called');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nested Navigation'),
        backgroundColor: Colors.orange.shade600,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            debugPrint('🔙 NestedNavigationScreen: Popping back');
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
              /// Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange.shade400, Colors.orange.shade600],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.layers,
                      size: 40,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Multi-Level Navigation',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Navigate through multiple screen levels',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// Current Level Info
              Card(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Current Navigation Level',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.orange.shade300),
                        ),
                        child: Text(
                          _navigationHistory.last,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.orange.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// Navigation Path
              const Text(
                'Navigation Path',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              ..._buildNavigationPath(),

              const SizedBox(height: 24),

              /// Level Navigation Cards
              const Text(
                'Navigate to Levels',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              _LevelNavigationCard(
                level: 'Level 2',
                icon: Icons.arrow_downward,
                description: 'Go deeper into nested navigation',
                color: Colors.orange,
                onTap: () {
                  setState(() {
                    _navigationHistory.add('Level 2');
                    debugPrint('📍 Navigated to: ${_navigationHistory.last}');
                  });
                },
              ),

              _LevelNavigationCard(
                level: 'Level 3',
                icon: Icons.arrow_downward,
                description: 'Even deeper nested level',
                color: Colors.orange.shade700,
                onTap: () {
                  if (_navigationHistory.last.contains('Level 2')) {
                    setState(() {
                      _navigationHistory.add('Level 3');
                      debugPrint('📍 Navigated to: ${_navigationHistory.last}');
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Navigate to Level 2 first'),
                      ),
                    );
                  }
                },
              ),

              const SizedBox(height: 24),

              /// Stack Explanation
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '📚 Navigation Stack Model',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _StackExplanation(
                      level: _navigationHistory.length >= 3 ? '3' : '?',
                      label: 'Level 3 (Top)',
                      description: 'Current screen if navigated',
                      backgroundColor: Colors.orange.shade100,
                    ),
                    _StackExplanation(
                      level: _navigationHistory.length >= 2 ? '2' : '?',
                      label: 'Level 2 (Middle)',
                      description: 'Previous screen',
                      backgroundColor: Colors.orange.shade50,
                    ),
                    _StackExplanation(
                      level: '1',
                      label: 'Level 1 (Bottom)',
                      description: 'Initial screen',
                      backgroundColor: Colors.white,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// Code Example
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
                      '💻 Nested Navigation Example:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '''// Push Level 2
Navigator.pushNamed(context, '/level2');

// From Level 2, push Level 3
Navigator.pushNamed(context, '/level3');

// Pop from Level 3 to Level 2
Navigator.pop(context);

// Pop from Level 2 to Level 1
Navigator.pop(context);''',
                      style: TextStyle(
                        color: Colors.green.shade300,
                        fontFamily: 'monospace',
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// Action Buttons
              ElevatedButton.icon(
                icon: const Icon(Icons.arrow_back),
                label: const Text('Go Back One Level'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade600,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _navigationHistory.length > 1
                    ? () {
                        setState(() {
                          _navigationHistory.removeLast();
                          debugPrint(
                            '📍 Popped to: ${_navigationHistory.last}',
                          );
                        });
                      }
                    : null,
              ),

              const SizedBox(height: 12),

              OutlinedButton.icon(
                icon: const Icon(Icons.home),
                label: const Text('Return to Home Screen'),
                onPressed: () {
                  debugPrint('🏠 NestedNavigationScreen: Navigate home');
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build navigation path visualization
  List<Widget> _buildNavigationPath() {
    return [
      Row(
        children: [
          ..._navigationHistory.asMap().entries.map((entry) {
            final isLast = entry.key == _navigationHistory.length - 1;
            return Expanded(
              child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isLast ? Colors.orange.shade600 : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${entry.key + 1}',
                        style: TextStyle(
                          color: isLast ? Colors.white : Colors.grey.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    entry.value,
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    ];
  }
}

/// Level Navigation Card Widget
class _LevelNavigationCard extends StatelessWidget {
  final String level;
  final IconData icon;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const _LevelNavigationCard({
    required this.level,
    required this.icon,
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
                        level,
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

/// Stack Explanation Widget
class _StackExplanation extends StatelessWidget {
  final String level;
  final String label;
  final String description;
  final Color backgroundColor;

  const _StackExplanation({
    required this.level,
    required this.label,
    required this.description,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.orange.shade300),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.orange.shade600,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  level,
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
                    label,
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
