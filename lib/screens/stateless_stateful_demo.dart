import 'package:flutter/material.dart';

/// Main Demo Screen - Combines both Stateless and Stateful Widgets
class StatelessStatefulDemoScreen extends StatelessWidget {
  const StatelessStatefulDemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stateless vs Stateful Widgets'),
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Stateless Widget Section
            const DemoHeader(
              title: 'Stateless Widget',
              description: 'Static content that doesn\'t change',
            ),
            const SizedBox(height: 20),
            const StaticInfoCard(
              icon: Icons.info_outline,
              title: 'What is a Stateless Widget?',
              content:
                  'A StatelessWidget is immutable and does not store any mutable state. '
                  'It builds once and remains unchanged unless rebuilt by its parent widget. '
                  'Perfect for static UI components like labels, icons, and text.',
            ),
            const SizedBox(height: 30),

            /// Stateful Widget Section
            const DemoHeader(
              title: 'Stateful Widget',
              description: 'Interactive content that changes dynamically',
            ),
            const SizedBox(height: 20),

            /// Counter Demo - Stateful Widget
            const InteractiveCounterWidget(),

            const SizedBox(height: 30),

            /// Color Changer Demo - Another Stateful Widget
            const ColorChangerWidget(),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// STATELESS WIDGETS
// ============================================================================

/// Stateless Widget: Demo Header
/// This widget displays a static title and description that don't change.
class DemoHeader extends StatelessWidget {
  final String title;
  final String description;

  const DemoHeader({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      color: Colors.blue.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue.shade700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

/// Stateless Widget: Static Info Card
/// This widget displays information that doesn't change.
class StaticInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const StaticInfoCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.blue.shade700, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// STATEFUL WIDGETS
// ============================================================================

/// Stateful Widget: Interactive Counter
/// This widget maintains a counter state and updates the UI on user interaction.
class InteractiveCounterWidget extends StatefulWidget {
  const InteractiveCounterWidget({Key? key}) : super(key: key);

  @override
  State<InteractiveCounterWidget> createState() =>
      _InteractiveCounterWidgetState();
}

class _InteractiveCounterWidgetState extends State<InteractiveCounterWidget> {
  int counter = 0;

  /// Increment the counter and trigger a rebuild
  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  /// Decrement the counter and trigger a rebuild
  void _decrementCounter() {
    setState(() {
      if (counter > 0) counter--;
    });
  }

  /// Reset the counter to 0
  void _resetCounter() {
    setState(() {
      counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        border: Border.all(color: Colors.green.shade300, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            'Interactive Counter (Stateful)',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900,
                ),
          ),
          const SizedBox(height: 20),

          /// Display Counter Value
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.shade200,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              '$counter',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
          ),
          const SizedBox(height: 20),

          /// Control Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /// Decrement Button
              ElevatedButton.icon(
                onPressed: _decrementCounter,
                icon: const Icon(Icons.remove),
                label: const Text('Decrease'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  foregroundColor: Colors.white,
                ),
              ),

              /// Reset Button
              ElevatedButton.icon(
                onPressed: _resetCounter,
                icon: const Icon(Icons.restart_alt),
                label: const Text('Reset'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade600,
                  foregroundColor: Colors.white,
                ),
              ),

              /// Increment Button
              ElevatedButton.icon(
                onPressed: _incrementCounter,
                icon: const Icon(Icons.add),
                label: const Text('Increase'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Click buttons to see the counter update in real-time!',
            style: TextStyle(
              fontSize: 12,
              color: Colors.green.shade700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

/// Stateful Widget: Color Changer
/// This widget maintains a color state and changes the UI background color.
class ColorChangerWidget extends StatefulWidget {
  const ColorChangerWidget({Key? key}) : super(key: key);

  @override
  State<ColorChangerWidget> createState() => _ColorChangerWidgetState();
}

class _ColorChangerWidgetState extends State<ColorChangerWidget> {
  List<Color> colors = [
    Colors.purple.shade400,
    Colors.pink.shade400,
    Colors.orange.shade400,
    Colors.teal.shade400,
    Colors.indigo.shade400,
  ];

  int currentColorIndex = 0;

  /// Change to the next color
  void _changeColor() {
    setState(() {
      currentColorIndex = (currentColorIndex + 1) % colors.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors[currentColorIndex].withOpacity(0.15),
        border: Border.all(
          color: colors[currentColorIndex],
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            'Color Changer (Stateful)',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors[currentColorIndex],
                ),
          ),
          const SizedBox(height: 20),

          /// Color Display Box
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: colors[currentColorIndex],
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: colors[currentColorIndex].withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          /// Color Name Display
          Text(
            _getColorName(colors[currentColorIndex]),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colors[currentColorIndex],
            ),
          ),
          const SizedBox(height: 20),

          /// Change Color Button
          ElevatedButton.icon(
            onPressed: _changeColor,
            icon: const Icon(Icons.palette),
            label: const Text('Change Color'),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors[currentColorIndex],
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  /// Helper method to get color name
  String _getColorName(Color color) {
    if (color == colors[0]) return 'Purple';
    if (color == colors[1]) return 'Pink';
    if (color == colors[2]) return 'Orange';
    if (color == colors[3]) return 'Teal';
    if (color == colors[4]) return 'Indigo';
    return 'Unknown';
  }
}
