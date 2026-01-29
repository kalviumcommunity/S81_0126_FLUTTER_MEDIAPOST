import 'package:flutter/material.dart';

/// DevTools Demo Screen
/// Demonstrates effective use of:
/// 1. Hot Reload - Instant UI updates without restarting
/// 2. Debug Console - Logging with debugPrint()
/// 3. Flutter DevTools - Widget Inspector and Performance monitoring
class DevToolsDemoScreen extends StatelessWidget {
  const DevToolsDemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('🎯 DevToolsDemoScreen: Build method called');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hot Reload, Debug Console & DevTools Demo'),
        backgroundColor: Colors.purple.shade700,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Section 1: Hot Reload Demo
            _HotReloadDemoSection(),

            /// Section 2: Debug Console & Logging Demo
            _DebugConsoleDemoSection(),

            /// Section 3: Widget Inspector Demo
            _WidgetInspectorDemoSection(),

            /// Section 4: Performance Monitoring Demo
            _PerformanceMonitoringSection(),

            /// Section 5: Interactive Logging Examples
            const _InteractiveLoggingSection(),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION 1: HOT RELOAD DEMO
// ============================================================================

class _HotReloadDemoSection extends StatefulWidget {
  @override
  State<_HotReloadDemoSection> createState() => _HotReloadDemoSectionState();
}

class _HotReloadDemoSectionState extends State<_HotReloadDemoSection> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    debugPrint('📱 HotReloadDemoSection: initState called');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('🔄 HotReloadDemoSection: Rebuilding with isDarkMode=$_isDarkMode');

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _isDarkMode ? Colors.grey.shade900 : Colors.blue.shade50,
        border: Border.all(color: Colors.blue.shade300, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '1️⃣ HOT RELOAD DEMO',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _isDarkMode ? Colors.white : Colors.blue.shade900,
                ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _isDarkMode ? Colors.grey.shade800 : Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Try this: Modify the text below and save (Ctrl+S). '
                  'Watch it update instantly with Hot Reload!',
                  style: TextStyle(
                    fontSize: 13,
                    color: _isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '✨ This text updates with Hot Reload!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _isDarkMode ? Colors.amber : Colors.orange,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '🎨 Current Theme: ${_isDarkMode ? "Dark Mode" : "Light Mode"}',
                  style: TextStyle(
                    fontSize: 14,
                    color: _isDarkMode ? Colors.white : Colors.blue.shade900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
              });
              debugPrint(
                '🔘 Hot Reload Demo: Theme toggled to ${_isDarkMode ? "Dark" : "Light"}',
              );
            },
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
            label: Text(_isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _isDarkMode ? Colors.amber : Colors.blue.shade700,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    debugPrint('🗑️ HotReloadDemoSection: dispose called');
    super.dispose();
  }
}

// ============================================================================
// SECTION 2: DEBUG CONSOLE & LOGGING DEMO
// ============================================================================

class _DebugConsoleDemoSection extends StatefulWidget {
  @override
  State<_DebugConsoleDemoSection> createState() =>
      _DebugConsoleDemoSectionState();
}

class _DebugConsoleDemoSectionState extends State<_DebugConsoleDemoSection> {
  int _logCount = 0;
  List<String> _logs = [];

  void _addLog(String message) {
    setState(() {
      _logCount++;
      _logs.add('[$_logCount] $message');
      if (_logs.length > 5) {
        _logs.removeAt(0);
      }
    });
    debugPrint('📝 Debug Log #$_logCount: $message');
  }

