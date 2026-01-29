import 'package:flutter/material.dart';

/// Responsive Layout Demo - Main Hub
/// Demonstrates responsive design using Rows, Columns, and Containers
class ResponsiveLayoutHub extends StatelessWidget {
  const ResponsiveLayoutHub({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    debugPrint('📱 Responsive Layout Hub:');
    debugPrint('   Width: ${screenWidth.toStringAsFixed(2)}');
    debugPrint('   Height: ${screenHeight.toStringAsFixed(2)}');
    debugPrint('   Orientation: ${isPortrait ? 'Portrait' : 'Landscape'}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Layouts'),
        backgroundColor: Colors.deepPurple.shade700,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Screen Info Card
              _ScreenInfoCard(
                width: screenWidth,
                height: screenHeight,
                isPortrait: isPortrait,
              ),
              const SizedBox(height: 24),

              /// Demo Navigation Cards
              const Text(
                'Layout Demonstrations',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              _DemoCard(
                title: 'Profile Card Layout',
                description: 'Card-based layout with image, text, and buttons',
                icon: Icons.person,
                color: Colors.blue,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProfileCardLayout(),
                    ),
                  );
                },
              ),

              _DemoCard(
                title: 'Dashboard Layout',
                description: 'Grid-based dashboard with responsive cards',
                icon: Icons.dashboard,
                color: Colors.green,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DashboardLayout(),
                    ),
                  );
                },
              ),

              _DemoCard(
                title: 'Product Page Layout',
                description: 'E-commerce style product page',
                icon: Icons.shopping_bag,
                color: Colors.orange,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProductPageLayout(),
                    ),
                  );
                },
              ),

              _DemoCard(
                title: 'Blog Post Layout',
                description: 'Article layout with flexible content areas',
                icon: Icons.article,
                color: Colors.purple,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BlogPostLayout(),
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

/// Screen Info Card - Shows current device metrics
class _ScreenInfoCard extends StatelessWidget {
  final double width;
  final double height;
  final bool isPortrait;

  const _ScreenInfoCard({
    required this.width,
    required this.height,
    required this.isPortrait,
  });

  @override
  Widget build(BuildContext context) {
    String deviceType;
    if (width < 600) {
      deviceType = 'Phone';
    } else if (width < 900) {
      deviceType = 'Tablet';
    } else {
      deviceType = 'Large Screen';
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📱 Device Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Device: $deviceType',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Width: ${width.toStringAsFixed(1)}px',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Height: ${height.toStringAsFixed(1)}px',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Orientation: ${isPortrait ? 'Portrait' : 'Landscape'}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Aspect: ${(width / height).toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Demo Card Widget
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
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 4,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
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
                  child: Icon(icon, color: color, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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

/// Profile Card Layout - Responsive card design
class ProfileCardLayout extends StatelessWidget {
  const ProfileCardLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Card Layout'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// Profile Card
              Container(
                width: isLargeScreen ? 500 : double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    /// Profile Image
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade200,
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: const Icon(Icons.person, size: 60),
                    ),
                    const SizedBox(height: 16),

                    /// Name and Title
                    const Text(
                      'Sarah Johnson',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'UI/UX Designer',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 12),

                    /// Bio
                    Text(
                      'Passionate about creating beautiful and intuitive user experiences.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 20),

                    /// Stats Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _StatItem(label: 'Posts', value: '128'),
                        _StatItem(label: 'Followers', value: '5.2K'),
                        _StatItem(label: 'Following', value: '342'),
                      ],
                    ),
                    const SizedBox(height: 20),

                    /// Action Buttons
                    isLargeScreen
                        ? Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                  ),
                                  child: const Text('Follow'),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                  ),
                                  child: const Text('Message'),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                  ),
                                  child: const Text('Follow'),
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                  ),
                                  child: const Text('Message'),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              /// Layout Info
              _LayoutInfoBox(
                title: 'Profile Card Features',
                features: [
                  'Centered card layout',
                  'Responsive width (500px on large screens)',
                  'Flexible button layout (Row on large, Column on small)',
                  'Stat items in responsive row',
                  'Shadow and border-radius styling',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Dashboard Layout - Multi-card responsive grid
class DashboardLayout extends StatelessWidget {
  const DashboardLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 900;
    final isMediumScreen = screenWidth > 600;

    int crossAxisCount;
    if (isLargeScreen) {
      crossAxisCount = 3;
    } else if (isMediumScreen) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 1;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Layout'),
        backgroundColor: Colors.green.shade700,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade300),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dashboard',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Welcome back! Here\'s your performance overview.',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              /// Responsive Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  final metrics = [
                    {'title': 'Users', 'value': '12,584', 'icon': Icons.people},
                    {
                      'title': 'Revenue',
                      'value': '\$45,231',
                      'icon': Icons.attach_money
                    },
                    {
                      'title': 'Orders',
                      'value': '1,234',
                      'icon': Icons.shopping_cart
                    },
                    {
                      'title': 'Growth',
                      'value': '+23%',
                      'icon': Icons.trending_up
                    },
                    {
                      'title': 'Bounce',
                      'value': '32%',
                      'icon': Icons.exit_to_app
                    },
                    {
                      'title': 'Visits',
                      'value': '98.5K',
                      'icon': Icons.visibility
                    },
                  ];

                  final metric = metrics[index];

                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          metric['icon'] as IconData,
                          size: 32,
                          color: Colors.green,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          metric['title'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          metric['value'] as String,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),

              /// Layout Info
              _LayoutInfoBox(
                title: 'Dashboard Features',
                features: [
                  'Responsive grid (1 col on phone, 2 on tablet, 3 on desktop)',
                  'Dynamic crossAxisCount based on screen width',
                  'Card-based metric display',
                  'Flexible spacing with MainAxisAlignment',
                  'Icon and text organization',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Product Page Layout - E-commerce style layout
class ProductPageLayout extends StatelessWidget {
  const ProductPageLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 900;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Page Layout'),
        backgroundColor: Colors.orange.shade700,
      ),
      body: isLargeScreen
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Image Section
                    Expanded(
                      child: Container(
                        height: 400,
                        decoration: BoxDecoration(
                          color: Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image,
                                size: 80,
                                color: Colors.orange.shade400,
                              ),
                              const SizedBox(height: 12),
                              const Text('Product Image'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),

                    /// Details Section
                    Expanded(
                      child: _ProductDetailsVertical(),
                    ),
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    /// Image Section
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image,
                              size: 80,
                              color: Colors.orange.shade400,
                            ),
                            const SizedBox(height: 12),
                            const Text('Product Image'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    /// Details Section
                    _ProductDetailsVertical(),
                  ],
                ),
              ),
            ),
    );
  }
}

