import 'package:flutter/material.dart';

/// Navigation Profile Screen
/// Demonstrates data passing between screens using route arguments
class NavigationProfileScreen extends StatelessWidget {
  const NavigationProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieve data passed from previous screen
    final passedData = ModalRoute.of(context)?.settings.arguments as String?;
    
    debugPrint('👤 NavigationProfileScreen: Build called');
    debugPrint('📨 NavigationProfileScreen: Received data: $passedData');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Screen'),
        backgroundColor: Colors.green.shade600,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            debugPrint('🔙 NavigationProfileScreen: Popping back');
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
              /// Profile Header
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.green.shade400,
                            Colors.green.shade600,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'User Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Data Passed Successfully',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              /// Received Data Card
              Card(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green.shade50, Colors.green.shade100],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '📥 Data Received',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green.shade300),
                        ),
                        child: Text(
                          passedData ?? 'No data passed',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// How Data Passing Works
              const Text(
                'How Data Passing Works',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              _ProcessStep(
                number: '1',
                title: 'Send Data',
                description: 'Use arguments parameter in pushNamed',
                code: '''Navigator.pushNamed(
  context,
  '/profile',
  arguments: 'Data string',
);''',
              ),

              _ProcessStep(
                number: '2',
                title: 'Access Route Settings',
                description: 'Get ModalRoute of current context',
                code: '''final args = ModalRoute.of(context)
    ?.settings.arguments;''',
              ),

              _ProcessStep(
                number: '3',
                title: 'Cast & Use Data',
                description: 'Type cast to expected type and use',
                code: '''final data = args as String?;
print(data); // "Data string"''',
              ),

              const SizedBox(height: 24),

              /// Data Types Support
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '📚 Supported Data Types',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _DataTypeItem(
                      type: 'String',
                      example: "'Hello World'",
                    ),
                    _DataTypeItem(
                      type: 'int',
                      example: '42',
                    ),
                    _DataTypeItem(
                      type: 'Map',
                      example: "{'name': 'John', 'age': 30}",
                    ),
                    _DataTypeItem(
                      type: 'List',
                      example: '[1, 2, 3, 4, 5]',
                    ),
                    _DataTypeItem(
                      type: 'Custom Class',
                      example: 'UserModel(name: "John")',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// Navigation History
              const Text(
                'Navigation History',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              _NavigationStep(
                step: 1,
                screen: 'Home Screen',
                action: 'Initial route',
                icon: Icons.home,
              ),

              Container(
                width: 2,
                height: 20,
                color: Colors.grey.shade400,
                margin: const EdgeInsets.symmetric(horizontal: 20),
              ),

              _NavigationStep(
                step: 2,
                screen: 'Profile Screen',
                action: 'Pushed with arguments',
                icon: Icons.arrow_downward,
              ),

              const SizedBox(height: 24),

              /// Action Buttons
              ElevatedButton.icon(
                icon: const Icon(Icons.arrow_back),
                label: const Text('Go Back'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: 12),

              OutlinedButton.icon(
                icon: const Icon(Icons.home),
                label: const Text('Return to Home Screen'),
                onPressed: () {
                  debugPrint('🏠 NavigationProfileScreen: Navigate home with pop all');
                  Navigator.of(context).popUntil(
                    (route) => route.isFirst,
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

/// Process Step Widget
class _ProcessStep extends StatelessWidget {
  final String number;
  final String title;
  final String description;
  final String code;

  const _ProcessStep({
    required this.number,
    required this.title,
    required this.description,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.green.shade600,
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
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  code,
                  style: TextStyle(
                    color: Colors.green.shade300,
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Data Type Item Widget
class _DataTypeItem extends StatelessWidget {
  final String type;
  final String example;

  const _DataTypeItem({
    required this.type,
    required this.example,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.shade600,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              type,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              example,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Navigation Step Widget
class _NavigationStep extends StatelessWidget {
  final int step;
  final String screen;
  final String action;
  final IconData icon;

  const _NavigationStep({
    required this.step,
    required this.screen,
    required this.action,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.green.shade600,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(icon, color: Colors.white, size: 20),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                screen,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                action,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