  @override
  void initState() {
    super.initState();
    _addLog('DebugConsoleDemoSection initialized');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('🔄 DebugConsoleDemoSection: Rebuilding');

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        border: Border.all(color: Colors.green.shade300, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '2️⃣ DEBUG CONSOLE & LOGGING DEMO',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900,
                ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Open the Debug Console (VS Code: View → Debug Console) '
            'to see log messages as you interact with these buttons:',
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton.icon(
                onPressed: () => _addLog('Simple Log - User clicked button'),
                icon: const Icon(Icons.info),
                label: const Text('Simple Log'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  final timestamp = DateTime.now();
                  _addLog('Timestamp Log: $timestamp');
                },
                icon: const Icon(Icons.schedule),
                label: const Text('Log with Timestamp'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade600,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _addLog('Error Example: Something went wrong!');
                },
                icon: const Icon(Icons.error),
                label: const Text('Log Error'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade400),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Last Logs (also visible in Debug Console):',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade400,
                  ),
                ),
                const SizedBox(height: 8),
                if (_logs.isEmpty)
                  Text(
                    'Click buttons to generate logs...',
                    style: TextStyle(color: Colors.grey.shade600),
                  )
                else
                  ..._logs.map((log) => Text(
                    log,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.green.shade300,
                      fontFamily: 'Courier',
                    ),
                  )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 3: WIDGET INSPECTOR DEMO
// ============================================================================

class _WidgetInspectorDemoSection extends StatelessWidget {
  const _WidgetInspectorDemoSection();

  @override
  Widget build(BuildContext context) {
    debugPrint('🔍 WidgetInspectorDemoSection: Build called');

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        border: Border.all(color: Colors.orange.shade300, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '3️⃣ WIDGET INSPECTOR DEMO (DevTools)',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade900,
                ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'How to use Widget Inspector:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                _InspectorStep(
                  number: 1,
                  title: 'Launch DevTools',
                  description:
                      'Run: flutter pub global run devtools (or use VS Code extension)',
                ),
                _InspectorStep(
                  number: 2,
                  title: 'Open Widget Inspector Tab',
                  description: 'Navigate to the "Inspector" tab in DevTools',
                ),
                _InspectorStep(
                  number: 3,
                  title: 'Click "Select Widget Mode"',
                  description:
                      'Then click any widget in your app to inspect its properties',
                ),
                _InspectorStep(
                  number: 4,
                  title: 'View Widget Tree',
                  description:
                      'See the complete hierarchy of widgets in the left panel',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '💡 Widget Inspector Tips:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                SizedBox(height: 8),
                Text(
                  '• Use to debug layout issues and widget hierarchy\n'
                  '• Inspect properties like size, padding, alignment\n'
                  '• Identify unused widgets or performance bottlenecks\n'
                  '• Click "Analyze App Size" to optimize bundle size',
                  style: TextStyle(fontSize: 12, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InspectorStep extends StatelessWidget {
  final int number;
  final String title;
  final String description;

  const _InspectorStep({
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
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: Colors.orange.shade700,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$number',
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
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
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

// ============================================================================
// SECTION 4: PERFORMANCE MONITORING
// ============================================================================

class _PerformanceMonitoringSection extends StatefulWidget {
  @override
  State<_PerformanceMonitoringSection> createState() =>
      _PerformanceMonitoringSectionState();
}

class _PerformanceMonitoringSectionState
    extends State<_PerformanceMonitoringSection> {
  int _rebuildCount = 0;
  final Stopwatch _stopwatch = Stopwatch();

  @override
  void initState() {
    super.initState();
    debugPrint('⚡ PerformanceMonitoringSection: initState - Starting stopwatch');
    _stopwatch.start();
  }

  @override
  Widget build(BuildContext context) {
    _rebuildCount++;
    debugPrint(
      '📊 PerformanceMonitoringSection: Rebuild #$_rebuildCount, Elapsed: ${_stopwatch.elapsedMilliseconds}ms',
    );

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        border: Border.all(color: Colors.red.shade300, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '4️⃣ PERFORMANCE MONITORING (DevTools)',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade900,
                ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Performance Metrics:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                _MetricRow(
                  label: 'Rebuild Count',
                  value: '$_rebuildCount',
                  icon: Icons.repeat,
                ),
                _MetricRow(
                  label: 'Elapsed Time',
                  value: '${_stopwatch.elapsedMilliseconds}ms',
                  icon: Icons.timer,
                ),
                _MetricRow(
                  label: 'App Lifecycle',
                  value: 'Running',
                  icon: Icons.show_chart,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '📈 Performance Tab Features:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                SizedBox(height: 8),
                Text(
                  '• Frame Rendering Times: Monitor 60 FPS compliance\n'
                  '• Memory Usage: Track RAM consumption\n'
                  '• CPU Usage: Identify performance bottlenecks\n'
                  '• Timeline: Visualize app execution flow\n'
                  '• Janky Frames: Detect stutters and lag',
                  style: TextStyle(fontSize: 12, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    debugPrint(
      '🏁 PerformanceMonitoringSection: dispose - Total elapsed: ${_stopwatch.elapsedMilliseconds}ms',
    );
    _stopwatch.stop();
    super.dispose();
  }
}

class _MetricRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _MetricRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.red.shade600, size: 20),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red.shade200,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 5: INTERACTIVE LOGGING EXAMPLES
// ============================================================================

class _InteractiveLoggingSection extends StatefulWidget {
  const _InteractiveLoggingSection();

  @override
  State<_InteractiveLoggingSection> createState() =>
      _InteractiveLoggingSectionState();
}

class _InteractiveLoggingSectionState extends State<_InteractiveLoggingSection> {
  String _currentLog = '';
  TextEditingController? _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    debugPrint('📝 InteractiveLoggingSection: initState');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('🔄 InteractiveLoggingSection: Build called');

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        border: Border.all(color: Colors.teal.shade300, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '5️⃣ INTERACTIVE LOGGING EXAMPLES',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade900,
                ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Type a message and press "Log" to see how debugPrint() '
            'works in the Debug Console:',
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Enter a custom message to log...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.all(12),
            ),
            onChanged: (value) {
              debugPrint('🔤 Text Input Changed: "$value"');
            },
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {
              final message = _textController?.text ?? 'No message';
              setState(() {
                _currentLog = message;
              });
              debugPrint('🔵 Custom Log: $message');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Logged: $message'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            icon: const Icon(Icons.send),
            label: const Text('Log Message'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal.shade600,
            ),
          ),
          if (_currentLog.isNotEmpty) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Last Logged Message:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _currentLog,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.teal.shade900,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.teal.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '💾 Best Practices for Logging:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                SizedBox(height: 8),
                Text(
                  '1. Use debugPrint() instead of print() for better formatting\n'
                  '2. Include context and timestamps in logs\n'
                  '3. Use emojis/prefixes to categorize logs\n'
                  '4. Remove or comment out debug logs before release\n'
                  '5. Check the Debug Console to track execution flow',
                  style: TextStyle(fontSize: 12, height: 1.6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    debugPrint('🗑️ InteractiveLoggingSection: dispose called');
    _textController?.dispose();
    super.dispose();
  }
}