/// Product Details Widget
class _ProductDetailsVertical extends StatelessWidget {
  const _ProductDetailsVertical();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Premium Wireless Headphones',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 20),
            const SizedBox(width: 4),
            const Text('4.8 (324 reviews)'),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'In Stock',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          '\$299.99',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Premium quality headphones with active noise cancellation, 30-hour battery life, and superior comfort.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),

        /// Quantity Selector
        Row(
          children: [
            const Text('Quantity:'),
            const SizedBox(width: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {},
                    iconSize: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('1'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {},
                    iconSize: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        /// Action Buttons
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Add to Cart'),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Add to Wishlist'),
          ),
        ),
      ],
    );
  }
}

/// Blog Post Layout
class BlogPostLayout extends StatelessWidget {
  const BlogPostLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxWidth = screenWidth > 800 ? 800.0 : double.infinity;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Post Layout'),
        backgroundColor: Colors.purple.shade700,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: maxWidth,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Article Header
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.purple.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          size: 80,
                          color: Colors.purple.shade400,
                        ),
                        const SizedBox(height: 12),
                        const Text('Featured Image'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                /// Article Title
                const Text(
                  'The Art of Responsive Web Design',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                /// Meta Information
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.purple.shade200,
                      child: const Icon(Icons.person),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sarah Anderson',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Jan 29, 2026 • 5 min read',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                /// Article Content
                const Text(
                  'In the modern era of mobile-first design, creating responsive layouts is essential. This article explores the fundamental principles of responsive design using Rows, Columns, and Containers.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.8,
                  ),
                ),
                const SizedBox(height: 20),

                /// Quote Section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    border: Border(
                      left: BorderSide(
                        color: Colors.purple,
                        width: 4,
                      ),
                    ),
                  ),
                  child: const Text(
                    '"Responsive design is not about creating a website that works on all devices. It\'s about creating a website that adapts gracefully to any device."',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                /// Content continued
                const Text(
                  'By understanding the power of MediaQuery, Expanded widgets, and flexible layouts, developers can create truly responsive experiences.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.8,
                  ),
                ),
                const SizedBox(height: 32),

                /// Tags
                Wrap(
                  spacing: 8,
                  children: [
                    _TagChip(label: 'Flutter'),
                    _TagChip(label: 'Responsive Design'),
                    _TagChip(label: 'UI/UX'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Stat Item Widget
class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

/// Layout Info Box
class _LayoutInfoBox extends StatelessWidget {
  final String title;
  final List<String> features;

  const _LayoutInfoBox({
    required this.title,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...features.map((feature) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, size: 16, color: Colors.blue),
                  const SizedBox(width: 8),
                  Expanded(child: Text(feature)),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

/// Tag Chip Widget
class _TagChip extends StatelessWidget {
  final String label;

  const _TagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.purple.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: Colors.purple.shade700,
        ),
      ),
    );
  }
}
